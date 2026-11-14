#!/bin/bash
# Claude Code statusLine: starship's claude-code provider, plus Pro/Max
# subscription rate-limit usage (starship has no module for this yet since
# rate_limits.* only appears in Claude Code's statusline JSON after the
# first API response of a session for Pro/Max subscribers).

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir')
# One starship call renders the whole powerline chain (see the claude-code
# profile in starship-statusline.toml). starship's `-p/--path` only steers git
# detection, not the directory module's displayed path, so cd into cwd.
starship_out=$(cd "$cwd" 2>/dev/null; printf '%s' "$input" | env -u STARSHIP_SHELL STARSHIP_CONFIG="$script_dir/starship-statusline.toml" starship statusline claude-code)
starship_out=${starship_out#$'\n'}   # this call emits a stray leading blank line

five=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Truecolor escapes matching the gruvbox palette in starship-statusline.toml.
# The rate-limit segments continue the color_bg3 segment starship ends on.
RESET=$'\033[0m'
BG3=$'\033[48;2;102;92;84m'
# Reset first so the cap sits on the terminal background, not on BG3.
CAP=$'\033[0;38;2;102;92;84m\xee\x82\xb4'   # U+E0B4 round cap in color_bg3

# Same bright green/yellow/red escalation claude_context/claude_cost use,
# just keyed off a 0-100 percentage.
usage_color() {
  pct="$1"
  if awk -v p="$pct" 'BEGIN{exit !(p>=80)}'; then
    printf '\033[1;38;2;251;73;52m'    # color_bright_red
  elif awk -v p="$pct" 'BEGIN{exit !(p>=50)}'; then
    printf '\033[1;38;2;250;189;47m'   # color_bright_yellow
  else
    printf '\033[1;38;2;184;187;38m'   # color_bright_green
  fi
}

# Nerd Font glyphs as UTF-8 bytes: bash 3.2 has no \U escapes.
SYM_5H=$'\xf3\xb0\x94\x9f'   # U+F051F nf-md-timer_sand
SYM_7D=$'\xf3\xb0\x83\xad'   # U+F00ED nf-md-calendar

seg=""
if [ -n "$five" ]; then
  pct=$(LC_ALL=C printf '%.0f' "$five")
  seg="${seg}${BG3}$(usage_color "$five") ${SYM_5H} ${pct}% "
fi
if [ -n "$week" ]; then
  pct=$(LC_ALL=C printf '%.0f' "$week")
  seg="${seg}${BG3}$(usage_color "$week") ${SYM_7D} ${pct}% "
fi

printf '%s%s%s%s' "$starship_out" "$seg" "$CAP" "$RESET"
