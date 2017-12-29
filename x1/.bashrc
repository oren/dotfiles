#/bin/bash

export MISC=~/m
export PROJECTS=~/p
export DOWNLOADS=~/s
export TMP=~/t
# export BROWSER=chromium-browser

# bin
export PATH=~/.dotfiles/x1/bin:$PATH
export PATH=~/m/bin:$PATH
export PATH=~/.npm/bin:$PATH

# env
export PS1="\w "
# export PS1=""
export EDITOR="nvim"

# appengine
# export PATH=$PATH:$PROJECTS/go_appengine

# caddy
export PATH=$PATH:$TMP/apps

# java
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# go
export GOPATH=$PROJECTS/go
export GOBIN=$PROJECTS/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/p/go/src/github.com/cayleygraph/cayley

# go engine
export PATH=$PATH:$TMP/apps/go_appengine/

# marp
export PATH=$PATH:$TMP/apps/marp/

export PATH=$PATH:$TMP/apps/adr-tools-2.1.0/src/

# npm
export PATH=~/.npm-global/bin:$PATH

# use vim for manpages
export MANPAGER="sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Open terminal in current dir
# Commands to be executed before the prompt is displayed
PROMPT_COMMAND='pwd > "${HOME}/.cwd"'             # Save current working dir
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)" # Change to saved working dir

# git-hub
source ~/p/git-hub/.rc

# bash-git-prompt
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
