function terminal_color() {
    colors=(blue red yellow cyan green)
    root_color=magenta

    if [ "$(whoami)" = "root" ]; then
        echo $root_color
    else
        case "$(hostname)" in
            markus-* )
                index=1
                ;;
            zfix* )
                index=2
                ;;
            * )
                index=$(echo $(whoami)$(hostname) | md5sum | awk '{print substr($1,0,5)}' | perl -pe "\$_=hex;\$_=\$_%(${#colors[@]})+1")
                ;;
        esac
        echo $colors[$index]
    fi
}

# vi-mode
MODE_INDICATOR="%{$fg_bold[blue]%}<<%{$reset_color%}"

setopt prompt_subst
autoload -Uz vcs_info
vcs_info_precmd() {
    vcs_info
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions vcs_info_precmd)

zstyle ':vcs_info:*' use-simple false
zstyle ':vcs_info:*' get-revision false
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "!"
zstyle ':vcs_info:*' unstagedstr "?"
zstyle ':vcs_info:*' hgrevformat "%r"
zstyle ':vcs_info:*' branchformat "%b %r"
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
%{$fg[blue]%}%s%{$reset_color%}\
 \
%{$fg_bold[yellow]%}%b%{$reset_color%}\
%{$fg_bold[red]%}%u%c %a%{$reset_color%}\
 \
"

PROMPT=\
"\
%{$fg_bold[\
$(terminal_color)\
]%}%n@%m%{$reset_color%}\
 %{$fg_bold[green]%}%~%{$reset_color%}\
 \${vcs_info_msg_0_}\
%{$fg_bold[yellow]%}
λ%{$reset_color%} \
"

RPROMPT=\
"\
\$(vi_mode_prompt_info)\
 %{$fg_bold[red]%}%?%{$reset_color%}\
 %{$fg_bold[yellow]%}[%*]%{$reset_color%}\
"
