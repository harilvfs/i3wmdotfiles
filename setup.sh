#!/usr/bin/env bash

# =============================================================================
#  i3wm Dotfiles Setup Script
#  Author : Hari Chalise
#  GitHub : https://github.com/harilvfs/i3wmdotfiles
#  Supports: Arch Linux, Fedora
# =============================================================================

clear

RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
TEAL="\e[38;2;129;200;190m"
NC="\e[0m"

BACKUP_DIR="$HOME/.i3wmdotfiles/backup"
DOTFILES_REPO="https://github.com/harilvfs/i3wmdotfiles"
DOTFILES_DIR="$HOME/i3wmdotfiles"
WALLPAPER_REPO="https://github.com/harilvfs/wallpapers"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
APPLY_ALL_CONFIGS=false
COLOR_SCHEME=""
BAR_CHOICE=""
OS=""
AUR_HELPER=""

FZF_COMMON="--layout=reverse \
            --border=rounded \
            --margin=5% \
            --color=dark \
            --info=inline \
            --header-first \
            --bind change:top"

msg()    { echo -e "${GREEN}${*}${NC}"; }
warn()   { echo -e "${YELLOW}${*}${NC}"; }
err()    { echo -e "${RED}${*}${NC}"; }
info()   { echo -e "${CYAN}${*}${NC}"; }
teal()   { echo -e "${TEAL}${*}${NC}"; }

fzf_confirm() {
    local prompt="$1"
    local selected
    selected=$(printf "Yes\nNo" | fzf ${FZF_COMMON} \
        --height=40% \
        --prompt="$prompt " \
        --header="Confirm" \
        --pointer="➤" \
        --color='fg:white,fg+:green,bg+:black,pointer:green')
    [[ "$selected" == "Yes" ]]
}

fzf_select() {
    local prompt="$1"
    local header="$2"
    shift 2
    printf "%s\n" "$@" | fzf ${FZF_COMMON} \
        --height=50% \
        --prompt="$prompt " \
        --header="$header" \
        --pointer="➤" \
        --color='fg:white,fg+:cyan,bg+:black,pointer:cyan'
}

fzf_config_confirm() {
    local config_name="$1"

    [[ "$APPLY_ALL_CONFIGS" == "true" ]] && return 0

    local selected
    selected=$(printf "Yes, for this one\nYes, don't ask again\nNo" | fzf ${FZF_COMMON} \
        --height=50% \
        --prompt="Apply $config_name config? " \
        --header="Config Installation" \
        --pointer="➤" \
        --color='fg:white,fg+:yellow,bg+:black,pointer:yellow')

    case "$selected" in
        "Yes, for this one")   return 0 ;;
        "Yes, don't ask again") APPLY_ALL_CONFIGS=true; return 0 ;;
        *)                      return 1 ;;
    esac
}

backup_and_replace() {
    local config_name="$1"
    local src="${2:-$DOTFILES_DIR/$config_name}"
    local dst="$HOME/.config/$config_name"

    fzf_config_confirm "$config_name" || { warn "Skipping $config_name..."; return; }

    mkdir -p "$BACKUP_DIR"
    [[ -d "$dst" ]] && { msg "Backing up $config_name..."; mv "$dst" "$BACKUP_DIR/"; }
    msg "Applying $config_name config..."
    cp -r "$src" "$HOME/.config/"
}

check_fzf() {
    if ! command -v fzf &>/dev/null; then
        err "Error: fzf is not installed."
        warn "Install it first:"
        info "  Arch:   sudo pacman -S fzf"
        info "  Fedora: sudo dnf install fzf"
        exit 1
    fi
}

detect_os() {
    if command -v pacman &>/dev/null; then
        OS="arch"
    elif command -v dnf &>/dev/null; then
        OS="fedora"
    else
        err "Unsupported OS. This script supports Arch Linux and Fedora only."
        exit 1
    fi
    msg "Detected OS: $OS"
}

update_system() {
    if fzf_confirm "Update your system now? (Recommended)"; then
        msg "Updating system..."
        if [[ "$OS" == "arch" ]]; then
            sudo pacman -Syuu --noconfirm
        elif [[ "$OS" == "fedora" ]]; then
            sudo dnf update -y
        fi
        msg "System updated."
    else
        warn "Skipping system update."
    fi
}

