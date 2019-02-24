# zmodload zsh/zprof # uncomment this line to debug

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kolo"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$DOTFILES/zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git-extras ember-cli vi-mode extract zsh-autosuggestions fzf zsh-syntax-highlighting)

# User configuration

export PATH="$PATH:$HOME/.linuxbrew/bin:$HOME/.bin/:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# keybindings for history autocomplete
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end

[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

# prevent ZSH to print an error when no match can be found
unsetopt nomatch

# disable terminal flow control <C-s> and <C-q>
stty -ixon

ANDROID_HOME="$HOME/.android/Sdk"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

export LESS=-RFX
export BAT_THEME="Oceanic Next"
export BAT_STYLE="plain"
export GOPATH=$HOME/Code/go
export KDEHOME=$HOME/.kde4
export ERL_AFLAGS="-kernel shell_history enabled"

# color completions
eval `dircolors`
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

eval "$(scmpuff init -s)"

function less() {
  eval "$(scmpuff expand -- "/usr/bin/less" "$@")"
}

function rm() {
  eval "$(scmpuff expand -- "/usr/bin/rm" "$@")"
}

# Node, nvm related
export PATH="$PATH:$HOME/.yarn/bin"

lazy_load() {
  echo "Lazy loading $1 ..."

  local -a names
  if [[ -n "$ZSH_VERSION" ]]; then
    names=("${(@s: :)${1}}")
  else
    names=($1)
  fi
  unalias "${names[@]}"
  . $2
  shift 2
  $*
}

group_lazy_load() {
  local script
  script=$1
  shift 1
  for cmd in "$@"; do
    alias $cmd="lazy_load \"$*\" $script $cmd"
  done
}

export NVM_DIR=$HOME/.config/nvm
group_lazy_load /usr/share/nvm/init-nvm.sh nvm node npm yarn ember

export PATH="$PATH:$HOME/.rvm/bin"
group_lazy_load $HOME/.rvm/scripts/rvm rvm irb rake bundle gem rails guard

unset -f group_lazy_load

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

pip() {
  if [ "$1" = "install" -o "$1" = "bundle" ]; then
    cmd="$1"
    shift
    /usr/bin/pip $cmd --user $@
  else
    /usr/bin/pip $@
  fi
}

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# zprof # uncomment this line to debug
