function terminal_color {
colors=(blue red yellow cyan green magenta)
case "$(hostname)" in
    markus-w510 )
        index=1
        ;;
    h1949215.stratoserver.net )
        index=2
        ;;
    markus-pc )
        index=3
        ;;
    * )
        index=$(echo $(whoami)$(hostname) | sha256sum | awk '{print substr($1,0,5)}' | perl -pe "\$_=hex;\$_=\$_%(${#colors[@]}-1)+1")
        ;;
esac
if [ "$(whoami)" = "root" ]; then
    index=${#colors[@]}
fi
echo $colors[$index]
}

# vi-mode
MODE_INDICATOR="%{$fg_bold[blue]%}<<%{$reset_color%}"

setopt prompt_subst
autoload -Uz vcs_info
vcs_info_precmd()
{
    vcs_info
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions vcs_info_precmd)

zstyle ':vcs_info:*' use-simple false
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "!"
zstyle ':vcs_info:*' unstagedstr "?"
zstyle ':vcs_info:*' hgrevformat "%r"
zstyle ':vcs_info:*' branchformat "%r"
zstyle ':vcs_info:*' formats \
"\
%{$fg[blue]%}%s%{$reset_color%}\
 \
%{$fg_bold[yellow]%}%b%{$reset_color%}\
%{$fg_bold[red]%}%u%c%{$reset_color%}\
 \
"
zstyle ':vcs_info:*' actionformats \
"\
 \
%{$fg[blue]%}%s%{$reset_color%}\
%{$fg_bold[red]%}%u%c%a%{$reset_color%}\
 \
"

# Is there a better way?
PROMPT='%{$fg_bold['
PROMPT+=$(terminal_color)
PROMPT+=']%}%n@%m%{$reset_color%} %{$fg_bold[green]%}%~%{$reset_color%} ${vcs_info_msg_0_}%{$fg_bold[yellow]%}λ%{$reset_color%} '

RPROMPT='%{$fg_bold[blue]%}$(vi_mode_prompt_info)%{$reset_color%} %{$fg_bold[red]%}%?%{$reset_color%} %{$fg_bold[yellow]%}[%*]%{$reset_color%}'
