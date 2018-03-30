Dotfiles FTW
============


setup
```
cd ~/
git clone git://github.com/oren/dotfiles.git
mv dotfiles .dotfiles
```

create symlinks
```
stow -v x1
```

Note: whenever I need to save a config file, I should add it to 

testing
```
stow -v -t ~/destination x1
stow -v -t ~/destination x1 --ignore='.Trash'        # ignore
stow -D -v -t ~/destination x1                       # delete
stow -R -v -t ~/destination x1                       # relink (if i added a file)


