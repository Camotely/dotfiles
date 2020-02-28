# My dotfiles

## .Xmodmap

```
ln -s <DIR>/dotfiles/.Xmodmap ~/
```

This config file will rebind your CapsLock key to Escape.

## user-dirs

```
rm ~/.config/user-dirs.dirs
rm ~/.config/user-dirs.conf
ln -s <DIR>/dotfiles/user-dirs.dirs ~/.config/
ln -s <DIR>/dotfiles/user-dirs.conf ~/.config/
```

This config will allow you to delete common extra folders:

* Public
* Templates
* Desktop
* Music
* Pictures
* Videos

If this folder exists with the defaults, the folders will be created again.
