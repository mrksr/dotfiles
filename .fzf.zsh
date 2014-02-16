#####################
#  See fzf webpace  #
#####################

# CTRL-T - Paste the selected file path(s) into the command line
fzf-file-widget() {
  local FILES
  local IFS="
"
  FILES=($(
    find * -path '*/\.*' -prune \
    -o -type f -print \
    -o -type l -print 2> /dev/null | fzf -m))
  unset IFS
  FILES=$FILES:q
  LBUFFER="${LBUFFER%% #} $FILES"
  zle redisplay
}
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

# ALT-C - cd into the selected directory
#fzf-cd-widget() {
  #cd "${$(find * -path '*/\.*' -prune \
          #-o -type d -print 2> /dev/null | fzf):-.}"
  #zle reset-prompt
#}
#zle     -N    fzf-cd-widget
#bindkey '\ec' fzf-cd-widget

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  LBUFFER=$(history | fzf +s | sed "s/ *[0-9]* *//")
  zle redisplay
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget
