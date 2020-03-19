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

## termite
if [ ! -d ~/.config/termite ]; then
    mkdir ~/.config/termite
fi

if [ -f ~/.config/termite/config ]; then
    rm -f ~/.config/termite/config && ln -s $(pwd)/termite.config ~/.config/termite/config
elif [ -L ~/.config/termite/config ]; then
    rm -f ~/.config/termite/config && ln -s $(pwd)/termite.config ~/.config/termite/config
else
    ln -s $(pwd)/termite.config ~/.config/termite/config
fi

## xfce4
if [ -d ~/.config/xfce4 ]; then
    rm -rf ~/.config/xfce4 && ln -s $(pwd)/xfce4 ~/.config/
elif [ -L ~/.config/xfce4 ]; then
    rm -rf ~/.config/xfce4 && ln -s $(pwd)/xfce4 ~/.config/
else
    ln -s $(pwd)/xfce4 ~/.config/
fi

## backgrounds
sudo ln -s $(pwd)/../backgrounds /usr/share/backgrounds/git

## lightdm (slick-greeter)
if [ -f /etc/lightdm/lightdm.conf ]; then
    sudo rm -f /etc/lightdm/lightdm.conf && sudo cp $(pwd)/lightdm/lightdm.conf /etc/lightdm/
    sudo chown root.root /etc/lightdm/lightdm.conf
elif [ -L /etc/lightdm/lightdm.conf ]; then
    sudo rm -f /etc/lightdm/lightdm.conf && sudo cp $(pwd)/lightdm/lightdm.conf /etc/lightdm/
    sudo chown root.root /etc/lightdm/lightdm.conf
else
    sudo cp $(pwd)/lightdm/lightdm.conf /etc/lightdm/
    sudo chown root.root /etc/lightdm/lightdm.conf
fi

if [ -f /etc/lightdm/slick-greeter.conf ]; then
    sudo rm -f /etc/lightdm/slick-greeter.conf && sudo cp $(pwd)/lightdm/slick-greeter.conf /etc/lightdm/
    sudo chown root.root /etc/lightdm/slick-greeter.conf
elif [ -L /etc/lightdm/slick-greeter.conf ]; then
    sudo rm -f /etc/lightdm/slick-greeter.conf && sudo cp $(pwd)/lightdm/slick-greeter.conf /etc/lightdm/
    sudo chown root.root /etc/lightdm/slick-greeter.conf
else
    sudo cp $(pwd)/lightdm/slick-greeter.conf /etc/lightdm/
    sudo chown root.root /etc/lightdm/slick-greeter.conf
fi

## slick-greeter xfce icon
if [ -f /usr/share/slick-greeter/badges/xfce.svg ]; then
    sudo mv /usr/share/slick-greeter/badges/xfce.svg /usr/share/slick-greeter/badges/xfce.svg.bak
    sudo cp $(pwd)/../icons/arch.svg /usr/share/slick-greeter/badges/xfce.svg
elif [ -L /usr/share/slick-greeter/badges/xfce.svg ]; then
    sudo mv /usr/share/slick-greeter/badges/xfce.svg /usr/share/slick-greeter/badges/xfce.svg
.bak
    sudo cp $(pwd)/../icons/arch.svg /usr/share/slick-greeter/badges/xfce.svg
else
    sudo cp $(pwd)/../icons/arch.svg /usr/share/slick-greeter/badges/xfce.svg
fi

## Copy mirrorlist
sudo cp mirrorlist /etc/pacman.d/mirrorlist
