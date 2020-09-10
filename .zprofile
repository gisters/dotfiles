# locale
export LANG="en_US.UTF-8"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit && compinit
fi
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit && compinit
fi

[[ -d ~/.bash ]] && path=($HOME/.bash $path)

# HOMEBREW
if [ -f /usr/local/bin/brew ]; then
    export HOMEBREW_GITHUB_API_TOKEN=your-github-api-token
    export HOMEBREW_EDITOR=/usr/bin/vim
    export HOMEBREW_CACHE=$HOME/Library/Caches/Homebrew
    export HOMEBREW_NO_ANALYTICS=1
    path=($path $(brew --prefix)/sbin)
fi

# HOMEBREW CASK
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"

# golang
if hash go 2>/dev/null; then
    export GOPATH="$HOME/.go"
    path=($HOME/.go/bin $path)
fi

# gem home
if [ -f /usr/bin/gem ]; then
    export GEM_HOME=$HOME/.gem
    path=($GEM_HOME/bin $path)
fi
