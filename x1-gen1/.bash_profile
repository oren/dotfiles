if [ -f ~/.bashrc ];
then
  source ~/.bashrc
fi

xset r rate 200 60 # typematic delay and rate

export PATH="$HOME/.cargo/bin:$PATH"
# Cake
export CAKEROOT=$HOME/.cake
export PATH=$PATH:$CAKEROOT/bin
