#!/bin/bash

clear

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

BACKUP_DIR="$HOME/.i3wmdotfiles/backup"
DOTFILES_REPO="https://github.com/harilvfs/i3wmdotfiles"
DOTFILES_DIR="$HOME/i3wmdotfiles"
WALLPAPER_REPO="https://github.com/harilvfs/wallpapers"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

echo -e "${BLUE}"
figlet -f slant "i3wm"
echo -e "${ENDCOLOR}"

echo -e "${YELLOW}Warning: Do not re-run the script . If you encounter issues, remove the .i3wmdotfiles directory in your home directory..${ENDCOLOR}"

if ! gum confirm "Continue with i3 setup?"; then
    echo -e "${RED}Setup aborted by the user.${NC}"
    exit 1
fi

if [[ -f /etc/os-release ]]; then
    source /etc/os-release
else
    echo -e "${GREEN}Unsupported system!${ENDCOLOR}"
    exit 1
fi

if [[ "$ID" == "arch" ]]; then
    OS="arch"
elif [[ "$ID" == "fedora" ]]; then
    OS="fedora"
else
    echo -e "${GREEN}This script only supports Arch Linux and Fedora.${ENDCOLOR}"
    exit 1
fi

echo -e "${GREEN}Detected OS: $OS${ENDCOLOR}"

echo -e "${GREEN}Updating the system...${ENDCOLOR}"
if [[ "$OS" == "arch" ]]; then
    sudo pacman -Syuu --noconfirm
elif [[ "$OS" == "fedora" ]]; then
    sudo dnf update -y
fi

if [[ "$OS" == "arch" ]]; then
    echo -e "${GREEN}Checking for AUR helper...${ENDCOLOR}"
    if ! command -v paru &>/dev/null && ! command -v yay &>/dev/null; then
        echo -e "${GREEN}Installing Yay as AUR helper...${ENDCOLOR}"
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si --noconfirm
        cd .. || exit
        rm -rf yay
    else
        echo -e "${GREEN}AUR helper already installed.${ENDCOLOR}"
    fi
fi

install_starship() {
    echo -e "${GREEN}Installing Starship...${ENDCOLOR}"
    curl -sS https://starship.rs/install.sh | sh
}

echo -e "${GREEN}Installing essential dependencies for i3wm setup...${ENDCOLOR}"
if [[ "$OS" == "arch" ]]; then
    sudo pacman -S --noconfirm --needed \
        i3 rofi maim git \
        imwheel nitrogen polkit-gnome xclip flameshot thunar \
        xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xorg-xset gtk3 \
        gnome-settings-daemon gnome-keyring neovim \
        ttf-meslo-nerd noto-fonts-emoji ttf-joypixels ttf-jetbrains-mono \
        starship network-manager-applet blueman pasystray wget unzip starship \
        curl zoxide
elif [[ "$OS" == "fedora" ]]; then
    sudo dnf install -y \
        i3 polybar rofi maim \
        imwheel xclip flameshot lxappearance thunar xorg-x11-server-Xorg \
        xorg-x11-xinit xrandr gtk3 gnome-settings-daemon gnome-keyring \
        neovim network-manager-applet blueman pasystray git jetbrains-mono-fonts-all \
        google-noto-color-emoji-fonts google-noto-emoji-fonts wget unzip curl zoxide

    install_starship
fi

echo -e "${GREEN}Checking if Brave browser is already installed...${ENDCOLOR}"
if command -v brave &>/dev/null || flatpak list | grep -q "com.brave.Browser"; then
    echo -e "${GREEN}Brave browser is already installed, skipping installation.${ENDCOLOR}"
else
    echo -e "${GREEN}Installing Brave browser...${ENDCOLOR}"
    if [[ "$OS" == "arch" ]]; then
        yay -S --noconfirm brave-bin
    elif [[ "$OS" == "fedora" ]]; then
        if ! command -v flatpak &>/dev/null; then
            echo -e "${GREEN}Installing Flatpak...${ENDCOLOR}"
            sudo dnf install -y flatpak
        fi
        echo -e "${GREEN}Adding Flathub repository...${ENDCOLOR}"
        sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        echo -e "${GREEN}Installing Brave browser via Flatpak...${ENDCOLOR}"
        sudo flatpak install -y flathub com.brave.Browser
    fi
fi

echo -e "${GREEN}All dependencies installed successfully.${ENDCOLOR}"

echo -e "${GREEN}Checking for existing dotfiles repository...${ENDCOLOR}"

if [[ -d "$DOTFILES_DIR" ]]; then
    echo -e "${YELLOW}Existing dotfiles repository found.${ENDCOLOR}"
    read -rp "Do you want to remove it? (y/N): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo -e "${GREEN}Removing existing dotfiles repository...${ENDCOLOR}"
        rm -rf "$DOTFILES_DIR"
    else
        echo -e "${GREEN}Aborting setup to avoid conflicts.${ENDCOLOR}"
        exit 1
    fi
