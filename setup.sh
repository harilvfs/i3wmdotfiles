#!/usr/bin/env bash

# =============================================================================
#  i3wm Dotfiles Setup Script
#  Author : Hari Chalise
#  GitHub : https://github.com/harilvfs/i3wmdotfiles
#  Supports: Arch Linux, Fedora
# =============================================================================

RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
BOLD='\e[1m'
TEAL="\e[38;2;129;200;190m"
NC="\e[0m"

BACKUP_DIR="$HOME/.i3wmdotfiles/backup"
DOTFILES_REPO="https://github.com/harilvfs/i3wmdotfiles"
DOTFILES_DIR="$HOME/i3wmdotfiles"
WALLPAPER_REPO="https://github.com/harilvfs/wallpapers"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
DISTRO=""
AUR_HELPER=""
APPLY_ALL_CONFIGS=false

msg()    { echo -e "${GREEN}  ${*}${NC}"; }
warn()   { echo -e "${YELLOW}  ${*}${NC}"; }
err()    { echo -e "${RED}  ${*}${NC}"; }
info()   { echo -e "${CYAN}  ${*}${NC}"; }
teal()   { echo -e "${TEAL}  ${*}${NC}"; }
header() { echo -e "\n${BOLD}${TEAL}══ ${*} ══${NC}\n"; }
die()    { err "$*"; exit 1; }

ask() {
    local prompt="$1"
    local reply
    echo -en "${CYAN}  ${prompt} ${YELLOW}[Y/n]${NC} "
    read -r reply
    reply="${reply:-Y}"
    [[ "${reply,,}" == "y" || "${reply,,}" == "yes" ]]
}

ask_config() {
    local name="$1"
    [[ "$APPLY_ALL_CONFIGS" == "true" ]] && return 0

    local reply
    echo -en "${CYAN}  Apply ${BOLD}${name}${NC}${CYAN} config? ${YELLOW}[Y/n/a(ll)]${NC} "
    read -r reply
    reply="${reply:-Y}"
    case "${reply,,}" in
        a|all) APPLY_ALL_CONFIGS=true; return 0 ;;
        y|yes) return 0 ;;
        *)     return 1 ;;
    esac
}

pause() {
    echo -en "${CYAN}  Press Enter to continue...${NC}"
    read -r
}

# =============================================================================
#  DISTRO
# =============================================================================

detect_distro() {
    header "Detecting Distribution"
    if command -v pacman &>/dev/null; then
        DISTRO="Arch"
    elif command -v dnf &>/dev/null; then
        DISTRO="Fedora"
    else
        die "Unsupported distro. This script supports Arch Linux and Fedora only."
    fi
    msg "Detected: $DISTRO"
}

update_system() {
    header "System Update"
    if ask "Update your system now? (Recommended)"; then
        msg "Updating system..."
        case "$DISTRO" in
            Arch)   sudo pacman -Syuu --noconfirm ;;
            Fedora) sudo dnf update -y ;;
        esac
        msg "System updated."
    else
        warn "Skipping system update."
    fi
}

# =============================================================================
#  AUR HELPER (Arch only)
# =============================================================================

setup_aur_helper() {
    [[ "$DISTRO" != "Arch" ]] && return

    header "AUR Helper"
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
    msg "yay installed."
}

# =============================================================================
#  DEPENDENCIES
# =============================================================================

install_dependencies() {
    header "Installing Dependencies"

    case "$DISTRO" in
        Arch)
            sudo pacman -S --noconfirm --needed \
                polybar i3-wm rofi maim git imwheel polkit-gnome xclip flameshot thunar \
                xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xorg-xset gtk3 gtk4 \
                gnome-settings-daemon gnome-keyring neovim \
                ttf-meslo-nerd noto-fonts-emoji ttf-jetbrains-mono \
                network-manager-applet blueman pasystray wget unzip \
                curl zoxide nwg-look qt5ct qt6ct yad tmux \
                kvantum alacritty dunst fastfetch picom starship slock brightnessctl
            "$AUR_HELPER" -S --noconfirm --needed xautolock
            ;;
        Fedora)
            sudo dnf copr enable -y solopasha/hyprland 2>/dev/null \
                || warn "Failed to enable Hyprland COPR (non-fatal)"

            sudo dnf install -y \
                polybar i3 rofi maim imwheel xclip flameshot lxappearance thunar \
                xorg-x11-server-Xorg xorg-x11-xinit xrandr gtk3 gtk4 \
                gnome-settings-daemon gnome-keyring neovim \
                network-manager-applet blueman pasystray git \
                jetbrains-mono-fonts-all google-noto-color-emoji-fonts \
                google-noto-emoji-fonts wget unzip curl zoxide yad tmux \
                nwg-look qt5ct qt6ct kvantum alacritty dunst fastfetch picom slock xautolock brightnessctl

            command -v starship &>/dev/null || {
                msg "Installing Starship..."
                curl -sS https://starship.rs/install.sh | sh
            }
            ;;
    esac

    msg "Dependencies installed."
}

