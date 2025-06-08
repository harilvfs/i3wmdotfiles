#!/usr/bin/env bash

clear

RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
TEAL="\e[38;2;129;200;190m"
ENDCOLOR="\e[0m"

BACKUP_DIR="$HOME/.i3wmdotfiles/backup"
DOTFILES_REPO="https://github.com/harilvfs/i3wmdotfiles"
DOTFILES_DIR="$HOME/i3wmdotfiles"
WALLPAPER_REPO="https://github.com/harilvfs/wallpapers"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
WALLPAPER_SKIP=0

FZF_COMMON="--layout=reverse \
            --border=bold \
            --border=rounded \
            --margin=5% \
            --color=dark \
            --info=inline \
            --header-first \
            --bind change:top"

fzf_confirm() {
    local prompt="$1"
    local options=("Yes" "No")
    local selected=$(printf "%s\n" "${options[@]}" | fzf ${FZF_COMMON} \
                                                     --height=40% \
                                                     --prompt="$prompt " \
                                                     --header="Confirm" \
                                                     --pointer="➤" \
                                                     --color='fg:white,fg+:green,bg+:black,pointer:green')

    if [[ "$selected" == "Yes" ]]; then
        return 0
    else
        return 1
    fi
}

fzf_select_option() {
    local prompt="$1"
    local header="$2"
    shift 2
    local options=("$@")

    local selected=$(printf "%s\n" "${options[@]}" | fzf ${FZF_COMMON} \
                                                    --height=50% \
                                                    --prompt="$prompt " \
                                                    --header="$header" \
                                                    --pointer="➤" \
                                                    --color='fg:white,fg+:cyan,bg+:black,pointer:cyan')
    echo "$selected"
}

APPLY_ALL_CONFIGS=false

fzf_config_confirm() {
    local config_name="$1"

    if [[ "$APPLY_ALL_CONFIGS" == "true" ]]; then
        return 0
    fi

    local options=("Yes, for this one" "Yes, don't ask again" "No")
    local selected=$(printf "%s\n" "${options[@]}" | fzf ${FZF_COMMON} \
                                                    --height=50% \
                                                    --prompt="Apply $config_name config? " \
                                                    --header="Config Installation" \
                                                    --pointer="➤" \
                                                    --color='fg:white,fg+:yellow,bg+:black,pointer:yellow')

    case "$selected" in
        "Yes, for this one")
            return 0
            ;;
        "Yes, don't ask again")
            APPLY_ALL_CONFIGS=true
            return 0
            ;;
        "No"|*)
            return 1
            ;;
    esac
}

if ! command -v fzf &> /dev/null; then
    echo -e "${RED}${BOLD}Error: fzf is not installed${NC}"
    echo -e "${YELLOW}Please install fzf before running this script:${NC}"
    echo -e "${CYAN}  • Fedora: ${NC}sudo dnf install fzf"
    echo -e "${CYAN}  • Arch Linux: ${NC}sudo pacman -S fzf"
    exit 1
fi

echo -e "${YELLOW}Warning: If you are re-running this script, Remember to remove the .i3wmdotfiles directory in your home directory to avoid any conflicts..${ENDCOLOR}"

if command -v pacman &>/dev/null; then
   OS="arch"
elif command -v dnf &>/dev/null; then
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
    AUR_HELPER=""

    for helper in paru yay; do
        if command -v "$helper" &>/dev/null; then
            AUR_HELPER="$helper"
            echo -e "${GREEN}Found AUR helper: $AUR_HELPER${ENDCOLOR}"
            break
        fi
    done

    if [[ -z "$AUR_HELPER" ]]; then
        echo -e "${GREEN}No AUR helper found. Installing Yay...${ENDCOLOR}"
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si --noconfirm
        cd .. || exit
        rm -rf yay
        AUR_HELPER="yay"
    fi
fi

install_starship() {
    echo -e "${GREEN}Installing Starship...${ENDCOLOR}"
    curl -sS https://starship.rs/install.sh | sh
}

