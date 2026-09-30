#!/bin/bash
# Claude Code statusLine: starship's claude-code provider, plus Pro/Max
# subscription rate-limit usage (starship has no module for this yet since
# rate_limits.* only appears in Claude Code's statusline JSON after the
# first API response of a session for Pro/Max subscribers).

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir')
starship_out=$(printf '%s' "$input" | starship statusline claude-code)
starship_out=${starship_out#$'\n'}   # this call emits a stray leading blank line
# starship's `-p/--path` only steers git detection, not the directory
# module's displayed path, so cd into cwd instead to get the real prompt.
left_out=$(cd "$cwd" 2>/dev/null && env -u STARSHIP_SHELL STARSHIP_CONFIG="$script_dir/starship-left.toml" starship prompt --terminal-width 200)

five=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

RESET=$'\033[0m'

# Same bold green/yellow/red escalation claude_cost/claude_context use,
# just keyed off a 0-100 percentage instead of a dollar amount.
usage_color() {
  pct="$1"
  if awk -v p="$pct" 'BEGIN{exit !(p>=80)}'; then
    printf '\033[1;31m'   # red
  elif awk -v p="$pct" 'BEGIN{exit !(p>=50)}'; then
    printf '\033[1;33m'   # yellow
  else
    printf '\033[1;32m'   # green
  fi
}

# VS16 (️) forces the filled emoji-style glyph instead of the
# default outline/text-style presentation of these two characters.
SYM_5H=$'⏱️'   # ⏱️
SYM_7D=$'\U1F5D3️'  # 🗓️

seg=""
if [ -n "$five" ]; then
  pct=$(LC_ALL=C printf '%.0f' "$five")
  seg="$(usage_color "$five")${SYM_5H} ${pct}%${RESET}"
fi
if [ -n "$week" ]; then
  pct=$(LC_ALL=C printf '%.0f' "$week")
  wseg="$(usage_color "$week")${SYM_7D} ${pct}%${RESET}"
  seg="${seg:+$seg  }$wseg"
fi

if [ -n "$seg" ]; then
  printf '%s %s %s' "$left_out" "$starship_out" "$seg"
else
  printf '%s %s' "$left_out" "$starship_out"
fi