fi

echo -e "${GREEN}Cloning dotfiles repository...${ENDCOLOR}"
git clone "$DOTFILES_REPO" "$DOTFILES_DIR" || { 
    echo -e "${GREEN}Failed to clone repository.${ENDCOLOR}"; 
    exit 1; 
}

echo -e "${YELLOW}Choose your color scheme (catppuccin/nord)${ENDCOLOR}"
echo -e "${YELLOW}Type Full Sentence like catppuccin or nord${ENDCOLOR}"
read -rp "Enter your choice: " COLOR_SCHEME
COLOR_SCHEME=$(echo "$COLOR_SCHEME" | tr '[:upper:]' '[:lower:]')

if [[ "$COLOR_SCHEME" != "catppuccin" && "$COLOR_SCHEME" != "nord" ]]; then
    echo -e "${GREEN}Invalid choice. Defaulting to Catppuccin.${ENDCOLOR}"
    COLOR_SCHEME="catppuccin"
fi

echo -e "${GREEN}Installing required packages...${ENDCOLOR}"
if [[ "$OS" == "arch" ]]; then
    sudo pacman -S --noconfirm --needed kvantum alacritty dunst fastfetch picom
elif [[ "$OS" == "fedora" ]]; then
    sudo dnf install -y kvantum alacritty dunst fastfetch picom
fi

mkdir -p "$BACKUP_DIR"

backup_and_replace() {
    local config_path="$HOME/.config/$1"
    if [[ -d "$config_path" ]]; then
        echo -e "${GREEN}Backing up existing $1 configuration...${ENDCOLOR}"
        mv "$config_path" "$BACKUP_DIR/"
    fi
    cp -r "$DOTFILES_DIR/$1" "$HOME/.config/"
}

backup_and_replace "Kvantum"
backup_and_replace "alacritty"
backup_and_replace "dunst"
backup_and_replace "fastfetch"

if [[ -d "$HOME/.config/alacritty" ]]; then
    echo -e "${GREEN}Running 'alacritty migrate'...${ENDCOLOR}"
    (cd "$HOME/.config/alacritty" && alacritty migrate)
fi

PICOM_CONFIG_DIR="$HOME/.config/"
mkdir -p "$PICOM_CONFIG_DIR"
if [[ -f "$PICOM_CONFIG_DIR/picom.conf" ]]; then
    echo -e "${GREEN}Backing up existing picom configuration...${ENDCOLOR}"
    mv "$PICOM_CONFIG_DIR/picom.conf" "$BACKUP_DIR/"
fi
cp "$DOTFILES_DIR/picom/picom-transparency/picom.conf" "$PICOM_CONFIG_DIR/"

for shell_config in .bashrc .zshrc; do
    if [[ -f "$HOME/$shell_config" ]]; then
        echo -e "${YELLOW}Found existing $shell_config.${ENDCOLOR}"
        read -rp "Replace with new config? (y/N): " choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            mv "$HOME/$shell_config" "$BACKUP_DIR/"
            cp "$DOTFILES_DIR/$shell_config" "$HOME/"
        fi
    fi
done

echo -e "${GREEN}Installing required packages...${ENDCOLOR}"
if [[ "$OS" == "arch" ]]; then
    sudo pacman -S --noconfirm --needed fish
elif [[ "$OS" == "fedora" ]]; then
    sudo dnf install -y fish 
fi

if [[ -d "$HOME/.config/fish" ]]; then
    echo -e "${YELLOW}Found existing Fish config.${ENDCOLOR}"
    read -rp "Replace with new config? (y/N): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        mv "$HOME/.config/fish" "$BACKUP_DIR/"
        cp -r "$DOTFILES_DIR/fish" "$HOME/.config/"
    fi
fi


echo -e "${YELLOW}Choose your bar (polybar/i3status) [Polybar recommended]${ENDCOLOR}"
echo -e "${YELLOW}Type Full Sentence Like polybar or i3status${ENDCOLOR}"
read -rp "Choose your bar: " BAR_CHOICE
BAR_CHOICE=$(echo "$BAR_CHOICE" | tr '[:upper:]' '[:lower:]')

if [[ "$BAR_CHOICE" == "polybar" ]]; then
    echo -e "${GREEN}Setting up Polybar...${ENDCOLOR}"

    if command -v i3status &>/dev/null; then
        echo -e "${GREEN}Removing i3status...${ENDCOLOR}"
        if [[ "$OS" == "arch" ]]; then
            sudo pacman -Rns --noconfirm i3status
        elif [[ "$OS" == "fedora" ]]; then
            sudo dnf remove -y i3status
        fi
    fi

    cd "$DOTFILES_DIR" && git switch catppuccin
    backup_and_replace "polybar"
    git switch main
    git switch polybar
    backup_and_replace "i3"
    git switch main