install_pokemon_colorscripts() {
    echo -e "${CYAN}Installing Pokémon Color Scripts...${ENDCOLOR}"
    case "$OS" in
        arch)
            AUR_HELPERS=("yay" "paru")
            AUR_HELPER=""
            for helper in "${AUR_HELPERS[@]}"; do
                if command -v "$helper" &>/dev/null; then
                    AUR_HELPER="$helper"
                    echo -e "${GREEN}Found AUR helper: $AUR_HELPER${RESET}"
                    break
                fi
            done
            if [[ -z "$AUR_HELPER" ]]; then
                echo -e "${CYAN}No AUR helper found. Installing yay...${RESET}"
                echo -e "${CYAN}Installing dependencies...${RESET}"
                sudo pacman -S --needed --noconfirm git base-devel
                TEMP_DIR=$(mktemp -d)
                cd "$TEMP_DIR" || {
                    echo -e "${RED}Failed to create temporary directory${RESET}"
                    exit 1
                }
                echo -e "${CYAN}Cloning yay repository...${RESET}"
                git clone https://aur.archlinux.org/yay.git || {
                    echo -e "${RED}Failed to clone yay repository${RESET}"
                    cd "$HOME" || exit 1
                    rm -rf "$TEMP_DIR"
                    exit 1
                }
                cd yay || {
                    echo -e "${RED}Failed to enter yay directory${RESET}"
                    cd "$HOME" || exit 1
                    rm -rf "$TEMP_DIR"
                    exit 1
                }
                echo -e "${CYAN}Building yay...${RESET}"
                makepkg -si --noconfirm || {
                    echo -e "${RED}Failed to build yay${RESET}"
                    cd "$HOME" || exit 1
                    rm -rf "$TEMP_DIR"
                    exit 1
                }
                cd "$HOME" || exit 1
                rm -rf "$TEMP_DIR"
                AUR_HELPER="yay"
                echo -e "${GREEN}Successfully installed yay!${RESET}"
            fi
            echo -e "${CYAN}Installing Pokémon Color Scripts (AUR)...${RESET}"
            $AUR_HELPER -S --noconfirm pokemon-colorscripts-git || {
                echo -e "${RED}Failed to install pokemon-colorscripts-git${RESET}"
                exit 1
            }
            ;;
        fedora)
            if [[ -d "$HOME/pokemon-colorscripts" ]]; then
                echo -e "${YELLOW}Found existing Pokémon Color Scripts directory. Removing...${RESET}"
                rm -rf "$HOME/pokemon-colorscripts"
            fi
            echo -e "${CYAN}Installing dependencies...${RESET}"
            sudo dnf install -y git
            echo -e "${CYAN}Cloning Pokémon Color Scripts...${RESET}"
            git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git "$HOME/pokemon-colorscripts"
            if [[ -d "$HOME/pokemon-colorscripts" ]]; then
                cd "$HOME/pokemon-colorscripts" || {
                    echo -e "${RED}Failed to change directory to pokemon-colorscripts!${RESET}";
                    return 1;
                }
                echo -e "${CYAN}Installing Pokémon Color Scripts...${RESET}"
                sudo ./install.sh
                cd - > /dev/null || true
            else
                echo -e "${RED}Failed to clone pokemon-colorscripts repository!${RESET}"
                return 1
            fi
            ;;
    esac
    echo -e "${GREEN}Pokémon Color Scripts installed successfully!${ENDCOLOR}"
}

echo -e "${GREEN}Installing essential dependencies for i3wm setup...${ENDCOLOR}"

if [[ "$OS" == "arch" ]]; then
    sudo pacman -S --noconfirm \
        i3 rofi maim git \
        imwheel nitrogen polkit-gnome xclip flameshot thunar \
        xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xorg-xset gtk3 gtk4 \
        gnome-settings-daemon gnome-keyring neovim \
        ttf-meslo-nerd noto-fonts-emoji ttf-jetbrains-mono \
        starship network-manager-applet blueman pasystray wget unzip \
        curl zoxide polybar i3status nwg-look qt5ct qt6ct
