#/bin/bash

# bin
export PATH=~/.dotfiles/x1/bin:$PATH
export PATH=/misc/bin:$PATH
export PATH=~/.npm/bin:$PATH
export PATH=~/projects/neo/neo4j-enterprise-2.3.1/bin:$PATH

# env
export PS1="\w "
# export PS1=""
export EDITOR="vim"

# appengine
# export PATH=$PATH:~/projects/go_appengine

# java
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# android
export ANDROID_HOME="/home/oren/projects/android-sdk-linux"
export ANDROID_BIN="/home/oren/projects/android-sdk-linux/tools/android"
export PATH="$PATH:/home/oren/projects/android-sdk-linux/tools"
export PATH="$PATH:/home/oren/projects/android-sdk-linux/platform-tools"
export PATH="$PATH:/home/oren/projects/android-sdk-linux/build-tools"

# go
export GOPATH=$HOME/projects/go
export PATH=$PATH:/usr/local/go/bin

# use vim for manpages
export MANPAGER="sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.git-completion ]; then
    . ~/.git-completion
fi

# Open terminal in current dir
# Commands to be executed before the prompt is displayed
PROMPT_COMMAND='pwd > "${HOME}/.cwd"'             # Save current working dir
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)" # Change to saved working dir

# docker autocomplete
# source /etc/bash_completion.d/docker

# git-hub
source ~/p/git-hub/init

# bash-git-prompt
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
