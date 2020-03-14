#!/bin/bash

firefox &
sleep 5
killall firefox

ff=$(ls $HOME/.mozilla/firefox | egrep *.default-release)
ln -vs $DIR/firefox/user.js $HOME/.mozilla/firefox/$ff

