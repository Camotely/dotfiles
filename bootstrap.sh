#!/bin/bash

DIR=$(pwd)

# Home directory
rm -vf $HOME/.vimrc && ln -vs $DIR/.vimrc $HOME/
rm -vf $HOME/.Xmodmap && ln -vs $DIR/.Xmodmap $HOME/
rm -vf $HOME/.Xresources && ln -vs $DIR/.Xresources $HOME/
rm -vf $HOME/.bashrc && ln -vs $DIR/.bashrc $HOME/
rm -vf $HOME/.xinitrc && ln -vs $DIR/.xinitrc $HOME/
 
# Term -vfite
mkdir -vp $HOME/.config/term -vfite
rm -vf $HOME/.config/term -vfite/config && ln -vs $DIR/term -vfite.config $HOME/.config/term -vfite/config

# i3
mkdir -vp $HOME/.config/i3
rm -vf $HOME/.config/i3/config && ln -vs $DIR/i3/config $HOME/.config/i3/

# Polybar
rm -vrf $HOME/.config/polybar && ln -vs $DIR/polybar $HOME/.config/

# Firefox
firefox &
sleep 5
killall firefox

ff=$(ls $HOME/.mozilla/firefox | egrep *.default-release)
ln -vs $DIR/firefox/user.js $HOME/.mozilla/firefox/$ff
