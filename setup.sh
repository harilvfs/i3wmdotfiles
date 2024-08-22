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
    nitrogen variety polkit-gnome xclip flameshot lxappearance thunar

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

# Clone the repository to a temporary directory
TEMP_DIR=$(mktemp -d)
git clone https://github.com/aayushx402/i3-CatDotfiles $TEMP_DIR

# Loop through the directories in the repository
for dir in $(ls -d $TEMP_DIR/*/); do
    dir_name=$(basename "$dir")
    if [ -d "$HOME/.config/$dir_name" ]; then
        echo -e "${BLUE}Directory $dir_name already exists. Replacing...${ENDCOLOR}"
        rm -rf "$HOME/.config/$dir_name"
    fi
    cp -r "$dir" "$HOME/.config/"
done

# Clean up the temporary directory
rm -rf $TEMP_DIR

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

#11. Grub2 Theme

ROOT_UID=0
THEME_DIR="/boot/grub/themes"
THEME_NAME=CyberRe
MAX_DELAY=20                                        # max delay for user to enter root pass

#COLORS
CDEF=" \033[0m"                                     # default color
CCIN=" \033[0;36m"                                  # info color
CGSC=" \033[0;32m"                                  # success color
CRER=" \033[0;31m"                                  # error color
CWAR=" \033[0;33m"                                  # waring color
b_CDEF=" \033[1;37m"                                # bold default color
b_CCIN=" \033[1;36m"                                # bold info color
b_CGSC=" \033[1;32m"                                # bold success color
b_CRER=" \033[1;31m"                                # bold error color
b_CWAR=" \033[1;33m"                                # bold warning color

# echo like ...  with  flag type  and display message  colors
prompt () {
  case ${1} in
    "-s"|"--success")
      echo -e "${b_CGSC}${@/-s/}${CDEF}";;          # print success message
    "-e"|"--error")
      echo -e "${b_CRER}${@/-e/}${CDEF}";;          # print error message
    "-w"|"--warning")
      echo -e "${b_CWAR}${@/-w/}${CDEF}";;          # print warning message
    "-i"|"--info")
      echo -e "${b_CCIN}${@/-i/}${CDEF}";;          # print info message
    *)
    echo -e "$@"
    ;;
  esac
}

# Welcome message
prompt -s "\n\t************************\n\t*  ${THEME_NAME} - Grub2 Theme  *\n\t************************"

# Check command avalibility
function has_command() {
  command -v $1 > /dev/null
}

# Checking for root access and proceed if it is present
if [ "$UID" -eq "$ROOT_UID" ]; then

  # Create themes directory if not exists
  prompt -i "\nChecking directory...\n"
  [[ -d ${THEME_DIR}/${THEME_NAME} ]] && rm -rf ${THEME_DIR}/${THEME_NAME}
  mkdir -p "${THEME_DIR}/${THEME_NAME}"

  # Copy theme
  prompt -i "\nInstalling theme...\n"

  cp -a ${THEME_NAME}/* ${THEME_DIR}/${THEME_NAME}

  # Set theme
  prompt -i "\nSetting the theme as main...\n"

  # Backup grub config
  cp -an /etc/default/grub /etc/default/grub.bak

  grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub

  echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub

  # Update grub config
  echo -e "Updating grub..."
  if has_command update-grub; then
    update-grub
  elif has_command grub-mkconfig; then
    grub-mkconfig -o /boot/grub/grub.cfg
  elif has_command grub2-mkconfig; then
    if has_command zypper; then
      grub2-mkconfig -o /boot/grub2/grub.cfg
    elif has_command dnf; then
      grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    fi
  fi

  # Success message
  prompt -s "\n\t          ***************\n\t          *  installed!  *\n\t          ***************\n"

else

  # Error message
  prompt -e "\n [ Error! ] -> Run me as root "

  # persisted execution of the script as root
  read -p "[ trusted ] specify the root password : " -t${MAX_DELAY} -s
  [[ -n "$REPLY" ]] && {
    sudo -S <<< $REPLY $0
  } || {
    prompt  "\n Operation canceled"
    exit 1
  }
fi

# 12. Finished setup
echo -e "${GREEN}Setup complete. Please reboot your system to see the changes or press Mod + Shift + R to reload i3wm.${ENDCOLOR}"
