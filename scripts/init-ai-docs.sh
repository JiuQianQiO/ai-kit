#!/usr/bin/env bash
# 将 ai-kit 模板与 Cursor 规则复制到目标项目根目录。
# 注意：仅 Cursor .mdc + 通用模板；不生成 CLAUDE.md / Trae 规则。多工具请走访谈或 GENERATE_FROM_BRIEF。
#
# 用法:
#   ./init-ai-docs.sh -t /path/to/target [-n ProjectName] [--only-if-missing] [-f]
#
set -euo pipefail

TARGET=""
PROJECT_NAME=""
ONLY_IF_MISSING=0
FORCE=0
USE_PROJECT_ROOT=0

usage() {
  echo "Usage: $0 (-t TARGET_PATH | --use-project-root) [-n PROJECT_NAME] [--only-if-missing] [-f|--force]"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -t) TARGET="$2"; shift 2 ;;
    -n) PROJECT_NAME="$2"; shift 2 ;;
    --use-project-root) USE_PROJECT_ROOT=1; shift ;;
    --only-if-missing) ONLY_IF_MISSING=1; shift ;;
    -f|--force) FORCE=1; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ $USE_PROJECT_ROOT -eq 1 ]]; then
  TARGET="$(cd "$KIT_ROOT/.." && pwd)"
fi

[[ -z "$TARGET" ]] && usage

if [[ ! -f "$KIT_ROOT/VERSION" ]]; then
  echo "error: ai-kit root not found (missing VERSION)" >&2
  exit 1
fi

mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

if [[ -z "$PROJECT_NAME" ]]; then
  PROJECT_NAME="$(basename "$TARGET")"
fi

VERSION="$(tr -d '[:space:]' < "$KIT_ROOT/VERSION")"
TODAY="$(TZ=Asia/Shanghai date +%Y-%m-%d)"
DATETIME="$(TZ=Asia/Shanghai date '+%Y-%m-%d %H:%M:%S')"

INIT_PATHS_LIST='PROJECT_BRIEF.md`、`AGENTS.md`、`PROGRESS.md`、`DETAIL.md`、`ARCHITECTURE.md`、`.cursor/rules/progress-auto-update.mdc'

replace_placeholders() {
  sed \
    -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
    -e "s/{{LAST_UPDATED}}/$TODAY/g" \
    -e "s/{{INIT_DATETIME}}/$DATETIME/g" \
    -e "s/{{AI_KIT_VERSION}}/$VERSION/g" \
    -e "s/{{INIT_PATHS_LIST}}/$INIT_PATHS_LIST/g"
}

write_template() {
  local src_rel="$1"
  local dest_name="$2"
  local src="$KIT_ROOT/$src_rel"
  local dest="$TARGET/$dest_name"

  [[ -f "$src" ]] || { echo "missing template: $src" >&2; exit 1; }

  if [[ -f "$dest" && $ONLY_IF_MISSING -eq 1 && $FORCE -eq 0 ]]; then
    echo "skip (exists): $dest"
    return
  fi

  mkdir -p "$(dirname "$dest")"
  local content
  content="$(replace_placeholders < "$src")"
  if echo "$content" | grep -qE '\{\{[A-Z0-9_]+\}\}'; then
    if ! echo "$content" | grep -q 'ai-kit.*init'; then
      content="> **注意**：本文件由 \`ai-kit\` init 生成，仍含 \`{{占位符}}\`。请 @ \`ai-kit/START_HERE.md\` 完成访谈后再覆盖。

${content}"
    fi
  fi
  printf '%s' "$content" > "$dest"
  echo "wrote: $dest"
}

write_rule() {
  local src="$KIT_ROOT/rules/progress-auto-update.mdc"
  local dest="$TARGET/.cursor/rules/progress-auto-update.mdc"

  [[ -f "$src" ]] || { echo "missing rule: $src" >&2; exit 1; }

  if [[ -f "$dest" && $ONLY_IF_MISSING -eq 1 && $FORCE -eq 0 ]]; then
    echo "skip (exists): $dest"
    return
  fi

  mkdir -p "$(dirname "$dest")"
  sed '0,/alwaysApply:[[:space:]]*false/s//alwaysApply: true/' "$src" > "$dest"
  echo "wrote: $dest (alwaysApply: true at project root)"
}

echo "ai-kit $VERSION -> $TARGET (project: $PROJECT_NAME)"

write_template "templates/AGENTS.base.md" "AGENTS.md"
write_template "templates/PROGRESS.template.md" "PROGRESS.md"
write_template "templates/DETAIL.template.md" "DETAIL.md"
write_template "templates/ARCHITECTURE.template.md" "ARCHITECTURE.md"
write_rule

echo ""
echo "Done. Init always includes Cursor .mdc only; CLAUDE.md / Trae rules need START_HERE or GENERATE_FROM_BRIEF."
echo "Output may still contain {{placeholders}} — run START_HERE.md interview before use."
