# This is my setup for macosx systems
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize
export PATH="/usr/local/bin:${PATH}"

# envm stuff
export envm="$HOME/.envm"
export envm_wdir="$HOME/Sync/"
export envm_auto_update_days=1
source $envm/envm.sh

# Editor
export EDITOR="vim"
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
fi

# Go
export PATH=$PATH:$GOPATH/bin:PATH
export GOPATH="$HOME/go"
export GO111MODULE=on
