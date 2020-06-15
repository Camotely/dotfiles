#!/bin/bash

# Quick bash script to link dotfiles

# directory removal
(rmdir "$HOME"/Desktop "$HOME"/Music "$HOME"/Pictures "$HOME"/Public "$HOME"/Templates "$HOME"/Videos) 2>/dev/null

## .vimrc
if [ -f ~/.vimrc ]; then
    rm -f ~/.vimrc && ln -s "$(pwd)"/.vimrc ~/
elif [ -L ~/.vimrc ]; then
    rm -f ~/.vimrc && ln -s "$(pwd)"/.vimrc ~/
else
    ln -s "$(pwd)"/.vimrc ~/
fi

## .bashrc
if [ -f ~/.bashrc ]; then
    rm -f ~/.bashrc && ln -s "$(pwd)"/.bashrc ~/
elif [ -L ~/.bashrc ]; then
    rm -f ~/.bashrc && ln -s "$(pwd)"/.bashrc ~/
else
    ln -s "$(pwd)"/.bashrc ~/
fi

## .Xmodmap
if [ -f ~/.Xmodmap ]; then
    rm -f ~/.Xmodmap && ln -s "$(pwd)"/.Xmodmap ~/
elif [ -L ~/.Xmodmap ]; then
    rm -f ~/.Xmodmap && ln -s "$(pwd)"/.Xmodmap ~/
else
    ln -s "$(pwd)"/.Xmodmap ~/
fi

## user-dirs
if [ -f ~/.config/user-dirs.dirs ]; then
    rm -f ~/.config/user-dirs.dirs && ln -s "$(pwd)"/user-dirs.dirs ~/.config/
elif [ -L ~/.config/user-dirs.dirs ]; then
    rm -f ~/.config/user-dirs.dirs && ln -s "$(pwd)"/user-dirs.dirs ~/.config/
else
    ln -s "$(pwd)"/user-dirs.dirs ~/.config/
fi

if [ -f ~/.config/user-dirs.conf ]; then
    rm -f ~/.config/user-dirs.conf && ln -s "$(pwd)"/user-dirs.conf ~/.config/
elif [ -L ~/.config/user-dirs.conf ]; then
    rm -f ~/.config/user-dirs.conf && ln -s "$(pwd)"/user-dirs.conf ~/.config/
else
    ln -s "$(pwd)"/user-dirs.conf ~/.config/
fi

## firefox
ff=$(find "$HOME"/.mozilla/firefox -name "*release")

if [ -f "$ff"/user.js ]; then
    rm -f "$ff"/user.js && ln -s "$(pwd)"/user.js "$ff"
elif [ -L "$ff"/user.js ]; then
    rm -f "$ff"/user.js && ln -s "$(pwd)"/user.js "$ff"
elif [ -z "$ff" ]; then
    firefox &
    sleep 5
    killall firefox
    ff=$(find "$HOME"/.mozilla/firefox -name "*release")
    ln -s "$(pwd)"/user.js "$ff"
elif [ -n "$ff" ]; then
    ln -s "$(pwd)"/user.js "$ff"
fi

## bash_profile
if [ ~/.bash_profile ]; then
    rm -f ~/.bash_profile && ln -s "$(pwd)"/.bash_profile ~/
elif [ -L ~/.bash_profile ]; then
    rm -f ~/.bash_profile && ln -s "$(pwd)"/.bash_profile ~/
else
    ln -s "$(pwd)"/.bash_profile
fi

## i3status
if [ ! -d ~/.config/i3status ]; then
    mkdir -p ~/.config/i3status
fi

if [ -f ~/.config/i3status/config ]; then
    rm -f ~/.config/i3status/config && ln -s "$(pwd)"/i3status.conf ~/.config/i3status/config
elif [ -L ~/.config/i3status/config ]; then
    rm -f ~/.config/i3status/config && ln -s "$(pwd)"/i3status.conf ~/.config/i3status/config
else
    ln -s "$(pwd)"/i3status.conf ~/.config/i3status/config
fi

## sway
if [ ! -d ~/.config/sway ]; then
    mkdir -p ~/.config/sway
fi

if [ -f ~/.config/sway/config ]; then
    rm -f ~/.config/sway/config && ln -s "$(pwd)"/sway.conf ~/.config/sway/config
elif [ -L ~/.config/sway/config ]; then
    rm -f ~/.config/sway/config && ln -s "$(pwd)"/sway.conf ~/.config/sway/config
else
    ln -s "$(pwd)"/sway.conf ~/.config/sway/config
fi