verify_dependencies() {
    header "Verifying Dependencies"

    local deps=(
        i3 polybar rofi alacritty picom dunst flameshot thunar
        gnome-keyring starship fastfetch git curl wget unzip
        nm-applet xrandr zoxide maim xclip imwheel
        pasystray nvim slock xautolock brightnessctl yad tmux
    )

    local missing=()
    for dep in "${deps[@]}"; do
        command -v "$dep" &>/dev/null || missing+=("$dep")
    done

    if [[ ${#missing[@]} -eq 0 ]]; then
        msg "All dependencies present."
        return
    fi

    warn "Missing dependencies:"
    for pkg in "${missing[@]}"; do
        err "    ✗ $pkg"
    done
    echo
    case "$DISTRO" in
        Arch)   info "  Install with: sudo pacman -S <pkg>  or  $AUR_HELPER -S <pkg>" ;;
        Fedora) info "  Install with: sudo dnf install <pkg>" ;;
    esac
    echo
    ask "Continue anyway?" || die "Exiting. Please install missing packages and re-run."
}

# =============================================================================
#  POKEMON COLORSCRIPTS
# =============================================================================

install_pokemon_colorscripts() {
    header "Pokémon Color Scripts"
    info "Installing Pokémon Color Scripts..."

    case "$DISTRO" in
        Arch)
            "$AUR_HELPER" -S --noconfirm pokemon-colorscripts-git \
                || err "Failed to install pokemon-colorscripts-git"
            ;;
        Fedora)
            local dir="$HOME/pokemon-colorscripts"
            [[ -d "$dir" ]] && rm -rf "$dir"
            git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git "$dir"
            (cd "$dir" && sudo ./install.sh)
            rm -rf "$dir"
            ;;
    esac

    msg "Pokémon Color Scripts installed."
}

# =============================================================================
# BROWSER
# =============================================================================

install_brave() {
    header "Brave Browser"
    ask "Install Brave browser?" || { warn "Skipping Brave."; return; }

    if command -v brave &>/dev/null || command -v brave-browser &>/dev/null; then
        msg "Brave is already installed."
        return
    fi

    msg "Installing Brave..."
    case "$DISTRO" in
        Arch)   "$AUR_HELPER" -S --noconfirm brave-bin ;;
        Fedora) curl -fsS https://dl.brave.com/install.sh | sh ;;
    esac
    msg "Brave installed."
}

# =============================================================================
# DOTFILES
# =============================================================================

clone_dotfiles() {
    header "Cloning Dotfiles"

    if [[ -d "$DOTFILES_DIR" ]]; then
        warn "Dotfiles directory already exists at $DOTFILES_DIR."
        if ask "Remove and re-clone?"; then
            rm -rf "$DOTFILES_DIR"
        else
            die "Cannot continue with existing dotfiles directory."
        fi
    fi

    warn "Note: The dotfiles repo may be large this can take a moment."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR" \
        || die "Failed to clone dotfiles."
    msg "Dotfiles cloned."
}

# =============================================================================
# CONFIGS
# =============================================================================

backup_and_replace() {
    local config_name="$1"
    local src="${2:-$DOTFILES_DIR/$config_name}"
    local dst="$HOME/.config/$config_name"

    ask_config "$config_name" || { warn "Skipping $config_name."; return; }

    mkdir -p "$BACKUP_DIR"

    # fix ownership if needed
    if [[ -d "$dst" ]] && [[ "$(stat -c '%U' "$dst")" != "$USER" ]]; then
        warn "Fixing ownership of $dst..."
        sudo chown -R "$USER:$USER" "$dst"
    fi

    [[ -e "$dst" ]] && { msg "Backing up existing $config_name..."; mv "$dst" "$BACKUP_DIR/"; }

    msg "Applying $config_name config..."
    cp -r "$src" "$HOME/.config/"
}

