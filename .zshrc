# shellcheck shell=bash
# shellcheck disable=SC1090,SC1091,SC2034

# Fast, keyboard-first zsh setup.

bindkey -v
KEYTIMEOUT=1

_hist_legacy="${ZDOTDIR:-$HOME}/.zsh_history"
_hist_xdg="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"

if [[ -f "$_hist_legacy" ]]; then
  HISTFILE="$_hist_legacy"
elif [[ -f "$_hist_xdg" ]]; then
  HISTFILE="$_hist_xdg"
else
  HISTFILE="$_hist_legacy"
fi

mkdir -p "${HISTFILE:h}"
unset _hist_legacy _hist_xdg

HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

export EDITOR="nvim"
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export SUDO_EDITOR="$EDITOR"

typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "${path[@]}"
)

[[ -d "$HOME/.bun/bin" ]] && path=("$HOME/.bun/bin" "${path[@]}")

export PNPM_HOME="$HOME/Library/pnpm"
[[ -d "$PNPM_HOME" ]] && path=("$PNPM_HOME" "${path[@]}")

_local_zshrc="${ZDOTDIR:-$HOME}/.zshrc.local"
[[ -f "$_local_zshrc" ]] && source "$_local_zshrc"
unset _local_zshrc

export PATH

autoload -Uz compinit
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
compinit -i -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"

if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --preview-window=right:55%'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

if command -v fzf >/dev/null 2>&1 && [[ -o interactive ]] && [[ -t 0 ]]; then
  eval "$(fzf --zsh)"
fi
if command -v atuin >/dev/null 2>&1 && [[ -o interactive ]] && [[ -t 0 ]]; then
  eval "$(atuin init zsh)"
fi
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init --cmd cd zsh)"
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Load highlighting after other widgets and completions.
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

export ERL_AFLAGS="-kernel shell_history enabled"

alias vim="nvim"
alias vi="nvim"
alias code="nvim"
alias python="python3"

alias ll="eza -la --icons --group-directories-first"
alias lt="eza --tree --level=2 --icons"
alias cat="bat --paging=never"

alias lg="lazygit"
alias gst="git status -sb"
alias gco="git checkout"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git pull --rebase"
alias gd="git diff"
alias gds="git diff --staged"
compdef _git gst=git gco=git gcm=git gp=git gl=git gd=git gds=git

fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [[ -n "$pid" ]]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

gcob() {
  git branch -a | fzf | xargs git checkout
}

flog() {
  git log --oneline --color=always \
    | fzf --ansi --preview 'git show --color=always {1}' \
    | awk '{print $1}' \
    | xargs git show
}
. "/Users/tony/.deno/env"
