# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt share_history
setopt extended_history
setopt bang_hist
setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt hist_verify


source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/last-working-dir",   from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "agkozak/agkozak-zsh-theme"

zplug load

# display pwd and last command in terminal title
case $TERM in
    rxvt-unicode*)
        preexec () {print -Pn "\e]0;$PWD $1\a"}
        ;;
esac

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
  export VISUAL='vim'
  export TERM='rxvt-unicode'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi

alias gk="gitk --all"
alias va=". venv/bin/activate"
alias n='nvim'
alias ll='ls -al --color'

bindkey -e
bindkey '^P' up-history
bindkey '^N' down-history
bindkey "^R" history-incremental-pattern-search-backward
bindkey '^f' forward-word
bindkey '^b' backward-word
bindkey ' ' magic-space
# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

export FZF_DEFAULT_COMMAND='rg -g \  --files'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv/"
export PATH="$PYENV_ROOT/bin:$PATH"
# lazy loading of pyenv (load on first invocation)
pyenv() {
 unfunction pyenv
 eval "$(pyenv init -)"
 pyenv "$@"
}

# rust
export PATH="$HOME/.cargo/bin:$PATH"

[[ -a ~/.config/z.sh ]] && source ~/.config/z.sh


## Various tools ##

# rg
export RIPGREP_CONFIG_PATH="/home/benoit/.ripgreprc"
# AWS
source ~/.local/bin/aws_zsh_completer.sh
# github cli
eval "$(gh completion -s zsh)"
# Kubernetes
#alias k=kubectl
#function change-ns() {
#    namespace=$1
#    if [ -z $namespace ]; then
#        echo "Please provide the namespace name: 'change-ns mywebapp'"
#        return 1
#    fi
#    kubectl config set-context $(kubectl config current-context) --namespace $namespace
#}
#alias kn=change-ns
#export KUBECONFIG=/home/benoit/.kube/config
#alias kstaging="kubectl config use-context staging"
#alias kprod="kubectl config use-context production"
# source <(kubectl completion zsh)


# additional local config, not in version control
[[ -a ~/.zshrc.local ]] && source ~/.zshrc.local