apply_configs() {
    header "Applying Configs"
    mkdir -p "$BACKUP_DIR"

    for cfg in alacritty dunst fastfetch gtk-3.0 i3 Kvantum nvim picom polybar rofi tmux xsettingsd; do
        backup_and_replace "$cfg"
    done

    if ask_config "starship"; then
        local starship_src="$DOTFILES_DIR/starship/starship.toml"
        local starship_dst="$HOME/.config/starship.toml"
        if [[ -f "$starship_src" ]]; then
            [[ -f "$starship_dst" ]] && mv "$starship_dst" "$BACKUP_DIR/starship.toml.bak"
            cp "$starship_src" "$starship_dst"
            msg "starship.toml applied."
        else
            err "starship/starship.toml not found in dotfiles."
        fi
    else
        warn "Skipping starship."
    fi

    if ask_config "bashrc"; then
        [[ -f "$HOME/.bashrc" ]] && mv "$HOME/.bashrc" "$BACKUP_DIR/.bashrc.bak"
        [[ -f "$DOTFILES_DIR/.bashrc" ]] && cp "$DOTFILES_DIR/.bashrc" "$HOME/"
        msg ".bashrc applied."
    else
        warn "Skipping .bashrc."
    fi

    # Alacritty migration (remove deprecation warnings)
    if [[ -d "$HOME/.config/alacritty" ]]; then
        msg "Running 'alacritty migrate'..."
        (cd "$HOME/.config/alacritty" && alacritty migrate) 2>/dev/null || true
    fi
}

# =============================================================================
#  TMUX PLUGINS
# =============================================================================

setup_tmux_plugins() {
    header "Tmux Plugin Manager (TPM)"

    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [[ -d "$tpm_dir" ]]; then
        msg "TPM already installed at $tpm_dir."
    else
        msg "Cloning TPM..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir" \
            || die "Failed to clone TPM."
        msg "TPM cloned."
    fi

    msg "Installing tmux plugins..."
    local install_script="$tpm_dir/scripts/install_plugins.sh"
    if [[ -f "$install_script" ]]; then
        chmod +x "$install_script"
        bash "$install_script"
        msg "Tmux plugins installed."
    else
        err "TPM install script not found at $install_script"
    fi
}

# =============================================================================
#  WALLPAPERS
# =============================================================================

setup_wallpapers() {
    header "Wallpapers"
    ask "Download wallpapers repo? (Large download, recommended)" || {
        warn "Skipping wallpapers."; return
    }

    if [[ -d "$WALLPAPER_DIR" ]]; then
        warn "Wallpapers directory already exists."
        if ask "Remove and re-clone wallpapers?"; then
            rm -rf "$WALLPAPER_DIR"
        else
            warn "Skipping wallpaper clone."; return
        fi
    fi

    mkdir -p "$HOME/Pictures"
    msg "Cloning wallpapers..."
    git clone "$WALLPAPER_REPO" "$WALLPAPER_DIR" \
        || warn "Failed to clone wallpapers (non-fatal)."
    msg "Wallpapers downloaded to $WALLPAPER_DIR"
}

# =============================================================================
#  THEMES & ICONS
# =============================================================================

setup_themes_icons() {
    header "Themes & Icons"

    for dir in "$HOME/themes" "$HOME/icons"; do
        if [[ -d "$dir" ]]; then
            warn "$dir already exists."
            ask "Remove $dir?" && rm -rf "$dir" && msg "$dir removed."
        fi
    done

    msg "Cloning themes..."
    git clone https://github.com/harilvfs/themes.git "$HOME/themes"
    msg "Cloning icons..."
    git clone https://github.com/harilvfs/icons.git "$HOME/icons"

    _move_to_dotdir "$HOME/themes" "$HOME/.themes"
    _move_to_dotdir "$HOME/icons"  "$HOME/.icons"

    msg "Themes and icons installed."
}

