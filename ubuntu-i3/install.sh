#!/bin/bash

# Quick bash script to link dotfiles

## .vimrc
if [ -f ~/.vimrc ]; then
    rm -f ~/.vimrc && ln -s $(pwd)/.vimrc ~/
elif [ -L ~/.vimrc ]; then
    rm -f ~/.vimrc && ln -s $(pwd)/.vimrc ~/
else
    ln -s $(pwd)/.vimrc ~/
fi

## .bashrc
if [ -f ~/.bashrc ]; then
    rm -f ~/.bashrc && ln -s $(pwd)/.bashrc ~/
elif [ -L ~/.bashrc ]; then
    rm -f ~/.bashrc && ln -s $(pwd)/.bashrc ~/
else
    ln -s $(pwd)/.bashrc ~/
fi

## .Xmodmap
if [ -f ~/.Xmodmap ]; then
    rm -f ~/.Xmodmap && ln -s $(pwd)/.Xmodmap ~/
elif [ -L ~/.Xmodmap ]; then
    rm -f ~/.Xmodmap && ln -s $(pwd)/.Xmodmap ~/
else
    ln -s $(pwd)/.Xmodmap ~/
fi

## i3
if [ ! -d ~/.config/i3 ]; then
    mkdir ~/.config/i3
fi

if [ -f ~/.config/i3/config ]; then
    rm -f ~/.config/i3/config && ln -s $(pwd)/i3/config ~/.config/i3/
elif [ -L ~/.config/i3/config ]; then
    rm -f ~/.config/i3/config && ln -s $(pwd)/i3/config ~/.config/i3/
else
    ln -s $(pwd)/i3/config ~/.config/i3/
fi

## i3status
if [ -f /etc/i3status.conf ]; then
    sudo rm -f /etc/i3status.conf && sudo ln -s $(pwd)/i3/i3status.conf /etc/
elif [ -L /etc/i3status.conf ]; then
    sudo rm -f /etc/i3status.conf && sudo ln -s $(pwd)/i3/i3status.conf /etc/
else
    ln -s $(pwd)/i3/i3status.conf /etc/
fi

## dunstrc
if [ ! -d ~/.config/dunst ]; then
    mkdir ~/.config/dunst
fi

if [ -f ~/.config/dunst/dunstrc ]; then
    rm -f ~/.config/dunst/dunstrc && ln -s $(pwd)/dunstrc ~/.config/dunst/
elif [ -L ~/.config/dunst/dunstrc ]; then
    rm -f ~/.config/dunst/dunstrc && ln -s $(pwd)/dunstrc ~/.config/dunst/
else
    ln -s $(pwd)/dunstrc ~/.config/dunst/
fi

## compton.conf
if [ ! -d ~/.config/compton ]; then
    mkdir ~/.config/compton
fi

if [ -f ~/.config/compton/compton.conf ]; then
    rm -f ~/.config/compton/compton.conf && ln -s $(pwd)/compton.conf ~/.config/compton/
elif [ -L ~/.config/compton/compton.conf ]; then
    rm -f ~/.config/compton/compton.conf && ln -s $(pwd)/compton.conf ~/.config/compton/
else
    ln -s $(pwd)/compton.conf ~/.config/compton/
fi

## user-dirs
if [ -f ~/.config/user-dirs.dirs ]; then
    rm -f ~/.config/user-dirs.dirs && ln -s $(pwd)/user-dirs.dirs ~/.config/
elif [ -L ~/.config/user-dirs.dirs ]; then
    rm -f ~/.config/user-dirs.dirs && ln -s $(pwd)/user-dirs.dirs ~/.config/
else
    ln -s $(pwd)/user-dirs.dirs ~/.config/
fi

if [ -f ~/.config/user-dirs.conf ]; then
    rm -f ~/.config/user-dirs.conf && ln -s $(pwd)/user-dirs.conf ~/.config/
elif [ -L ~/.config/user-dirs.conf ]; then
    rm -f ~/.config/user-dirs.conf && ln -s $(pwd)/user-dirs.conf ~/.config/
else
    ln -s $(pwd)/user-dirs.conf ~/.config/
fi

## xsession errors script
if [ -f /opt/xsession-errors.sh ]; then
    rm /opt/xsession-errors.sh && ln -s $(pwd)/.xsession-errors.sh /opt/xsession-errors.sh
elif [ -L /opt/xsession-errors.sh ]; then
    rm /opt/xsession-errors.sh && ln -s $(pwd)/.xsession-errors.sh /opt/xsession-errors.sh
else
    ln -s $(pwd)/.xsession-errors.sh /opt/xsession-errors.sh
fi