elif [[ "$BAR_CHOICE" == "i3status" ]]; then
    echo -e "${GREEN}Setting up I3status...${ENDCOLOR}"
    cd "$DOTFILES_DIR" && git switch nord
    backup_and_replace "i3status"
    git switch i3status
    backup_and_replace "i3"
    git switch main

else
    echo -e "${GREEN}Invalid choice. Defaulting to Polybar.${ENDCOLOR}"
fi

cd "$DOTFILES_DIR" && git switch "$COLOR_SCHEME"
backup_and_replace "rofi"
backup_and_replace "starship"
backup_and_replace "nvim"

echo -e "${GREEN}Dotfiles setup complete.${ENDCOLOR}"



if [[ ! -d "$HOME/Pictures" ]]; then
    echo -e "${GREEN}Creating ~/Pictures directory...${ENDCOLOR}"
    mkdir -p "$HOME/Pictures"
fi

if [[ -d "$WALLPAPER_DIR" ]]; then
    echo -e "${YELLOW}Wallpapers directory already exists.${ENDCOLOR}"
    read -rp "Do you want to remove and re-clone? (y/N): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        echo -e "${GREEN}Removing existing wallpapers directory...${ENDCOLOR}"
        rm -rf "$WALLPAPER_DIR"
        echo -e "${GREEN}Cloning wallpapers repository...${ENDCOLOR}"
        git clone "$WALLPAPER_REPO" "$WALLPAPER_DIR"
    else
        echo -e "${GREEN}Skipping wallpaper cloning.${ENDCOLOR}"
    fi
else
    echo -e "${GREEN}Cloning wallpapers repository...${ENDCOLOR}"
    git clone "$WALLPAPER_REPO" "$WALLPAPER_DIR"
fi

install_lxappearance() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            arch*)
                sudo pacman -S --noconfirm lxappearance
                ;;
            fedora*)
                sudo dnf install -y lxappearance
                ;;
            *)
                echo -e "${RED}Unsupported distribution.${ENDCOLOR}"
                exit 1
                ;;
        esac
    fi
}

clone_themes_icons() {
    check_remove_dir ~/themes ~/icons

    echo -e "${GREEN}Cloning themes repository...${ENDCOLOR}"
    git clone https://github.com/harilvfs/themes.git ~/themes
    
    echo -e "${GREEN}Cloning icons repository...${ENDCOLOR}"
    git clone https://github.com/harilvfs/icons.git ~/icons
}

check_remove_dir() {
    for dir in "$1" "$2"; do
        if [ -d "$dir" ]; then
            echo -e "${YELLOW} $dir already exists.${ENDCOLOR}"
            read -rp "Do you want to remove it? (y/n): " remove_dir
            if [[ "$remove_dir" =~ ^[Yy]$ ]]; then
                rm -rf "$dir"
                echo -e "${GREEN}$dir removed.${ENDCOLOR}"
            else
                echo -e "${RED}$dir not removed.${ENDCOLOR}"
            fi
        fi
    done
}

