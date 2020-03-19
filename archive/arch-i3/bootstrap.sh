#!/bin/bash
#
# Author: CovertLemur
# Date: March 13, 2020
#
# This script is made to help setup and install the tools needed for a usable
# i3wm Arch distribution.

# Username given as argument to script
NEW_USER=$1

# Hostname of the device
NEW_HOSTNAME=$2

# Email for Github setup
GIT_EMAIL=$3

# --- 

# Colors for flashier text
COLOR_RED=$(tput setaf 1)
COLOR_GREEN=$(tput setaf 2)
COLOR_YELLOW=$(tput setaf 3)
COLOR_BLUE=$(tput setaf 4)
COLOR_MAGENTA=$(tput setaf 5)
COLOR_CYAN=$(tput setaf 6)
COLOR_WHITE=$(tput setaf 7)
BOLD=$(tput bold)
COLOR_RESET=$(tput sgr0)

function echo_red(){
    echo "${COLOR_RED}${BOLD}$1${COLOR_RESET}"
}

function echo_green(){
    echo "${COLOR_GREEN}${BOLD}$1${COLOR_RESET}"
}

function echo_yellow(){
    echo "${COLOR_YELLOW}${BOLD}$1${COLOR_RESET}"
}

# ---

# Packages to install

SUDO_DEPENDENCIES="sudo"
AUDIO_DEPENDENCES="pulseaudio pavucontrol volumeicon"
GIT_DEPENDENCIES="git"
VIM_DEPENDENCIES="vim"
X_DEPENDENCIES="xorg-xinit xorg-server"
YAY_DEPENDENCINES="base-devel"
I3_DEPENDENCIES="i3-gaps i3lock"
TERMITE_DEPENDENCIES="termite"
DMENU_DEPENDENCIES="dmenu"
FIREFOX_DEPENDENCIES="firefox"
PYWAL_DEPENDENCIES="python-pywal python2 python3"
RANGER_DEPENDENCIES="ranger pcmanfm"
DUNST_DEPENDENCIES="dunst"
SCROT_DEPENDENCIES="scrot"

DEPENDENCIES="\
 $SUDO_DEPENDENCIES \
 $AUDIO_DEPENDENCIES \
 $GIT_DEPENDENCIES \
 $VIM_DEPENDENCIES \
 $X_DEPENDENCIES \
 $YAY_DEPENDENCIES \
 $I3_DEPENDENCIES \
 $TERMITE_DEPENDENCIES \
 $DMENU_DEPENDENCIES \
 $FIREFOX_DEPENDENCES \
 $PYWAL_DEPENDENCIES \
 $RANGER_DEPENDENCIES \
 $DUNST_DEPENDENCIES \
 $SCROT_DEPENDENCIES

"

POLYBAR_DEPENDENCIES="polybar"

YAY_INSTALL="\
 $POLYBAR_DEPENDENCIES \
"

# ---

# Creating a new user, making and adding to the sudo group,
# and moving the dotfiles directory
function create_new_user(){
    pacman -Sy sudo --noconfirm
    id -u $NEW_USER > /dev/null

    if [ $? -eq 1 ]
    then
        echo_green "Creating new user $COLOR_BLUE$NEW_USER"

        mkdir /home/$NEW_USER
        useradd $NEW_USER
        echo_yellow "Please set the password for $COLOR_BLUE$NEW_USER:"
        passwd $NEW_USER
    else
        echo_green "New user already exists, using that account for everything"
    fi

    groupadd sudo
    usermod -aG sudo $NEW_USER
    sed -i 's/# %sudo/%sudo/g' /etc/sudoers
    echo "$NEW_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

    chown $NEW_USER:$NEW_USER /home/$NEW_USER
    chown -R $NEW_USER:$NEW_USER $(pwd)
    mv $(pwd) /home/$NEW_USER/dotfiles
    cd /home/$NEW_USER/dotfiles
}

# Cleaning up the sudo without password setup
function cleanup(){
    sed -i "s/$NEW_USER ALL=(ALL) NOPASSWD: ALL//g" /etc/sudoers
    pacman -Sc --noconfirm
}

# ---

