Dotfiles FTW
============

    cd ~/
    git clone git://github.com/oren/dotfiles.git
    mv dotfiles .dotfiles

run one of the following:

    ~/.dotfiles/ubuntu/bin/symlink-dotfiles
    ~/.dotfiles/ubuntu/bin/symlink-dotfiles

    # You're done!

Assupmtions
-----------

Make sure to `rm -r .vim .i3 .weechat` before symlinking.
I use vim but like to capy paste from one vim to another. I do that by aliasing vim to mvim -v so make sure [macvim](http://code.google.com/p/macvim/) is installed.

Credits
-------

Most of the credits would go to http://peepcode.com/products/advanced-command-line.
