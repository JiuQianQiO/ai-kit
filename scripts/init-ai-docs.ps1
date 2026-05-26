# Init AI docs from ai-kit into a target project root.
# NOTE: Always copies Cursor .mdc + generic templates only. Does NOT create CLAUDE.md or Trae rules.
#       For multi-tool setup, run START_HERE interview or GENERATE_FROM_BRIEF after filling PROJECT_BRIEF.
# Usage:
#   .\init-ai-docs.ps1 -TargetPath D:\work\my-app [-ProjectName MyApp] [-OnlyIfMissing] [-Force]
#   .\init-ai-docs.ps1 -UseProjectRoot [-ProjectName MyApp]   # when ai-kit lives in repo root\ai-kit
param(
    [string] $TargetPath = "",

    [string] $ProjectName = "",

    [switch] $UseProjectRoot,

    [switch] $OnlyIfMissing,

    [switch] $Force
)

$ErrorActionPreference = "Stop"

$KitRoot = Split-Path $PSScriptRoot -Parent
$versionFile = Join-Path $KitRoot "VERSION"
if (-not (Test-Path $versionFile)) {
    throw "ai-kit root not found (missing VERSION). Run from ai-kit/scripts."
}

if ($UseProjectRoot) {
    $TargetPath = Split-Path $KitRoot -Parent
}
if ([string]::IsNullOrWhiteSpace($TargetPath)) {
    throw "Specify -TargetPath or -UseProjectRoot (ai-kit must be under project root)."
}

if ($PSCmdlet) {
    $TargetPath = $PSCmdlet.SessionState.Path.GetUnresolvedProviderPathFromPSPath($TargetPath)
} else {
    $TargetPath = [System.IO.Path]::GetFullPath($TargetPath)
}
if (-not (Test-Path $TargetPath)) {
    New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
}

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    $ProjectName = Split-Path $TargetPath -Leaf
}

$Version = (Get-Content $versionFile -Raw).Trim()
$cnTz = [TimeZoneInfo]::FindSystemTimeZoneById('China Standard Time')
$nowCn = [TimeZoneInfo]::ConvertTimeFromUtc([DateTime]::UtcNow, $cnTz)
$Today = $nowCn.ToString('yyyy-MM-dd')
$DateTime = $nowCn.ToString('yyyy-MM-dd HH:mm:ss')

function Replace-Placeholders {
    param([string] $Text)
    $Text = $Text -replace '\{\{PROJECT_NAME\}\}', $ProjectName
    $Text = $Text -replace '\{\{LAST_UPDATED\}\}', $Today
    $Text = $Text -replace '\{\{INIT_DATETIME\}\}', $DateTime
    $Text = $Text -replace '\{\{AI_KIT_VERSION\}\}', $Version
    $initPaths = 'PROJECT_BRIEF.md`、`AGENTS.md`、`PROGRESS.md`、`DETAIL.md`、`ARCHITECTURE.md`、`.cursor/rules/progress-auto-update.mdc'
    $Text = $Text -replace '\{\{INIT_PATHS_LIST\}\}', $initPaths
    return $Text
}

function Copy-TemplateFile {
    param(
        [string] $SourceRelative,
        [string] $DestFileName
    )
    $src = Join-Path $KitRoot $SourceRelative
    $dest = Join-Path $TargetPath $DestFileName
    if (-not (Test-Path $src)) {
        throw "Template not found: $src"
    }
    if ((Test-Path $dest) -and $OnlyIfMissing -and -not $Force) {
        Write-Host "skip (exists): $dest"
        return
    }
    if ((Test-Path $dest) -and -not $Force -and -not $OnlyIfMissing) {
        Write-Warning "overwriting: $dest (use -OnlyIfMissing to skip)"
    }
    $content = Get-Content $src -Raw -Encoding UTF8
    $content = Replace-Placeholders $content
    if ($content -match '\{\{[A-Z0-9_]+\}\}') {
        $banner = @"
> **注意**：本文件由 ``ai-kit`` init 脚本生成，仍含未替换的 ``{{占位符}}``。  
> 请 @ ``ai-kit/START_HERE.md`` 完成访谈后再覆盖；勿将本文件当作最终规范。

"@
        if ($content -notmatch 'ai-kit.*init') {
            $content = $banner + $content
        }
    }
    $destDir = Split-Path $dest -Parent
    if ($destDir -and -not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    [System.IO.File]::WriteAllText($dest, $content, [System.Text.UTF8Encoding]::new($false))
    Write-Host "wrote: $dest"
}

function Copy-RuleFile {
    $src = Join-Path $KitRoot "rules\progress-auto-update.mdc"
    $dest = Join-Path $TargetPath ".cursor\rules\progress-auto-update.mdc"
    if (-not (Test-Path $src)) {
        throw "Rule file not found: $src"
    }
    if ((Test-Path $dest) -and $OnlyIfMissing -and -not $Force) {
        Write-Host "skip (exists): $dest"
        return
    }
    $destDir = Split-Path $dest -Parent
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    Copy-Item -Path $src -Destination $dest -Force
    $ruleContent = Get-Content $dest -Raw -Encoding UTF8
    $ruleContent = [regex]::Replace($ruleContent, 'alwaysApply:\s*false', 'alwaysApply: true', 1)
    [System.IO.File]::WriteAllText($dest, $ruleContent, [System.Text.UTF8Encoding]::new($false))
    Write-Host "wrote: $dest (alwaysApply: true at project root)"
}

Write-Host "ai-kit $Version -> $TargetPath (project: $ProjectName)"

Copy-TemplateFile "templates\AGENTS.base.md" "AGENTS.md"
Copy-TemplateFile "templates\PROGRESS.template.md" "PROGRESS.md"
Copy-TemplateFile "templates\DETAIL.template.md" "DETAIL.md"
Copy-TemplateFile "templates\ARCHITECTURE.template.md" "ARCHITECTURE.md"
Copy-RuleFile

Write-Host ""
Write-Host "Done. Init always includes Cursor .mdc only; CLAUDE.md / Trae rules need START_HERE or GENERATE_FROM_BRIEF."
Write-Host "Output may still contain {{placeholders}} — run START_HERE.md interview before use."