# Setting up X dotfiles
function configure_x(){
    echo_green "Configuring X"
    sudo -u $NEW_USER bash -c "rm -vf ~/.Xmodmap && ln -vs $(pwd)/.Xmodmap ~/"
    sudo -u $NEW_USER bash -c "rm -vf ~/.xinitrc && ln -vs $(pwd)/.xinitrc ~/"
}

function configure_termite(){
    echo_green "Configuring Termite"
    sudo -u $NEW_USER bash -c 'mkdir -vp ~/.config/termite'
    sudo -u $NEW_USER bash -c "rm -vf ~/.config/termite/config && ln -vs $(pwd)/termite.config ~/.config/termite/config"
}

function configure_bashrc(){
    echo_green "Configuring bash"
    sudo -u $NEW_USER bash -c "rm -vf ~/.bashrc && ln -vs $(pwd)/.bashrc ~/"
}

function configure_vim(){
    echo_green "Configuring vim..."
    sudo -u $NEW_USER bash -c 'curl -sfLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
    sudo -u $NEW_USER bash -c "rm -vf ~/.vimrc && ln -vs $(pwd)/.vimrc ~/"
    sudo -u $NEW_USER bash -c 'vim ~/.vimrc +PlugInstall +q +q'
}

function configure_git(){
    sudo -u $NEW_USER bash -c 'git config --global core.editor "vim"'
    sudo -u $NEW_USER bash -c "git config --global user.email $GIT_EMAIL"
    sudo -u $NEW_USER bash -c 'git config --global user.name "CovertLemur"'
}

function configure_polybar(){
    sudo -u $NEW_USER bash -c "rm -vrf ~/.config/polybar && ln -vs $(pwd)/polybar ~/.config/"
}

function configure_i3(){
    sudo -u $NEW_USER bash -c 'mkdir -vp ~/.config/i3'
    sudo -u $NEW_USER bash -c "rm -vf ~/.config/i3/config && ln -vs $(pwd)/i3/config ~/.config/i3/"
}

function configure_pacman(){
    cp mirrorlist /etc/pacman.d/mirrorlist
}

# ---

function prepare_opt(){
    mkdir -p /opt
    chown $NEW_USER:$NEW_USER /opt
}

function install_yay(){
    pacman -Sy --needed base-devel --noconfirm
    pushd /opt/
    git clone https://aur.archlinux.org/yay.git

    chown $NEW_USER:$NEW_USER /opt/yay
    cd yay
    sudo -u $NEW_USER bash -c 'cd /opt/yay/ && yes|makepkg -si'
    popd
    sudo -u $NEW_USER bash -c 'yes|yay'
}

# ---

function set_timezone(){
    echo_green "Setting timezone to EST5EDT"

    ln -sf /usr/share/zoneinfo/EST5EDT /etc/localtime
    hwclock --systohc
}

function set_locale(){
    echo_green "Setting locale"
    sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    locale-gen
}

function set_hostname(){
    echo_green "Setting hostname"

    echo $HOSTNAME > /etc/hostname
    cat <<EOF >/etc/hosts
127.0.0.1 localhost
::1       localhost
127.0.1.1 $HOSTNAME.localdomain $HOSTNAME
EOF

}

function init_keyring(){
    echo_green "Initializing pacman keys"
    rm -r /etc/pacman.d/gnupg
    pacman-key --init
    pacman-key --populate archlinux
    pacman-key --refresh-keys
}

function pre_install(){
    set_timezone
    set_locale
    set_hostname
    init_keyring
}

function installing_with_pacman(){
    pacman -Sy $DEPENDENCIES --noconfirm --color=always
}

function installing_with_yay(){
    sudo -u $NEW_USER bash -c "yay -Sy $YAY_INSTALL --noconfirm"
}

if [ "$1" == "" ]
then
    echo_red "You must supply a username to use."
    echo "usage: $0 <new_username> <hostname> <git_email>"
    exit
elif [ "$2" == "" ]
then
    echo_red "You must supply a hostname to use."
    echo "usage: $0 <new_username> <hostname> <git_email>"
    exit
elif [ "$3" == "" ]
then
    echo_red "You must supply an email to use."
    echo "usage: $0 <new_username> <hostname> <git_email>"
    exit
fi

pre_install
create_new_user
configure_pacman
installing_with_pacman
configure_x
configure_termite
configure_bashrc
configure_vim
configure_git
prepare_opt

install_yay
installing_with_yay

cleanup

