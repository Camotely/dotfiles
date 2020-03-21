#!/bin/bash
#
# Author: CovertLemur
# Date: March 13, 2020
#
# This script is made to help setup and install the tools needed for a usable
# i3wm Arch distribution.
#
# DISCLAIMER: This bootstrap is being reworked!

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

while true; do
    read -p "Is this a laptop? (y/n) " LAPTOP
    case $LAPTOP in
        y|Y|Yes|yes|YES ) break;;
        n|N|No|no|NO ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

SUDO_DEPENDENCIES="sudo"
X_DEPENDENCIES="xorg-xinit xorg-server"
GENERAL_DEPENDENCIES="firefox code xrandr man lightdm vim neofetch htop git"
NETWORK_DEPENDENCIES="network-manager-applet rsync traceroute bind-tools nmap net-tools networkmanager openssh"
TOOL_DEPENDENCIES="pacman-contrib base-devel bash-completion usbutils lsof dmidecode dialog zip unzip unrar p7zip lzop python3 python2" 
SOUND_DEPENDENCIES="alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pavucontrol"
FILESYSTEM_DEPENDENCIES="snapper dosfstools ntfs-3g btrfs-progs exfat-utils gptfdisk autofs sshfs nfs-utils"
PRINT_DEPENDENCIES="cups"
I3_DEPENDENCIES="i3-gaps rofi python-pywal nitrogen feh compton dunst scrot termite"
XFCE_DEPENDENCIES="exo garcon tumbler xfce4-appfinder xfce4-panel xfce4-power-manager xfce4-session xfce4-settings xfconf xfce4-battery-plugin"
FONT_DEPENDENCIES="font-bh-ttf font-bitstream-speedo gsfonts sdl_ttf ttf-bitstream-vera ttf-dejavu ttf-liberation xorg-fonts-type1"
LAPTOP_DEPENDENCIES="tlp"
INTEL_DEPENDENCIES="intel-ucode"
AMD_DEPENDENCIES="amd-ucode"
AUR_DEPENDENCIES="i3lock-color lightdm-slick-greeter xfce4-i3-workspaces-plugin-git"

DEPENDENCIES="\
  $SUDO_DEPENDENCIES \
  $X_DEPENDENCIES \
  $GENERAL_DEPENDENCIES \
  $NETWORK_DEPENDENCIES \
  $TOOL_DEPENDENCIES \
  $SOUND_DEPENDENCIES \
  $FILESYSTEM_DEPENDENCIES \
  $PRINT_DEPENDENCIES \
  $I3_DEPENDENCIES \
  $XFCE_DEPENDENCIES \
  $FONT_DEPENDENCIES \

"

POLYBAR_DEPENDENCIES=""

YAY_INSTALL="\
 $AUR_DEPENDENCIES \
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
function configure_dotfiles(){
    echo_green "Configuring X"
    sudo -u $NEW_USER bash -c "./install.sh"
}
# function configure_x(){
#     echo_green "Configuring X"
#     sudo -u $NEW_USER bash -c "rm -vf ~/.Xmodmap; ln -vs $(pwd)/.Xmodmap ~/"
#     sudo -u $NEW_USER bash -c "rm -vf ~/.xinitrc; ln -vs $(pwd)/.xinitrc ~/"
# }

# function configure_dunst(){
#     echo_green "Configuring dunst" 
#     sudo -u $NEW_USER bash -c 'mkdir -vp ~/.config/dunst'
#     sudo -u $NEW_USER bash -c "rm -vf ~/.config/dunst/dunstrc; ln -vs $(pwd)/dunstrc ~/.config/dunst/"
# }

# function configure_bashrc(){
#     echo_green "Configuring bash"
#     sudo -u $NEW_USER bash -c "rm -vf ~/.bashrc; ln -vs $(pwd)/.bashrc ~/"
# }

# function configure_vim(){
#     echo_green "Configuring vim..."
#     sudo -u $NEW_USER bash -c 'curl -sfLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
#     sudo -u $NEW_USER bash -c "rm -vf ~/.vimrc; ln -vs $(pwd)/.vimrc ~/"
#     sudo -u $NEW_USER bash -c 'vim ~/.vimrc +PlugInstall +q +q'
#}

function configure_git(){
    sudo -u $NEW_USER bash -c 'git config --global core.editor "vim"'
    sudo -u $NEW_USER bash -c "git config --global user.email $GIT_EMAIL"
    sudo -u $NEW_USER bash -c 'git config --global user.name "CovertLemur"'
}

#function configure_xfce(){
#    sudo -u $NEW_USER bash -c "rm -vrf ~/.config/xfce4; ln -vs $(pwd)/xfce4 ~/.config/"
#}

#function configure_i3(){
#    sudo -u $NEW_USER bash -c 'mkdir -vp ~/.config/i3'
#    sudo -u $NEW_USER bash -c "rm -vf ~/.config/i3/config; ln -vs $(pwd)/i3/config ~/.config/i3/"
#}

#function configure_pacman(){
#    cp mirrorlist /etc/pacman.d/mirrorlist
#}

#function configure_compton(){
#    sudo -u $NEW_USER bash -c 'mkdir -vp ~/.config/compton'
#    sudo -u $NEW_USER bash -c 'rm -vf ~/.config/compton/compton.conf; ln -vs $(pwd)/compton.conf ~/.config/compton/'
#}
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
    echo "LC_COLLATE=C" >> /etc/locale.conf
    locale-gen
}

function set_keymap(){
    echo "KEYMAP=us" > /etc/vsconsole.conf
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
    set_keymap
    set_hostname
    init_keyring
}

function installing_with_pacman(){
    pacman -Sy $DEPENDENCIES --needed --noconfirm --color=always

    if [[ $LAPTOP == y || $LAPTOP == Y || $LAPTOP == Yes || $LAPTOP == YES ]]; then
        pacman -Sy $LAPTOP_DEPENDENCIES --needed --noconfirm --color=always
    else
        pacman -Sy $DESKTOP_DEPENDENCIES --needed --noconfirm --color=always
    fi

    CPUMAN=$(lscpu | grep "Vendor ID:" | cut -d':' -f2 | awk '{$1=$1};1')
    if [[ $CPUMAN == AuthenticAMD ]]; then
        pacman -Sy $AMD_DEPENDENCIES --needed --noconfirm --color=always
    elif [[ $CPUMAN == GenuineIntel ]]; then
        pacman -Sy $INTEL_DEPENDENCIES --needed --noconfirm --color=always
    fi

    systemctl enable lightdm
    systemctl enable NetworkManager
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
configure_dotfiles
#configure_x
#configure_dunst
#configure_bashrc
#onfigure_vim
configure_git
#configure_compton
prepare_opt

install_yay
installing_with_yay

cleanup