move_themes_icons() {
    check_remove_dir ~/.icons
    check_remove_dir ~/.themes

    echo -e "${GREEN}Creating ~/.themes and ~/.icons directories...${ENDCOLOR}"
    mkdir -p ~/.themes ~/.icons

    echo -e "${GREEN}Moving themes to ~/.themes...${ENDCOLOR}"
    mv ~/themes/* ~/.themes/

    echo -e "${GREEN}Moving icons to ~/.icons...${ENDCOLOR}"
    mv ~/icons/* ~/.icons/
}

install_lxappearance

clone_themes_icons

move_themes_icons

is_sddm_installed() {
    if command -v sddm &> /dev/null; then
        return 0 
    else
        return 1
    fi
}

install_sddm() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            arch*)
                sudo pacman -S --noconfirm sddm
                ;;
            fedora*)
                sudo dnf install -y sddm
                ;;
            *)
                echo -e "${RED}Unsupported distribution.${ENDCOLOR}"
                exit 1
                ;;
        esac
    fi
}

apply_sddm_theme() {
    theme_dir="/usr/share/sddm/themes/catppuccin-mocha"

    if [ -d "$theme_dir" ]; then
        echo -e "${YELLOW} $theme_dir already exists.${ENDCOLOR}"
        read -rp "Do you want to remove the existing theme and continue? (y/n): " remove_dir
        if [[ "$remove_dir" =~ ^[Yy]$ ]]; then
            sudo rm -rf "$theme_dir"
            echo -e "${GREEN}$theme_dir removed.${ENDCOLOR}"
        else
            echo -e "${RED}$theme_dir not removed, exiting.${ENDCOLOR}"
            exit 1
        fi
    fi
}

    temp_dir=$(mktemp -d)
    echo -e "${GREEN}Downloading Catppuccin Mocha theme...${ENDCOLOR}"
    wget https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip -O "$temp_dir/catppuccin-mocha.zip"
    
    unzip "$temp_dir/catppuccin-mocha.zip" -d "$temp_dir"
    
    cd "$temp_dir/catppuccin-mocha" || exit 
    
    echo -e "${GREEN}Copying the theme to /usr/share/sddm/themes...${ENDCOLOR}"
    sudo cp -r "$temp_dir/catppuccin-mocha" /usr/share/sddm/themes/
    
    rm -rf "$temp_dir"

configure_sddm_theme() {
    echo -e "${GREEN}Configuring sddm.conf to use the Catppuccin Mocha theme...${ENDCOLOR}"
    
    if [ ! -f /etc/sddm.conf ]; then
        sudo touch /etc/sddm.conf
    fi

    if ! grep -q "\[Theme\]" /etc/sddm.conf; then
        echo "[Theme]" | sudo tee -a /etc/sddm.conf > /dev/null
    fi
    
    sudo sed -i '/\[Theme\]/a Current=catppuccin-mocha' /etc/sddm.conf
}

enable_start_sddm() {
    echo -e "${GREEN}Checking for existing display managers...${ENDCOLOR}"

    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
    fi

    if command -v gdm &> /dev/null; then
        echo "${BLUE}GDM detected. Removing GDM...${ENDCOLOR}"
        sudo systemctl stop gdm
        sudo systemctl disable gdm --now
        if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
            sudo pacman -Rns --noconfirm gdm
        elif [[ "$ID" == "fedora" ]]; then
            sudo dnf remove -y gdm
        fi
    fi

    if command -v lightdm &> /dev/null; then
        echo "${BLUE}LightDM detected. Removing LightDM...${ENDCOLOR}"
        sudo systemctl stop lightdm
        sudo systemctl disable lightdm --now
        if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
            sudo pacman -Rns --noconfirm lightdm
        elif [[ "$ID" == "fedora" ]]; then
            sudo dnf remove -y lightdm
        fi
    fi

    echo -e "${GREEN}Enabling and starting the sddm service...${ENDCOLOR}"
    sudo systemctl enable sddm --now
}

if ! is_sddm_installed; then
    install_sddm
else
    echo -e "${GREEN}Sddm is already installed, skipping installation.${ENDCOLOR}"
fi

apply_sddm_theme

configure_sddm_theme

enable_start_sddm

echo -e "${GREEN}Sddm theme applied, service started, and configuration updated successfully!${ENDCOLOR}"

create_file() {
    echo -e "${GREEN}Creating script...${ENDCOLOR}"
    sudo tee "/usr/local/bin/numlock" >/dev/null <<'EOF'
#!/bin/bash

for tty in /dev/tty{1..6}
do
    /usr/bin/setleds -D +num < "$tty"; 
done
EOF

    sudo chmod +x /usr/local/bin/numlock
}

create_service() {
    echo -e "${GREEN}Creating service...${ENDCOLOR}"
    sudo tee "/etc/systemd/system/numlock.service" >/dev/null <<'EOF'
[Unit]
Description=numlock
        
[Service]
ExecStart=/usr/local/bin/numlock
StandardInput=tty
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
}

numlockSetup() {
    if [ "$INIT_MANAGER" = "rc-service" ]; then
        echo -e "${RED}Unsupported init system.${ENDCOLOR}"
        exit 1
    fi

    if [ ! -f "/usr/local/bin/numlock" ]; then
        create_file
    fi

    if [ ! -f "/etc/systemd/system/numlock.service" ]; then
        create_service
    fi

    echo -e "${YELLOW}Num Lock on Startup. ${ENDCOLOR}"
    read -rp "Do you want to enable Numlock on boot? (y/N): " confirm
      if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        echo -e "${GREEN}Enabling Numlock on boot...${ENDCOLOR}"
        sudo systemctl enable numlock.service
        echo -e "${GREEN}Numlock will be enabled on boot.${ENDCOLOR}"
      else
        echo -e "${GREEN}Numlock will not be enabled on boot.${ENDCOLOR}"
      fi
}

numlockSetup

display_message() {
    gum style --border "normal" --width 50 --padding 1 --foreground "white" --background "blue" --align "center" "i3wm setup completed"
}

prompt_reboot() {
    echo -e "${YELLOW} Reboot ${ENDCOLOR}"
    read -rp "Do you want to reboot now? (y/N): " reboot_choice
    if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}Rebooting...${ENDCOLOR}"

        gum spin --title "Rebooting system" -- sh -c "sleep 3"

        sudo reboot
    else
        echo -e "${RED}Skipping reboot. You can reboot later.${ENDCOLOR}"
    fi
}


display_message

prompt_reboot
