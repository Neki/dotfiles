source ~/.zplug/init.zsh

zplug "plugins/last-working-dir",   from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "agkozak/agkozak-zsh-theme"

zplug load

# Apply bash completion
activate_bash_completion() {
 autoload bashcompinit
 bashcompinit
 source ~/.bash_completion
}

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$HOME/.local/bin:$PATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export TERM='rxvt-unicode'
else
  export EDITOR='vim'
fi

alias gk="gitk --all"
alias va=". venv/bin/activate"
alias n='nvim'
alias t='todo.sh'

SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt share_history

bindkey -e
bindkey '^P' up-history
bindkey '^N' down-history
bindkey "^R" history-incremental-pattern-search-backward

export FZF_DEFAULT_COMMAND='rg -g \  --files'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
rbenv() {
 eval "$(rbenv init -)"
 rbenv "$@"
}

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
pyenv() {
 eval "$(pyenv init -)"
 eval "$(pyenv virtualenv-init -)"
 pyenv "$@"
}

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# additional local config
[[ -a ~/.zshrc.local ]] && ~/.zshrc.local