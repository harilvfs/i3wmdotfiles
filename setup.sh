#!/bin/bash

clear

GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}"
cat <<"EOF"
-----------------------------------------------------------------------------

██╗██████╗ ██╗    ██╗███╗   ███╗    ███████╗███████╗████████╗██╗   ██╗██████╗ 
██║╚════██╗██║    ██║████╗ ████║    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
██║ █████╔╝██║ █╗ ██║██╔████╔██║    ███████╗█████╗     ██║   ██║   ██║██████╔╝
██║ ╚═══██╗██║███╗██║██║╚██╔╝██║    ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██║██████╔╝╚███╔███╔╝██║ ╚═╝ ██║    ███████║███████╗   ██║   ╚██████╔╝██║     
╚═╝╚═════╝  ╚══╝╚══╝ ╚═╝     ╚═╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     
                                                                              
-----------------------------------------------------------------------------
                 This will only install necessary dependencies                
          For dotfiles, check my repo: github.com/harilvfs/i3wmdotfiles          
-----------------------------------------------------------------------------
EOF
echo -e "${ENDCOLOR}"

read -p "Do you want to continue with the installation? (y/n): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "Installation aborted."
    exit 1
fi

echo -e "${GREEN}Updating the system...${ENDCOLOR}"
sudo pacman -Syuu --noconfirm

echo -e "${GREEN}Installing Paru...${ENDCOLOR}"
git clone https://aur.archlinux.org/paru.git
cd paru || exit
makepkg -si --noconfirm
cd .. || exit

echo -e "${GREEN}Choose your preferred browser to install:${ENDCOLOR}"
browsers=("Brave" "Firefox" "Chromium" "None")
select browser in "${browsers[@]}"; do
    case $browser in
        "Brave")
            echo -e "${GREEN}Installing Brave browser with Paru...${ENDCOLOR}"
            paru -S --noconfirm brave-bin
            break
            ;;
        "Firefox")
            echo -e "${GREEN}Installing Firefox...${ENDCOLOR}"
            sudo pacman -S --noconfirm firefox
            break
            ;;
        "Chromium")
            echo -e "${GREEN}Installing Chromium...${ENDCOLOR}"
            sudo pacman -S --noconfirm chromium
            break
            ;;
        "None")
            echo -e "${GREEN}Skipping browser installation...${ENDCOLOR}"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo -e "${GREEN}Installing dependencies...${ENDCOLOR}"
sudo pacman -S --noconfirm i3 i3status polybar fish dmenu rofi alacritty kitty picom maim imwheel nitrogen variety polkit-gnome xclip flameshot lxappearance thunar xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xorg-xset gtk3 gnome-settings-daemon lightdm lightdm-gtk-greeter

echo -e "${GREEN}Choose your preferred file manager:${ENDCOLOR}"
options=("Thunar" "Nemo" "Dolphin")
select opt in "${options[@]}"; do
    case $opt in
        "Thunar")
            sudo pacman -S --noconfirm thunar
            break
            ;;
        "Nemo")
            sudo pacman -S --noconfirm nemo
            break
            ;;
        "Dolphin")
            sudo pacman -S --noconfirm dolphin
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo -e "${GREEN}Applying Catppuccin theme...${ENDCOLOR}"
THEME_DIR="$HOME/.local/share/themes/catppuccin-macchiato"
mkdir -p $THEME_DIR
git clone https://github.com/catppuccin/openbox $THEME_DIR
lxappearance

