#!/usr/bin/env bash
# sync-skills.sh - Mirror this repo's skills/<name>/SKILL.md into the three
# local buzz-acp discovery roots and (re-)create the symlinks that point at
# each skill's directory. Idempotent: safe to run after every `git pull`.
#
# Path-agnostic via $HOME, so the same script works for `acidburn` on the
# macmini and `madmin` on the macbook without per-machine edits.
#
# Roots wired:
#   $HOME/.agents/skills/<name>           - canonical copy of SKILL.md
#   $HOME/.buzz/.agents/skills/<name>     - symlink -> $HOME/.agents/skills/<name>
#   $HOME/.claude/skills/<name>           - symlink -> $HOME/.agents/skills/<name>
#
# Buzz-acp discovery roots per RESEARCH/SKILL_DISCOVERY_GAP_2026-08-25.md.

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_SRC="$REPO/skills"

HOME1="$HOME/.agents/skills"
HOME2="$HOME/.buzz/.agents/skills"
HOME3="$HOME/.claude/skills"

if [ ! -d "$SKILLS_SRC" ]; then
  echo "ERROR: $SKILLS_SRC not found. Run this script from inside the thnkbig/skills repo." >&2
  exit 1
fi

mkdir -p "$HOME1" "$HOME2" "$HOME3"

synced=0
skipped=0
for src_dir in "$SKILLS_SRC"/*/; do
  [ -d "$src_dir" ] || continue
  name="$(basename "$src_dir")"
  src_md="$src_dir/SKILL.md"

  if [ ! -f "$src_md" ]; then
    skipped=$((skipped + 1))
    continue
  fi

  dst_dir="$HOME1/$name"
  dst_md="$dst_dir/SKILL.md"

  mkdir -p "$dst_dir"

  if [ ! -f "$dst_md" ] || ! diff -q "$src_md" "$dst_md" >/dev/null 2>&1; then
    cp "$src_md" "$dst_md"
  fi

  ln -sfn "$HOME1/$name" "$HOME2/$name"
  ln -sfn "$HOME1/$name" "$HOME3/$name"

  synced=$((synced + 1))
done

echo "Synced $synced skill(s) from $SKILLS_SRC/ into:"
echo "  - $HOME1  (canonical copies)"
echo "  - $HOME2  (symlinks)"
echo "  - $HOME3  (symlinks)"
if [ "$skipped" -gt 0 ]; then
  echo "Skipped $skipped director(y/ies) without a SKILL.md"
fi