# =============================================================================
#  AUR HELPER 
# =============================================================================

setup_aur_helper() {
    [[ "$OS" != "arch" ]] && return

    for helper in paru yay; do
        if command -v "$helper" &>/dev/null; then
            AUR_HELPER="$helper"
            msg "Found AUR helper: $AUR_HELPER"
            return
        fi
    done

    warn "No AUR helper found. Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    local tmp
    tmp=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmp/yay"
    (cd "$tmp/yay" && makepkg -si --noconfirm)
    rm -rf "$tmp"
    AUR_HELPER="yay"
    msg "yay installed successfully."
}

# =============================================================================
# DEPENDENCIES 
# =============================================================================

install_dependencies() {
    msg "Installing core dependencies..."

    if [[ "$OS" == "arch" ]]; then
        sudo pacman -S --noconfirm --needed \
            polybar i3-wm rofi maim git imwheel  polkit-gnome xclip flameshot thunar \
            xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xorg-xset gtk3 gtk4 \
            gnome-settings-daemon gnome-keyring neovim \
            ttf-meslo-nerd noto-fonts-emoji ttf-jetbrains-mono \
            network-manager-applet blueman pasystray wget unzip \
            curl zoxide polybar nwg-look qt5ct qt6ct \
            kvantum alacritty dunst fastfetch picom fish starship zsh

    elif [[ "$OS" == "fedora" ]]; then
        sudo dnf copr enable -y solopasha/hyprland 2>/dev/null || warn "Failed to enable Hyprland COPR (non-fatal)"

        sudo dnf install -y \
            polybar i3 rofi maim imwheel xclip flameshot lxappearance thunar \
            xorg-x11-server-Xorg xorg-x11-xinit xrandr gtk3 gtk4 \
            gnome-settings-daemon gnome-keyring neovim \
            network-manager-applet blueman pasystray git \
            jetbrains-mono-fonts-all google-noto-color-emoji-fonts \
            google-noto-emoji-fonts wget unzip curl zoxide \
            nwg-look qt5ct qt6ct kvantum alacritty dunst fastfetch picom fish zsh

        _install_starship_fedora
    fi

    msg "Core dependencies installed."
}

_install_starship_fedora() {
    if ! command -v starship &>/dev/null; then
        msg "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh
    fi
}

