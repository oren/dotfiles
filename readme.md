Dotfiles FTW
============

    cd ~/
    git clone git://github.com/oren/dotfiles.git
    ~/dotfiles/debian-laptop/bin/symlink-dotfiles

    # You're done!

Assupmtions
-----------

Make sure to `rm -r .vim .i3 .weechat` before symlinking.

The configuration assumes that you have the binary executable `mvim` somewhere in your path.

This is also adds /opt/ruby-enterprise/bin to your path, and also adds lots of conveniences for git.

Credits
-------

Most of the credits would go to http://peepcode.com/products/advanced-command-line. 
