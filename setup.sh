#!/bin/bash

# Clear the terminal
clear

# Define colors
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

# Header
echo -e "${BLUE}"
cat <<"EOF"
                                                         
        █████╗  █████╗ ██╗   ██╗██╗   ██╗██╗  ██╗        
       ██╔══██╗██╔══██╗██║   ██║██║   ██║██║ ██╔╝        
       ███████║███████║██║   ██║██║   ██║█████╔╝         
       ██╔══██║██╔══██║╚██╗ ██╔╝╚██╗ ██╔╝██╔═██╗         
       ██║  ██║██║  ██║ ╚████╔╝  ╚████╔╝ ██║  ██╗        
       ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝    ╚═══╝  ╚═╝  ╚═╝        
                                                         
         Welcome to Aayush's i3 Setup Script                  |

EOF
echo -e "${ENDCOLOR}"

# 1. Update the system
echo -e "${GREEN}Updating the system...${ENDCOLOR}"
sudo pacman -Syuu --noconfirm

# 2. Install dependencies
echo -e "${GREEN}Installing dependencies...${ENDCOLOR}"
sudo pacman -S --noconfirm \
    i3status polybar fish dmenu rofi alacritty kitty picom maim imwheel \
    nitrogen polkit-gnome xclip flameshot lxappearance thunar

# 3. Choose file manager
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

# 4. Choose browser
echo -e "${GREEN}Choose your preferred browser:${ENDCOLOR}"
options=("Brave" "Firefox" "Thorium")
select opt in "${options[@]}"; do
    case $opt in
        "Brave")
            sudo pacman -S --noconfirm brave
            break
            ;;
        "Firefox")
            sudo pacman -S --noconfirm firefox
            break
            ;;
        "Thorium")
            wget https://aur.archlinux.org/cgit/aur.git/snapshot/thorium-browser-bin.tar.gz
            tar -xvf thorium-browser-bin.tar.gz
            cd thorium-browser-bin
            makepkg -si --noconfirm
            cd ..
            rm -rf thorium-browser-bin thorium-browser-bin.tar.gz
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

# 5. Apply Catppuccin theme with lxappearance
echo -e "${GREEN}Applying Catppuccin theme...${ENDCOLOR}"
THEME_DIR="$HOME/.local/share/themes/catppuccin-macchiato"
mkdir -p $THEME_DIR
git clone https://github.com/catppuccin/openbox $THEME_DIR
lxappearance

# 6. Choose i3status or Polybar
echo -e "${GREEN}Choose your status bar:${ENDCOLOR}"
options=("i3status (comes preloaded with i3)" "Polybar (may consume more resources)")
select opt in "${options[@]}"; do
    case $opt in
        "i3status (comes preloaded with i3)")
            sudo pacman -S --noconfirm i3status
            mkdir -p ~/.config/i3status
            wget -O ~/.config/i3status/config https://raw.githubusercontent.com/aayushx402/i3-CatDotfiles/main/i3%20status/config
            break
            ;;
        "Polybar (may consume more resources)")
            sudo pacman -S --noconfirm polybar
            mkdir -p ~/.config/polybar
            wget -O ~/.config/polybar/config.ini https://raw.githubusercontent.com/aayushx402/i3-CatDotfiles/main/polybar/config.ini
            wget -O ~/.config/polybar/brightness.sh https://raw.githubusercontent.com/aayushx402/i3-CatDotfiles/main/polybar/brightness.sh
            wget -O ~/.config/polybar/gen_i3_ws-icon_list.sh https://raw.githubusercontent.com/aayushx402/i3-CatDotfiles/main/polybar/gen_i3_ws-icon_list.sh
            wget -O ~/.config/polybar/launch.sh https://raw.githubusercontent.com/aayushx402/i3-CatDotfiles/main/polybar/launch.sh
            chmod +x ~/.config/polybar/launch.sh
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

# 7. Apply i3 dotfiles
echo -e "${GREEN}Applying i3 dotfiles...${ENDCOLOR}"
sudo -v
git clone https://github.com/aayushx402/i3-CatDotfiles ~/.config/i3-CatDotfiles
cd ~/.config/i3-CatDotfiles

for dir in *; do
    if [ -d "$HOME/.config/$dir" ]; then
        echo -e "${BLUE}Directory $dir already exists. Replacing...${ENDCOLOR}"
        rm -rf "$HOME/.config/$dir"
    fi
    cp -r "$dir" "$HOME/.config/"
done

rm -rf ~/.config/i3-CatDotfiles

# 8. Apply SDDM Catppuccin theme
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

# 9. Enable system services
echo -e "${GREEN}Enabling system services...${ENDCOLOR}"
systemctl --user enable pipewire pipewire-pulse
sudo systemctl enable NetworkManager
sudo systemctl disable gdm
sudo systemctl disable lightdm
sudo systemctl enable sddm

# 10. Additional theming options
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

# 11. Finished setup
echo -e "${GREEN}Setup complete. Please reboot your system to see the changes or press Mod + Shift + R to reload i3wm.${ENDCOLOR}"