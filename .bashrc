# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -f ~/.bash_alias ]] && . ~/.bash_alias
[[ -f /usr/bin/sudo ]] && complete -cf sudo
[[ -f /usr/bin/man ]] && complete -cf man

# PS
OS=`uname`

PS() {
    export GIT_PS1_SHOWDIRTYSTATE=1i
    # bash prompt color
    # https://wiki.archlinux.org/index.php/Bash/Prompt_customization
    # https://misc.flogisoft.com/bash/tip_colors_and_formatting
    if [[ $- == *i* ]]; then
        green=$(tput setaf 2)   # \e[32m
        yellow=$(tput setaf 3)
        reset=$(tput sgr0)
    fi
    git_ps1() {
        if hash __git_ps1 2>/dev/null; then
            __git_ps1;
        fi
    }
    export PS1='\[$yellow\]\t \[$green\]\h:\w\[$yellow\]\[$(git_ps1)\] \[$green\]\$\[$reset\] '
    #export LANG="en_US.UTF-8"
}

run_ccal() {
    if which ccal &> /dev/null; then
        tty | grep -i -E 'tty|pts' &> /dev/null && ccal -u
    fi
}

case $OS in
    Darwin)
        [[ -f $(xcode-select -p)/usr/share/git-core/git-prompt.sh ]] && . $(xcode-select -p)/usr/share/git-core/git-prompt.sh
        [[ ${EUID} -ge "501" ]] && PS
        #export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
        run_ccal
        ;;
    Linux)
        [[ -f /usr/share/git/git-prompt.sh ]] && . /usr/share/git/git-prompt.sh
        [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]] && . /usr/share/git-core/contrib/completion/git-prompt.sh
        [[ -f /usr/lib/git-core/git-sh-prompt ]] && . /usr/lib/git-core/git-sh-prompt
        [[ ${EUID} -ge "1000" ]] && PS
        run_ccal
        ;;
esac

