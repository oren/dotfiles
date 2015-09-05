#/bin/bash

# bin
export PATH=~/.dotfiles/x1/bin:$PATH
export PATH=$PATH:$HOME/.bin

# env
export PS1="\w "
export EDITOR="vim"

# appengine
export PATH=$PATH:~/projects/go_appengine

# java
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# android
export ANDROID_BIN="/home/oren/Downloads/android-sdk-linux/tools/android"
export PATH="$PATH:/home/oren/projects/android-sdk-linux/tools"
export PATH="$PATH:/home/oren/projects/android-sdk-linux/platform-tools"
export PATH="$PATH:/home/oren/projects/android-sdk-linux/build-tools"

# go workspace
export GOPATH=$HOME/projects/go
export PATH=$PATH:$GOPATH/bin

# go binary
export PATH=$PATH:/usr/local/go/bin
# export GOROOT=/usr/local/go
# export PATH=$PATH:$GOROOT/bin

# use vim for manpages
export MANPAGER="sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.git-completion ]; then
    . ~/.git-completion
fi

# set -o vi

# Open terminal in current dir
# Commands to be executed before the prompt is displayed
PROMPT_COMMAND='pwd > "${HOME}/.cwd"'             # Save current working dir
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)" # Change to saved working dir

# docker autocomplete
source /etc/bash_completion.d/docker

# git-hub
source ~/projects/git-hub/init