apply_sddm_theme() {
    echo -e "${BLUE}"
    cat <<"EOF"
+-------------------------------------------------------+
|  Setting up Catppuccin SDDM Theme                     |
+-------------------------------------------------------+
EOF
    echo -e "${ENDCOLOR}"

    while true; do
        read -p "Do you want to continue with the SDDM and Catppuccin theme installation? [Y/n] " yn
        case $yn in
            [Yy]* ) echo "Proceeding with installation..."; break;;
            [Nn]* ) echo "Installation aborted."; return;;
            * ) echo "Invalid response. Proceeding with installation..."; break;;
        esac
    done

    if ! command -v sddm &> /dev/null; then
        echo -e "${GREEN}Installing SDDM...${ENDCOLOR}"
        sudo pacman -S sddm --noconfirm
    else
        echo -e "${GREEN}SDDM is already installed.${ENDCOLOR}"
    fi

    THEME_DIR="/usr/share/sddm/themes/catppuccin-mocha"
    if [ ! -d "$THEME_DIR" ]; then
        echo -e "${GREEN}Downloading Catppuccin SDDM theme...${ENDCOLOR}"
        sudo mkdir -p $THEME_DIR
        sudo wget -O $THEME_DIR/theme.tar.gz https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.tar.gz
        sudo tar -xzvf $THEME_DIR/theme.tar.gz -C $THEME_DIR --strip-components=1
        sudo rm $THEME_DIR/theme.tar.gz
    else
        echo -e "${GREEN}Catppuccin SDDM theme is already installed.${ENDCOLOR}"
    fi

    echo -e "${GREEN}Setting Catppuccin as the SDDM theme...${ENDCOLOR}"
    sudo bash -c 'cat > /etc/sddm.conf <<EOF
[Theme]
Current=catppuccin-mocha
EOF'

    echo -e "${GREEN}Enabling SDDM...${ENDCOLOR}"
    sudo systemctl enable sddm --force
    sudo systemctl disable lightdm
    sudo systemctl disable gdm

    echo -e "${GREEN}SDDM theme setup complete.${ENDCOLOR}"
}

echo -e "${GREEN}Enabling system services...${ENDCOLOR}"
systemctl --user enable pipewire pipewire-pulse
sudo systemctl enable NetworkManager

echo -e "${GREEN}Choose additional theming options:${ENDCOLOR}"
options=("Catppuccin GTK Theme" "Catppuccin Icon Theme" "Both" "None")
select opt in "${options[@]}"; do
    case $opt in
        "Catppuccin GTK Theme")
            echo -e "${GREEN}Applying Catppuccin GTK Theme...${ENDCOLOR}"
            THEME_DIR="$HOME/.local/share/themes/Catppuccin-Mocha-Standard-Lavender"
            mkdir -p $THEME_DIR
            git clone https://github.com/catppuccin/gtk $THEME_DIR
            gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Lavender"
            break
            ;;
        "Catppuccin Icon Theme")
            echo -e "${GREEN}Applying Catppuccin Icon Theme...${ENDCOLOR}"
            ICON_DIR="$HOME/.local/share/icons/Catppuccin-Mocha"
            mkdir -p $ICON_DIR
            git clone https://github.com/catppuccin/icons $ICON_DIR
            gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-Mocha"
            break
            ;;
        "Both")
            echo -e "${GREEN}Applying Catppuccin GTK and Icon Themes...${ENDCOLOR}"
            THEME_DIR="$HOME/.local/share/themes/Catppuccin-Mocha-Standard-Lavender"
            mkdir -p $THEME_DIR
            git clone https://github.com/catppuccin/gtk $THEME_DIR
            gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Lavender"
            
            ICON_DIR="$HOME/.local/share/icons/Catppuccin-Mocha"
            mkdir -p $ICON_DIR
            git clone https://github.com/catppuccin/icons $ICON_DIR
            gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-Mocha"
            break
            ;;
        "None")
            echo -e "${GREEN}Skipping additional theming...${ENDCOLOR}"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Cloning repository..."
git clone https://github.com/harilvfs/i3wmdotfiles

cd i3wmdotfiles/grub || exit

echo "Copying GRUB theme..."
sudo cp -r CyberRe /usr/share/grub/themes

echo "Updating GRUB configuration..."
sudo sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/CyberRe/theme.txt"|' /etc/default/grub

if grep -q "Arch" /etc/os-release; then
    echo "Generating GRUB configuration for Arch Linux..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
else
    echo "Updating GRUB..."
    sudo update-grub
fi

echo "GRUB setup completed successfully!"

echo -e "${GREEN}Setup complete. Please reboot your system.${ENDCOLOR}"
