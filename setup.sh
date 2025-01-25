#!/bin/bash

GREEN="\e[32m"
ENDCOLOR="\e[0m"

echo -e "${GREEN}Updating the system...${ENDCOLOR}"
sudo pacman -Syuu --noconfirm

echo -e "${GREEN}Installing Paru AUR helper...${ENDCOLOR}"
if ! command -v paru &> /dev/null; then
    git clone https://aur.archlinux.org/paru.git
    cd paru || exit
    makepkg -si --noconfirm
    cd .. || exit
else
    echo -e "${GREEN}Paru is already installed.${ENDCOLOR}"
fi

echo -e "${GREEN}Installing essential dependencies for i3wm setup...${ENDCOLOR}"
sudo pacman -S --noconfirm \
    i3 i3status polybar fish dmenu rofi alacritty kitty picom maim \
    imwheel nitrogen polkit-gnome xclip flameshot lxappearance thunar \
    xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xorg-xset gtk3 \
    gnome-settings-daemon gnome-keyring neovim kvantum fastfetch fish \
    zsh ttf-meslo-nerd noto-fonts-emoji ttf-joypixels ttf-jetbrains-mono \
    starship network-manager-applet blueman pasystray

# TODO: Add script to configure and set up dotfiles
echo -e "${GREEN}TODO: Add dotfiles setup script here.${ENDCOLOR}"

echo -e "${GREEN}Dependencies installed successfully. You can now set up your dotfiles.${ENDCOLOR}"
