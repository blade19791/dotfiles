# ----------------------------------------
# Powerlevel10k instant prompt (must be first)
# ----------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------------
# Oh My Zsh setup
# ----------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# ----------------------------------------
# Plugins
# ----------------------------------------
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autocomplete   # Fish-like autocomplete with history and inline suggestions
)
source $ZSH/oh-my-zsh.sh

# ----------------------------------------
# zsh-autocomplete settings
# ----------------------------------------
ZSH_AUTOCOMPLETE_HISTORY=true      # Keep history suggestions
ZSH_AUTOCOMPLETE_BUFFER_INLINE=true  # Enable Fish-like gray inline suggestions
# Inline suggestion acceptance: Right Arrow automatically accepts

# ----------------------------------------
# History settings
# ----------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY

# ----------------------------------------
# Completion settings (extra)
# ----------------------------------------
fpath+=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions/src
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''
setopt AUTO_LIST
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt CORRECT

# ----------------------------------------
# Colored output
# ----------------------------------------
autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias ls='ls --color=auto'

# Colored man pages
man() {
  LESS_TERMCAP_mb=$'\e[1;31m' \
  LESS_TERMCAP_md=$'\e[1;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[1;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[1;32m' \
  command man "$@"
}

# ----------------------------------------
# Aliases
# ----------------------------------------
alias clr='clear'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'
alias zr='source ~/.zshrc'
alias i='yay -S'

# Git Aliases
alias g='git'
alias gi='git init'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gst='git status --short'
alias gl='git log --oneline --graph --decorate --all'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gp='git push'
alias glast='git log -1 HEAD'
alias gcfg='git config --global --list'
alias grv='git remote -v'
alias gcl='git clone'

# ----------------------------------------
# Powerlevel10k configuration
# ----------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
