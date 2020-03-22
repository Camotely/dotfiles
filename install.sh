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