_move_to_dotdir() {
    local src="$1" dst="$2"
    mkdir -p "$dst"
    [[ -d "$src" ]] || return
    for item in "$src"/*/; do
        local name
        name=$(basename "$item")
        if [[ -d "$dst/$name" ]]; then
            warn "  $name already in $dst, skipping."
        else
            mv "$item" "$dst/"
        fi
    done
    rm -rf "$src"
}

# =============================================================================
#  SDDM
# =============================================================================

setup_sddm() {
    header "SDDM Display Manager"
    ask "Install and configure SDDM?" || { warn "Skipping SDDM."; return; }

    if ! command -v sddm &>/dev/null; then
        msg "Installing SDDM..."
        case "$DISTRO" in
            Arch)   sudo pacman -S --noconfirm sddm ;;
            Fedora) sudo dnf install -y sddm ;;
        esac
    else
        msg "SDDM already installed."
    fi

    _apply_sddm_astronaut_theme
    _configure_sddm
    _enable_sddm
}

_apply_sddm_astronaut_theme() {
    local theme_name="sddm-astronaut-theme"
    local theme_dir="/usr/share/sddm/themes/$theme_name"

    if [[ -d "$theme_dir" ]]; then
        warn "Astronaut SDDM theme already exists."
        ask "Replace existing theme?" || { warn "Keeping existing theme."; return; }
        sudo rm -rf "$theme_dir"
    fi

    local src="$DOTFILES_DIR/sddm/themes/$theme_name"
    if [[ -d "$src" ]]; then
        msg "Installing astronaut SDDM theme from dotfiles..."
        sudo mkdir -p /usr/share/sddm/themes
        sudo cp -r "$src" "$theme_dir"
        msg "Astronaut theme installed."
    else
        err "sddm/themes/$theme_name not found in dotfiles repo."
        warn "Skipping SDDM theme."
        return
    fi

    SDDM_THEME_NAME="$theme_name"
}

_configure_sddm() {
    [[ -z "${SDDM_THEME_NAME:-}" ]] && return
    msg "Configuring SDDM theme: $SDDM_THEME_NAME"

    sudo mkdir -p /etc
    if [[ ! -f /etc/sddm.conf ]]; then
        printf "[Theme]\nCurrent=%s\n" "$SDDM_THEME_NAME" | sudo tee /etc/sddm.conf > /dev/null
    else
        if grep -q "^\[Theme\]" /etc/sddm.conf; then
            sudo sed -i "/^\[Theme\]/,/^\[/{s/^Current=.*/Current=$SDDM_THEME_NAME/}" /etc/sddm.conf
            grep -q "^Current=" /etc/sddm.conf \
                || sudo sed -i "/^\[Theme\]/a Current=$SDDM_THEME_NAME" /etc/sddm.conf
        else
            printf "\n[Theme]\nCurrent=%s\n" "$SDDM_THEME_NAME" | sudo tee -a /etc/sddm.conf > /dev/null
        fi
    fi
    msg "SDDM configured."
}

_enable_sddm() {
    msg "Checking for conflicting display managers..."
    for dm in gdm lightdm greetd; do
        if command -v "$dm" &>/dev/null; then
            warn "Disabling $dm..."
            sudo systemctl disable --now "$dm" 2>/dev/null || true
            case "$DISTRO" in
                Arch)   sudo pacman -Rns --noconfirm "$dm" 2>/dev/null || true ;;
                Fedora) sudo dnf remove -y "$dm" 2>/dev/null || true ;;
            esac
        fi
    done
    msg "Enabling SDDM..."
    sudo systemctl enable sddm
}

# =============================================================================
#  NUMLOCK
# =============================================================================

setup_numlock() {
    header "NumLock on Boot"
    ask "Enable NumLock on boot?" || { warn "Skipping NumLock."; return; }

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

# =============================================================================
#  DONE
# =============================================================================

print_complete() {
    echo
    echo -e "${TEAL}${BOLD}"
    echo "  ┌────────────────────────────────┐"
    echo "  │  i3wm Setup Complete! :)       │"
    echo "  └────────────────────────────────┘"
    echo -e "${NC}"
    teal "  Backups saved to: $BACKUP_DIR"
    echo
}

prompt_reboot() {
    header "Reboot"
    if ask "Reboot now to apply all changes?"; then
        msg "Rebooting in 3 seconds..."
        sleep 3
        sudo reboot
    else
        warn "Reboot skipped. Please reboot manually when ready."
    fi
}

# =============================================================================
#  MAIN
# =============================================================================

main() {
    clear
    echo -e "${TEAL}${BOLD}"
    echo "  ┌─────────────────────────────────────┐"
    echo "  │        i3wm Dotfiles                │"
    echo "  │   github.com/harilvfs/i3wmdotfiles  │"
    echo "  └─────────────────────────────────────┘"
    echo -e "${NC}"

    detect_distro
    update_system
    setup_aur_helper
    install_dependencies
    verify_dependencies
    install_pokemon_colorscripts
    install_brave
    clone_dotfiles
    apply_configs
    setup_tmux_plugins
    setup_wallpapers
    setup_themes_icons
    setup_sddm
    setup_numlock
    print_complete
    prompt_reboot
}

main
