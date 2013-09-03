function hg_prompt_info {
hg prompt > /dev/null 2>&1;
if [ $? = 0 ]; then
    hg prompt --angle-brackets "\
%{$fg_bold[blue]%}<update>%{$reset_color%}\
%{$fg_bold[red]%}<status|modified|unknown>%{$reset_color%}\
%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>%{$reset_color%}" 2>/dev/null
fi
}

function terminal_color {
colors=(blue red yellow cyan magenta)
case "$(hostname)" in
    markus-W510 )
        index=1
        ;;
    h1949215.stratoserver.net )
        index=2
        ;;
    Markus-PC )
        index=3
        ;;
    * )
        index=$(echo $(whoami)$(hostname) | sha256sum | awk '{print substr($1,0,5)}' | perl -pe '$_=hex;$_=$_%5+1')
        ;;
esac
if [ "$(whoami)" = "root" ]; then
    index=5
fi
echo $colors[$index]
}

PROMPT='%{$fg_bold[$(terminal_color)]%}%n@%m%{$reset_color%} %{$fg_bold[green]%}%~%{$reset_color%}$(hg_prompt_info) $(git_prompt_info)%{$fg_bold[yellow]%}λ%{$reset_color%} '
RPROMPT='%{$fg_bold[red]%}%?%{$reset_color%} %{$fg_bold[yellow]%}[%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
