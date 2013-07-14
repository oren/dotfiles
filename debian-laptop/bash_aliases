# # bash function to decompress archives - http://www.shell-fu.org/lister.php?id=375  
extract () {  
    if [ -f $1 ] ; then  
        case $1 in  
            *.tar.bz2)   tar xvjf $1        ;;  
            *.tar.gz)    tar xvzf $1     ;;  
            *.bz2)       bunzip2 $1       ;;  
            *.rar)       unrar x $1     ;;  
            *.gz)        gunzip $1     ;;  
            *.tar)       tar xvf $1        ;;  
            *.tbz2)      tar xvjf $1      ;;  
            *.tgz)       tar xvzf $1       ;;  
            *.zip)       unzip $1     ;;  
            *.Z)         uncompress $1  ;;  
            *.7z)        7z x $1    ;;  
            *)           echo "'$1' cannot be extracted via >extract<" ;;  
        esac  
    else  
        echo "'$1' is not a valid file"  
    fi  
}

alias l='ls'  
alias la='ls -Fa'  
alias ld='ls -al -d * | egrep "^d"' # only subdirectories  
alias c='cd'  

alias m='mplayer'
alias v='vim'
alias ack='ack-grep'
alias r='reset'
alias i='sudo aptitude install'
alias p='sudo aptitude purge'
alias monitor='xrandr --output LVDS --auto --output HDMI-0 --auto --above LVDS'

alias h='sudo halt'
alias hib='sudo pm-hibernate'

# mount
alias clip='sudo mount /dev/sdb /media/usb/ -o uid=1000,gid=1000'
alias u='sudo umount /media/usb'

# git
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gpp='git pull && git push'
alias gco='git checkout'
alias gd='git diff'
alias gdm='git diff master'
alias gst='tig status'
alias g='git status -sb'
alias gpr='git pull --rebase'