verify_dependencies() {
    msg "Verifying dependencies..."

    local deps=(
        i3
        polybar
        rofi
        alacritty
        picom
        dunst
        feh
        flameshot
        thunar
        fish
        gnome-keyring
        starship
        fastfetch
        git
        curl
        wget
        unzip
        nm-applet
        pactl
        xrandr
        zoxide
        maim
        xclip
        imwheel
        bash
        pasystray
        nvim 
        lxappearance
        zsh
    )

    local missing=()

    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            missing+=("$dep")
        fi
    done

    if [[ ${#missing[@]} -eq 0 ]]; then
        msg "All dependencies are present."
    else
        warn "The following dependencies are missing and need to be installed manually:"
        echo
        for pkg in "${missing[@]}"; do
            err "  ✗ $pkg"
        done
        echo
        if [[ "$OS" == "arch" ]]; then
            info "  Install missing packages with: sudo pacman -S <package>"
            info "  Or with your AUR helper: $AUR_HELPER -S <package>"
        elif [[ "$OS" == "fedora" ]]; then
            info "  Install missing packages with: sudo dnf install <package>"
        fi
        echo
        warn "You can continue, but some things may not work correctly without the missing packages."
        fzf_confirm "Continue anyway?" || { err "Exiting. Please install the missing dependencies and re-run the script."; exit 1; }
    fi
}

# =============================================================================
#  POKEMON COLORSCRIPTS (You will see at terminal startup) 
# =============================================================================

install_pokemon_colorscripts() {
    info "Installing Pokémon Color Scripts..."

    if [[ "$OS" == "arch" ]]; then
        $AUR_HELPER -S --noconfirm pokemon-colorscripts-git \
            || err "Failed to install pokemon-colorscripts-git"

    elif [[ "$OS" == "fedora" ]]; then
        local dir="$HOME/pokemon-colorscripts"
        [[ -d "$dir" ]] && rm -rf "$dir"
        git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git "$dir"
        (cd "$dir" && sudo ./install.sh)
        rm -rf "$dir"
    fi

    msg "Pokémon Color Scripts installed."
}

# =============================================================================
#  BROWSER (Optional, in case you want one)
# =============================================================================

install_brave() {
    fzf_confirm "Install Brave browser?" || { warn "Skipping Brave browser."; return; }

    if command -v brave &>/dev/null || command -v brave-browser &>/dev/null; then
        msg "Brave is already installed."; return
    fi

    msg "Installing Brave browser..."
    if [[ "$OS" == "arch" ]]; then
        "$AUR_HELPER" -S --noconfirm brave-bin
    elif [[ "$OS" == "fedora" ]]; then
        curl -fsS https://dl.brave.com/install.sh | sh
    fi
    msg "Brave browser installed."
}

# =============================================================================
# DOTFILES
# =============================================================================

clone_dotfiles() {
    if [[ -d "$DOTFILES_DIR" ]]; then
        warn "Dotfiles directory already exists at $DOTFILES_DIR."
        if fzf_confirm "Remove and re-clone?"; then
            rm -rf "$DOTFILES_DIR"
        else
            err "Cannot continue with existing dotfiles directory. Exiting."
            exit 1
        fi
    fi
    msg "Cloning dotfiles..."
    warn "Note: The dotfiles repo is around 300MB, this may take a moment depending on your connection."
    git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR" || { err "Failed to clone dotfiles."; exit 1; }
}

# =============================================================================
# COLOR SCHEME
# =============================================================================

select_color_scheme() {
    warn "Choose your color scheme:"
    COLOR_SCHEME=$(fzf_select "Color scheme:" "Available themes" "catppuccin" "nord")
    COLOR_SCHEME="${COLOR_SCHEME:-catppuccin}"
    COLOR_SCHEME="${COLOR_SCHEME,,}"
    msg "Selected color scheme: $COLOR_SCHEME"
}

apply_configs() {
    mkdir -p "$BACKUP_DIR"

    cd "$DOTFILES_DIR" || exit 1

    git switch "$COLOR_SCHEME"
    for cfg in Kvantum alacritty polybar rofi starship nvim; do
        backup_and_replace "$cfg"
    done

    git switch polybar
    backup_and_replace "i3"

    git switch main
    for cfg in dunst fastfetch; do
        backup_and_replace "$cfg"
    done

    # Run alacritty migration to get rid of the warning
    if [[ -d "$HOME/.config/alacritty" ]]; then
        msg "Running 'alacritty migrate'..."
        (cd "$HOME/.config/alacritty" && alacritty migrate) 2>/dev/null || true
    fi

    # picom (for cool-looking transparency)
    if fzf_config_confirm "picom"; then
        local picom_dst="$HOME/.config/picom.conf"
        [[ -f "$picom_dst" ]] && mv "$picom_dst" "$BACKUP_DIR/"
        cp "$DOTFILES_DIR/picom/picom-transparency/picom.conf" "$HOME/.config/"
        msg "picom config applied."
    else
        warn "Skipping picom config."
    fi

    # Shell configs
    for shell_cfg in .bashrc .zshrc; do
        if [[ -f "$HOME/$shell_cfg" ]]; then
            warn "Found $shell_cfg."
            local name="${shell_cfg#.}"
            if fzf_config_confirm "$name"; then
                mv "$HOME/$shell_cfg" "$BACKUP_DIR/"
                [[ -f "$DOTFILES_DIR/$shell_cfg" ]] && cp "$DOTFILES_DIR/$shell_cfg" "$HOME/"
                msg "$shell_cfg applied."
            else
                warn "Skipping $shell_cfg."
            fi
        fi
    done

    # Fish (this has some issues, will check later)
    if [[ -d "$HOME/.config/fish" ]]; then
        warn "Existing Fish config found."
        if fzf_config_confirm "fish"; then
            mv "$HOME/.config/fish" "$BACKUP_DIR/"
            cp -r "$DOTFILES_DIR/fish" "$HOME/.config/"
            msg "Fish config applied."
        else
            warn "Skipping fish config."
        fi
    fi
}



# =============================================================================
#  Wallpapers
# =============================================================================

setup_wallpapers() {
    mkdir -p "$HOME/Pictures"

    fzf_confirm "Download wallpapers repo? (Large download, recommended)" || {
        warn "Skipping wallpapers."; return
    }

    if [[ -d "$WALLPAPER_DIR" ]]; then
        warn "Wallpapers directory already exists."
        if fzf_confirm "Remove and re-clone wallpapers?"; then
            rm -rf "$WALLPAPER_DIR"
        else
            warn "Skipping wallpaper clone."; return
        fi
    fi

    msg "Cloning wallpapers..."
    git clone "$WALLPAPER_REPO" "$WALLPAPER_DIR" || err "Failed to clone wallpapers (non-fatal)."
}

# =============================================================================
#  Themes & Icons
# =============================================================================

setup_themes_icons() {
    _check_remove_dir "$HOME/themes" "$HOME/icons"

    msg "Cloning themes..."
    git clone https://github.com/harilvfs/themes.git "$HOME/themes"
    msg "Cloning icons..."
    git clone https://github.com/harilvfs/icons.git "$HOME/icons"

    _move_to_dotdir "$HOME/themes" "$HOME/.themes"
    _move_to_dotdir "$HOME/icons"  "$HOME/.icons"

    # use lxappearance for GTK theming
    if [[ "$OS" == "arch" ]]; then
        sudo pacman -S --noconfirm --needed lxappearance
    elif [[ "$OS" == "fedora" ]]; then
        sudo dnf install -y lxappearance
    fi
}

_check_remove_dir() {
    for dir in "$@"; do
        if [[ -d "$dir" ]]; then
            warn "$dir already exists."
            fzf_confirm "Remove $dir?" && rm -rf "$dir" && msg "$dir removed."
        fi
    done
}

_move_to_dotdir() {
    local src="$1" dst="$2"
    mkdir -p "$dst"
    [[ -d "$src" ]] || return
    for item in "$src"/*/; do
        local name
        name=$(basename "$item")
        if [[ -d "$dst/$name" ]]; then
            warn "$name already exists in $dst, skipping."
        else
            mv "$item" "$dst/"
        fi
    done
    rm -rf "$src"
}

# =============================================================================
# SDDM
# Many users who tried my setup script mostly had issues with the SDDM part.
# I've mostly fixed it and got it working on my Arch, should work fine now.
# =============================================================================

setup_sddm() {
    fzf_confirm "Install and configure SDDM (Display Manager)?" || {
        warn "Skipping SDDM setup."; return
    }

    if ! command -v sddm &>/dev/null; then
        msg "Installing SDDM..."
        [[ "$OS" == "arch" ]]   && sudo pacman -S --noconfirm sddm
        [[ "$OS" == "fedora" ]] && sudo dnf install -y sddm
    else
        msg "SDDM already installed."
    fi

    if [[ "$COLOR_SCHEME" == "nord" ]]; then
        _apply_sddm_astronaut_theme
    else
        _apply_sddm_catppuccin_theme
    fi

    _configure_sddm
    _enable_sddm
}

_apply_sddm_catppuccin_theme() {
    local theme_dir="/usr/share/sddm/themes/catppuccin-mocha"
    local tmp
    tmp=$(mktemp -d)

    if [[ -d "$theme_dir" ]]; then
        warn "Catppuccin Mocha SDDM theme already exists."
        fzf_confirm "Replace existing theme?" || { err "Keeping existing theme."; rm -rf "$tmp"; return; }
        sudo rm -rf "$theme_dir"
    fi

    msg "Downloading Catppuccin Mocha SDDM theme..."
    wget -q --show-progress \
        https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip \
        -O "$tmp/theme.zip" || { err "Download failed."; rm -rf "$tmp"; return; }

    unzip -q "$tmp/theme.zip" -d "$tmp"
    sudo mv "$tmp/catppuccin-mocha" "$theme_dir"
    rm -rf "$tmp"

    SDDM_THEME_NAME="catppuccin-mocha"
    msg "Catppuccin Mocha theme applied."
}

_apply_sddm_astronaut_theme() {
    local theme_name="sddm-astronaut-theme"
    local theme_dir="/usr/share/sddm/themes/$theme_name"
    local tmp
    tmp=$(mktemp -d)

    if [[ -d "$theme_dir" ]]; then
        warn "Astronaut SDDM theme already exists."
        fzf_confirm "Replace existing theme?" || { err "Keeping existing theme."; rm -rf "$tmp"; return; }
        sudo rm -rf "$theme_dir"
    fi

    msg "Fetching sddm-astronaut-theme from dotfiles (nord branch)..."

    git clone --depth=1 --filter=blob:none --sparse \
        --branch nord "$DOTFILES_REPO" "$tmp/dotfiles"
    (cd "$tmp/dotfiles" && git sparse-checkout set "sddm/themes/$theme_name")

    local src="$tmp/dotfiles/sddm/themes/$theme_name"
    if [[ -d "$src" ]]; then
        sudo mkdir -p /usr/share/sddm/themes
        sudo cp -r "$src" "$theme_dir"
        msg "Astronaut theme applied."
    else
        err "Could not find astronaut theme in the repository."
    fi

    rm -rf "$tmp"
    SDDM_THEME_NAME="$theme_name"
}

_configure_sddm() {
    msg "Configuring SDDM theme: $SDDM_THEME_NAME"
    sudo mkdir -p /etc
    if [[ ! -f /etc/sddm.conf ]]; then
        printf "[Theme]\nCurrent=%s\n" "$SDDM_THEME_NAME" | sudo tee /etc/sddm.conf > /dev/null
    else
        if grep -q "^\[Theme\]" /etc/sddm.conf; then
            sudo sed -i '/^\[Theme\]/,/^\[/{s/^Current=.*/Current='"$SDDM_THEME_NAME"'/}' /etc/sddm.conf
            grep -q "^Current=" /etc/sddm.conf || sudo sed -i '/^\[Theme\]/a Current='"$SDDM_THEME_NAME" /etc/sddm.conf
        else
            printf "\n[Theme]\nCurrent=%s\n" "$SDDM_THEME_NAME" | sudo tee -a /etc/sddm.conf > /dev/null
        fi
    fi
    msg "SDDM theme configured."
}

_enable_sddm() {
    msg "Checking for conflicting display managers..."
    for dm in gdm lightdm greetd; do
        if command -v "$dm" &>/dev/null; then
            warn "Disabling $dm..."
            sudo systemctl disable --now "$dm" 2>/dev/null || true
            [[ "$OS" == "arch" ]]   && sudo pacman -Rns --noconfirm "$dm" 2>/dev/null || true
            [[ "$OS" == "fedora" ]] && sudo dnf remove -y "$dm" 2>/dev/null || true
        fi
    done
    msg "Enabling SDDM..."
    sudo systemctl enable --now sddm
}

# =============================================================================
# NumLock (I like having NumLock enabled)
# =============================================================================

setup_numlock() {
    fzf_confirm "Enable NumLock on boot?" || { warn "Skipping NumLock setup."; return; }

    msg "Setting up NumLock service..."
    sudo tee /usr/local/bin/numlock > /dev/null <<'EOF'
#!/bin/bash
for tty in /dev/tty{1..6}; do
    /usr/bin/setleds -D +num < "$tty"
done
EOF
    sudo chmod +x /usr/local/bin/numlock

    sudo tee /etc/systemd/system/numlock.service > /dev/null <<'EOF'
[Unit]
Description=Enable NumLock on startup

[Service]
ExecStart=/usr/local/bin/numlock
StandardInput=tty
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl enable numlock.service
    msg "NumLock will be enabled on boot."
}

print_complete() {
    echo
    teal "  i3wm Setup Complete! "
    teal "  Color scheme : $COLOR_SCHEME"
    echo
    warn "  Tip: If you re-run this script, delete ~/.i3wmdotfiles first to avoid conflicts."
    echo
}

prompt_reboot() {
    if fzf_confirm "Reboot now to apply all changes?"; then
        msg "Rebooting in 3 seconds..."
        sleep 3
        sudo reboot
    else
        warn "Reboot skipped. Please reboot manually when ready."
    fi
}

main() {
    check_fzf
    detect_os
    update_system
    setup_aur_helper
    install_dependencies
    verify_dependencies
    install_pokemon_colorscripts
    install_brave
    clone_dotfiles
    select_color_scheme
    apply_configs
    setup_wallpapers
    setup_themes_icons
    setup_sddm
    setup_numlock
    print_complete   
    prompt_reboot
}

main
