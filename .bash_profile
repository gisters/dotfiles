# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bash_color ]] && . ~/.bash_color
[[ -f ~/.bashrc ]] && . ~/.bashrc

# history
export HISTTIMEFORMAT="%Y-%m-%d %T "
export HISTCONTROL=ignoreboth:erasedups

# personal bash path
[[ -d ~/.bash ]] && export PATH=$PATH:$HOME/.bash

case `uname` in
    Darwin)
        # git-completion
        if [ -f $(xcode-select -p)/usr/share/git-core/git-completion.bash ]; then
            source $(xcode-select -p)/usr/share/git-core/git-completion.bash
        fi
        # HOMEBREW
        if [ -f /usr/local/bin/brew ]; then
            export HOMEBREW_GITHUB_API_TOKEN=your-github-api-token
            export HOMEBREW_EDITOR=/usr/bin/vim
            export HOMEBREW_CACHE=$HOME/Library/Caches/Homebrew
            export HOMEBREW_NO_ANALYTICS=1
        fi
        # HOMEBREW CASK
        export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"
        if [ -d $(brew --prefix)/Library/Taps/caskroom ]; then
            export PATH=$(brew --prefix)/Library/Taps/caskroom/homebrew-cask/developer/bin:$PATH
        fi
        # bash-completion
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
            . $(brew --prefix)/etc/bash_completion
        fi
        # bash-completion2
        if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
            . $(brew --prefix)/share/bash-completion/bash_completion
        fi
        # mono
        [[ -f /usr/local/bin/mono ]] &&  export MONO_GAC_PREFIX="/usr/local"
        # pip home
        if [ -d ~/Library/Python/2.7/bin ]; then
            export PYTHONUSERBASE=$HOME/Library/Python/2.7
            export PATH=$PYTHONUSERBASE/bin:$PATH
        fi
        # gem home
        if hash go 2>/dev/null; then
            export GEM_HOME=$HOME/.gem
            export PATH=$GEM_HOME/bin:$PATH
        fi
        ;;
    Linux)
        # gem
        [[ -d ~/.gem ]] && export PATH=$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin
        ;;
esac