elif [[ "$OS" == "fedora" ]]; then
    sudo dnf copr enable -y solopasha/hyprland || echo -e "${YELLOW}Failed to enable Hyprland COPR repository${ENDCOLOR}"

    sudo dnf install -y \
        i3 polybar rofi maim \
        imwheel xclip flameshot lxappearance thunar xorg-x11-server-Xorg \
        xorg-x11-xinit xrandr gtk3 gtk4 gnome-settings-daemon gnome-keyring \
        neovim network-manager-applet blueman pasystray git \
        jetbrains-mono-fonts-all google-noto-color-emoji-fonts \
        google-noto-emoji-fonts wget unzip curl zoxide polybar i3status \
        nwg-look qt5ct qt6ct

    install_starship
fi

install_pokemon_colorscripts

if fzf_confirm "Do you want to install Brave browser?"; then
    echo -e "${GREEN}Checking if Brave browser is already installed...${ENDCOLOR}"

    brave_installed=false

    if command -v brave &>/dev/null || command -v brave-browser &>/dev/null; then
        brave_installed=true
        echo -e "${GREEN}Brave browser (native) is already installed.${ENDCOLOR}"
    fi

    if command -v flatpak &>/dev/null; then
        if flatpak list 2>/dev/null | grep -q "com.brave.Browser"; then
            brave_installed=true
            echo -e "${GREEN}Brave browser (Flatpak) is already installed.${ENDCOLOR}"
        fi
    fi

    if [[ "$brave_installed" == "false" ]]; then
        echo -e "${GREEN}Installing Brave browser...${ENDCOLOR}"
        if [[ "$OS" == "arch" ]]; then
            "$AUR_HELPER" -S --noconfirm brave-bin
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
        echo -e "${GREEN}Brave browser installed successfully.${ENDCOLOR}"
    else
        echo -e "${GREEN}Brave browser installation skipped (already installed).${ENDCOLOR}"
    fi
else
    echo -e "${YELLOW}Skipping Brave browser installation.${ENDCOLOR}"
fi

echo -e "${GREEN}All dependencies installed successfully.${ENDCOLOR}"

echo -e "${GREEN}Checking for existing dotfiles repository...${ENDCOLOR}"

if [[ -d "$DOTFILES_DIR" ]]; then
    echo -e "${YELLOW}Existing dotfiles repository found.${ENDCOLOR}"
    if fzf_confirm "Do you want to remove existing dotfiles repository?"; then
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

echo -e "${YELLOW}Choose your color scheme${ENDCOLOR}"
COLOR_SCHEME=$(fzf_select_option "Select Color Scheme:" "Available Color Schemes" "catppuccin" "nord")

if [[ -z "$COLOR_SCHEME" ]]; then
    echo -e "${GREEN}No selection made. Defaulting to Catppuccin.${ENDCOLOR}"
    COLOR_SCHEME="catppuccin"
fi

COLOR_SCHEME=$(echo "$COLOR_SCHEME" | tr '[:upper:]' '[:lower:]')

echo -e "${GREEN}Installing required packages...${ENDCOLOR}"
if [[ "$OS" == "arch" ]]; then
    sudo pacman -S --noconfirm --needed kvantum alacritty dunst fastfetch picom
elif [[ "$OS" == "fedora" ]]; then
    sudo dnf install -y kvantum alacritty dunst fastfetch picom
fi

mkdir -p "$BACKUP_DIR"

