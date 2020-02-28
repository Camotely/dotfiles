# My dotfiles

## .Xmodmap

```
ln -s <DIR>/dotfiles/.Xmodmap ~/
```

This config file will rebind your CapsLock key to Escape.

## user-dirs.dirs

```
rm ~/.config/user-dirs.dirs
ln -s <DIR>/dotfiles/user-dirs.dirs ~/.config
```

This config will allow you to delete common extra folders:

* Public
* Templates
* Desktop
* Music
* Pictures
* Videos

If this folder exists with the defaults, the folders will be created again.
