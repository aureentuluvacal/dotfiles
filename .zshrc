# Load version control information
autoload -Uz vcs_info
autoload -U colors && colors
autoload -Uz compinit && compinit -i
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='%{$fg_bold[yellow]%}%n%{$reset_color%} %{$fg_bold[white]%}en%{$reset_color%} %{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%} %{$fg_bold[white]%}sur%{$reset_color%} %{$fg_bold[blue]%}${vcs_info_msg_0_}%{$reset_color%}${NEWLINE}❯ '

# Aliases
alias prof='vim ~/.zshrc'
alias reprof='source ~/.zshrc'

# Git Aliases
alias gs='git status'
alias gb='git branch'
alias ga='git add .'
alias gpm='git push origin main'
alias gplm='git pull origin main'
alias gld='git pull origin develop'
alias gp='git push origin $(git symbolic-ref -q HEAD)'
alias cpclear='gb | grep "cp/" | xargs git branch -D'

# Other Aliases
alias kube='kubectl proxy'
alias cons='docker-compose run api rails console'

# Kubernetes functions and aliases
function k8s_exec() {
	kubectl -it exec -n $1 $(kubectl get pods -n $1 | grep -oh -m 1 "web-\w*-\w*") -- ${@:2}
}
alias execpod='k8s_exec'

function destroy() {
        kubectl delete pod $1 --grace-period=0 --force --namespace $2
}
alias deletepod='destroy'

export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fpath=(~/.zsh/completion $fpath)