backup_and_replace() {
    local config_name="$1"
    local config_path="$HOME/.config/$1"

    if ! fzf_config_confirm "$config_name"; then
        echo -e "${YELLOW}Skipping $config_name configuration...${ENDCOLOR}"
        return
    fi

    if [[ -d "$config_path" ]]; then
        echo -e "${GREEN}Backing up existing $config_name configuration...${ENDCOLOR}"
        mv "$config_path" "$BACKUP_DIR/"
    fi
    echo -e "${GREEN}Applying $config_name configuration...${ENDCOLOR}"
    cp -r "$DOTFILES_DIR/$config_name" "$HOME/.config/"
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

if fzf_config_confirm "picom"; then
    if [[ -f "$PICOM_CONFIG_DIR/picom.conf" ]]; then
        echo -e "${GREEN}Backing up existing picom configuration...${ENDCOLOR}"
        mv "$PICOM_CONFIG_DIR/picom.conf" "$BACKUP_DIR/"
    fi
    echo -e "${GREEN}Applying picom configuration...${ENDCOLOR}"
    cp "$DOTFILES_DIR/picom/picom-transparency/picom.conf" "$PICOM_CONFIG_DIR/"
else
    echo -e "${YELLOW}Skipping picom configuration...${ENDCOLOR}"
fi

for shell_config in .bashrc .zshrc; do
    if [[ -f "$HOME/$shell_config" ]]; then
        echo -e "${YELLOW}Found existing $shell_config.${ENDCOLOR}"
        config_display_name=$(echo "$shell_config" | sed 's/^\.//')
        if fzf_config_confirm "$config_display_name"; then
            mv "$HOME/$shell_config" "$BACKUP_DIR/"
            echo -e "${GREEN}Applying $shell_config configuration...${ENDCOLOR}"
            cp "$DOTFILES_DIR/$shell_config" "$HOME/"
        else
            echo -e "${YELLOW}Skipping $shell_config configuration...${ENDCOLOR}"
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
    if fzf_config_confirm "fish"; then
        mv "$HOME/.config/fish" "$BACKUP_DIR/"
        echo -e "${GREEN}Applying fish configuration...${ENDCOLOR}"
        cp -r "$DOTFILES_DIR/fish" "$HOME/.config/"
    else
        echo -e "${YELLOW}Skipping fish configuration...${ENDCOLOR}"
    fi
fi

echo -e "${YELLOW}Choose your status bar${ENDCOLOR}"
BAR_CHOICE=$(fzf_select_option "Select Status Bar:" "Available Status Bars (Polybar recommended)" "polybar" "i3status")

if [[ -z "$BAR_CHOICE" ]]; then
    echo -e "${GREEN}No selection made. Defaulting to Polybar.${ENDCOLOR}"
    BAR_CHOICE="polybar"
fi

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
    if fzf_config_confirm "polybar"; then
        backup_and_replace "polybar"
    fi
    git switch main
    git switch polybar
    if fzf_config_confirm "i3 (for polybar)"; then
        backup_and_replace "i3"
    fi
    git switch main

elif [[ "$BAR_CHOICE" == "i3status" ]]; then
    echo -e "${GREEN}Setting up I3status...${ENDCOLOR}"
    cd "$DOTFILES_DIR" && git switch nord
    if fzf_config_confirm "i3status"; then
        backup_and_replace "i3status"
    fi
    git switch i3status
    if fzf_config_confirm "i3 (for i3status)"; then
        backup_and_replace "i3"
    fi
    git switch main
fi

cd "$DOTFILES_DIR" && git switch "$COLOR_SCHEME"

configs_to_apply=("rofi" "starship" "nvim")
for config in "${configs_to_apply[@]}"; do
    if fzf_config_confirm "$config"; then
        backup_and_replace "$config"
    fi
done

echo -e "${GREEN}Dotfiles setup complete.${ENDCOLOR}"

if [[ ! -d "$HOME/Pictures" ]]; then
    echo -e "${GREEN}Creating ~/Pictures directory...${ENDCOLOR}"
    mkdir -p "$HOME/Pictures"
fi

if fzf_confirm "Do you want to download the wallpaper repo? (Large size, but recommended)"; then
    if [[ -d "$WALLPAPER_DIR" ]]; then
        echo -e "${YELLOW}Wallpapers directory already exists.${ENDCOLOR}"
        if fzf_confirm "Do you want to remove and re-clone wallpapers?"; then
            echo -e "${GREEN}Removing existing wallpapers directory...${ENDCOLOR}"
            rm -rf "$WALLPAPER_DIR"
        else
            echo -e "${GREEN}Skipping wallpaper cloning.${ENDCOLOR}"
            WALLPAPER_SKIP=1
        fi
    fi

    if [[ "$WALLPAPER_SKIP" != "1" ]]; then
        echo -e "${GREEN}Cloning wallpaper repository...${ENDCOLOR}"
        git clone "$WALLPAPER_REPO" "$WALLPAPER_DIR" || {
            echo -e "${RED}Failed to clone wallpaper repository.${ENDCOLOR}"
        }
    fi
else
    echo -e "${YELLOW}Skipped wallpaper repository download.${ENDCOLOR}"
fi

install_lxappearance() {
    if [[ "$OS" == "arch" ]]; then
        sudo pacman -S --noconfirm lxappearance
    elif [[ "$OS" == "fedora" ]]; then
        sudo dnf install -y lxappearance
    else
        echo -e "${RED}Unsupported distribution.${ENDCOLOR}"
        exit 1
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
    for dir in "$@"; do
        if [ -d "$dir" ]; then
            echo -e "${YELLOW}$dir already exists.${ENDCOLOR}"
            if fzf_confirm "Do you want to remove $dir?"; then
                rm -rf "$dir"
                echo -e "${GREEN}$dir removed.${ENDCOLOR}"
            else
                echo -e "${RED}$dir not removed.${ENDCOLOR}"
            fi
        fi
    done
}

move_themes_icons() {
    if [ -d ~/.themes ]; then
        echo -e "${CYAN}Existing ~/.themes directory found. Preserving it...${ENDCOLOR}"
    else
        echo -e "${GREEN}Creating ~/.themes directory...${ENDCOLOR}"
        mkdir -p ~/.themes
    fi

    if [ -d ~/.icons ]; then
        echo -e "${CYAN}Existing ~/.icons directory found. Preserving it...${ENDCOLOR}"
    else
        echo -e "${GREEN}Creating ~/.icons directory...${ENDCOLOR}"
        mkdir -p ~/.icons
    fi

    if [ -d ~/themes ]; then
        echo -e "${GREEN}Moving themes to ~/.themes...${ENDCOLOR}"
        for theme in ~/themes/*/; do
            theme_name=$(basename "$theme")
            if [ -d ~/.themes/"$theme_name" ]; then
                echo -e "${YELLOW}Theme $theme_name already exists, skipping...${ENDCOLOR}"
            else
                mv "$theme" ~/.themes/
            fi
        done
        rm -rf ~/themes
    fi

    if [ -d ~/icons ]; then
        echo -e "${GREEN}Moving icons to ~/.icons...${ENDCOLOR}"
        for icon in ~/icons/*/; do
            icon_name=$(basename "$icon")
            if [ -d ~/.icons/"$icon_name" ]; then
                echo -e "${YELLOW}Icon pack $icon_name already exists, skipping...${ENDCOLOR}"
            else
                mv "$icon" ~/.icons/
            fi
        done
        rm -rf ~/icons
    fi
}

install_lxappearance

clone_themes_icons

move_themes_icons

is_sddm_installed() {
    command -v sddm &>/dev/null
}

install_sddm() {
    if [[ "$OS" == "arch" ]]; then
        sudo pacman -S --noconfirm sddm
    elif [[ "$OS" == "fedora" ]]; then
        sudo dnf install -y sddm
    else
        echo -e "${RED}Unsupported distribution.${ENDCOLOR}"
        exit 1
    fi
}

apply_sddm_theme() {
    theme_dir="/usr/share/sddm/themes/catppuccin-mocha"
    temp_dir=$(mktemp -d)

    if [ -d "$theme_dir" ]; then
        echo -e "${YELLOW}Theme already exists.${ENDCOLOR}"
        if fzf_confirm "Remove existing SDDM theme?"; then
            sudo rm -rf "$theme_dir"
            echo -e "${GREEN}Old theme removed.${ENDCOLOR}"
        else
            echo -e "${RED}Theme not replaced. Exiting.${ENDCOLOR}"
            exit 1
        fi
    fi

    echo -e "${GREEN}Downloading Catppuccin Mocha theme...${ENDCOLOR}"
    wget -q --show-progress https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip -O "$temp_dir/theme.zip"

    if [ ! -f "$temp_dir/theme.zip" ]; then
        echo -e "${RED}Failed to download theme. Exiting.${ENDCOLOR}"
        exit 1
    fi

    unzip -q "$temp_dir/theme.zip" -d "$temp_dir"
    sudo mv "$temp_dir/catppuccin-mocha" "$theme_dir"

    rm -rf "$temp_dir"
    echo -e "${GREEN}Theme applied successfully.${ENDCOLOR}"
}

configure_sddm_theme() {
    echo -e "${GREEN}Configuring SDDM theme...${ENDCOLOR}"

    sudo mkdir -p /etc
    if [ ! -f /etc/sddm.conf ]; then
        echo "[Theme]" | sudo tee /etc/sddm.conf > /dev/null
    fi

    sudo sed -i '/\[Theme\]/!b;n;cCurrent=catppuccin-mocha' /etc/sddm.conf
    echo -e "${GREEN}SDDM theme configured.${ENDCOLOR}"
}

enable_start_sddm() {
    echo -e "${GREEN}Checking for existing display managers...${ENDCOLOR}"

    for dm in gdm lightdm greetd; do
        if command -v $dm &>/dev/null; then
            echo -e "${TEAL}Removing $dm...${ENDCOLOR}"
            sudo systemctl stop $dm
            sudo systemctl disable $dm --now
            [[ "$OS" == "arch" ]] && sudo pacman -Rns --noconfirm $dm
            [[ "$OS" == "fedora" ]] && sudo dnf remove -y $dm
        fi
    done

    echo -e "${GREEN}Enabling and starting SDDM...${ENDCOLOR}"
    sudo systemctl enable sddm --now
}

setup_numlock() {
    echo -e "${GREEN}Setting up NumLock on login...${ENDCOLOR}"

    sudo tee "/usr/local/bin/numlock" > /dev/null <<'EOF'
#!/bin/bash
for tty in /dev/tty{1..6}; do
    /usr/bin/setleds -D +num < "$tty"
done
EOF
    sudo chmod +x /usr/local/bin/numlock

    sudo tee "/etc/systemd/system/numlock.service" > /dev/null <<'EOF'
[Unit]
Description=Enable NumLock on startup
[Service]
ExecStart=/usr/local/bin/numlock
StandardInput=tty
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
EOF

    if fzf_confirm "Enable NumLock on boot?"; then
        sudo systemctl enable numlock.service
        echo -e "${GREEN}NumLock will be enabled on boot.${ENDCOLOR}"
    else
        echo -e "${GREEN}NumLock setup skipped.${ENDCOLOR}"
    fi
}

display_message() {
    echo -e "${TEAL}╔════════════════════════════════════════════╗${ENDCOLOR}"
    echo -e "${TEAL}║              i3wm setup completed          ║${ENDCOLOR}"
    echo -e "${TEAL}╚════════════════════════════════════════════╝${ENDCOLOR}"
}

prompt_reboot() {
    if fzf_confirm "Reboot now?"; then
        echo -e "${GREEN}Rebooting...${ENDCOLOR}"
        sleep 3
        sudo reboot
    else
        echo -e "${RED}Skipping reboot. You can reboot later.${ENDCOLOR}"
    fi
}

if fzf_confirm "Do you want to install and configure SDDM (Simple Desktop Display Manager)?"; then
    if ! is_sddm_installed; then
        echo -e "${GREEN}Installing SDDM...${ENDCOLOR}"
        install_sddm
    else
        echo -e "${GREEN}SDDM is already installed.${ENDCOLOR}"
    fi

    apply_sddm_theme
    configure_sddm_theme
    enable_start_sddm
else
    echo -e "${YELLOW}Skipping SDDM installation and configuration.${ENDCOLOR}"
fi

setup_numlock
display_message
prompt_reboot
