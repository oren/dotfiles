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
# export PATH=$PROJECTS/neo/neo4j-enterprise-2.3.1/bin:$PATH

# env
export PS1="\w "
# export PS1=""
export EDITOR="nvim"

# appengine
# export PATH=$PATH:$PROJECTS/go_appengine

# java
# export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# android
export ANDROID_HOME="/home/oren/Android/Sdk"
PATH="/home/oren/Android/Sdk/tools:/home/oren/Android/Sdk/platform-tools:${PATH}"
export PATH

PATH="/usr/local/android-studio/bin:${PATH}"
export PATH
# export ANDROID_BIN="$PROJECTS/android-sdk-linux/tools/android"
# export PATH="$PATH:$PROJECTS/android-sdk-linux/tools"
# export PATH="$PATH:$PROJECTS/android-sdk-linux/platform-tools"
# export PATH="$PATH:$PROJECTS/android-sdk-linux/build-tools"

# go
export GOPATH=$PROJECTS/go
export GOBIN=$PROJECTS/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

# go engine
export PATH=$PATH:$TMP/apps/go_appengine/

# use vim for manpages
# export MANPAGER="sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if hash ag 2>/dev/null; then
  # tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null; }
  tag() { command tag "$@"; source "/tmp/tag_aliases" 2>/dev/null; }
  alias ag=tag
fi

# Open terminal in current dir
# Commands to be executed before the prompt is displayed
PROMPT_COMMAND='pwd > "${HOME}/.cwd"'             # Save current working dir
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)" # Change to saved working dir

# git-hub
source ~/p/git-hub/init

# bash-git-prompt
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PATH="/home/oren/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/oren/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/oren/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/oren/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/oren/perl5"; export PERL_MM_OPT;
