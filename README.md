> [!NOTE]
> These days, I'm not daily driving i3 as my window manager. So if you run into any problems, feel free to open an issue.

<div align="center">
  
# `i3wm Dotfiles`

[❓ FAQ](#-faq)

</div>

<div align="center"><table><tr></tr><tr><td>
<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/preview-1.png"/></td><td>
<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/preview-2.png"/></td></tr></table></div>

<div align="center"><table><tr></tr><tr><td>
<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/preview-3.png"/></td><td>
<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/preview-4.png"/></td></tr></table></div>

### Installation

> [!CAUTION]
> The installation should work great on a freshly installed system like Arch Linux. Unfortunately, Fedora doesn't come as clean (obviously, GNOME and KDE come pre-baked). That said, it should also work fine on an already configured system, as long as you don't have hard-coded configs.
>
> If you are on fish shell, just switch to bash first and then run the command:
> ```bash
> bash
> ```
 
**One-Liner:**
```bash
bash <(curl -L https://chalisehari.com.np/i3wm)
```

Or
 
**Manually:**
```bash
git clone https://github.com/harilvfs/i3wmdotfiles
cd ~/i3wmdotfiles
chmod +x setup.sh
./setup.sh
```

### Dependencies

> - `polybar`
> - `rofi`
> - `alacritty`
> - `picom`
> - `maim`
> - `imwheel`
> - `polkit-gnome`
> - `xclip`
> - `flameshot`
> - `lxappearance`
> - `thunar`
> - `gnome-keyring`
> - `neovim`
> - `pasystray`
> - `network-manager-applet`
> - `feh`
> - `ttf-meslo-nerd`
> - `noto-fonts-emoji`
> - `ttf-jetbrains-mono`
> - `gnome-settings-daemon`
> - `xorg-server`
> - `xorg-xinit`
> - `xorg-xrandr`
> - `xorg-xset`
> - `gtk3`
> - `slock`
> - `xautolock`
> - `i3lock`
> - `dunst`
> - `starship`
> - `zoxide`
> - `fastfetch`
> - `brightnessctl`
> - `tmux`
> - `yad`
> - `blueman`
> - `fish`
> - `eza`

### Default Apps

> - **Browser:** `Brave`
> - **File Manager:** `Thunar`
> - **Code Editor:** `Neovim` aka `nvim`
> - **Screenshot Tool:** `Flameshot`
> - **Terminal:** `Alacritty`
> - **Launcher:** `Rofi`
> - **Status Bar:** `Polybar`
> - **Shell:** `Bash`
> - **Screen Locker:** `slock` / `i3lock`

### Wallpapers

> ```bash
> git clone https://github.com/harilvfs/wallpapers ~/Pictures/wallpapers
> ```
>
> Set Wallpaper using `feh`

### Welcome

<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/welcome0.png" width="500" height="auto" />

> A welcome popup appears on your first i3wm startup showing basic keybindings and helpful links.
>
> You can click **Don't show again** to disable the popup on next startup. If you want to re-enable it (I know you don't need to, but just in case) run:
> ```bash
> rm ~/.config/i3/scripts/.welcome_disabled
> ```

### Themes & Icons Source
 
> Change theme, icons and mouse cursor from `lxappearance`.
>
> - **Download themes and icons from my repositories:** [Themes](https://github.com/harilvfs/themes) | [Icons](https://github.com/harilvfs/icons)
> - *Widget Theme:* `NordArc-Theme` / `Catppuccin-Mocha-Standard`
> - *Icon Theme:* `NordArc` / `Nordzy`
> - *Mouse Cursor:* `Capitaine Cursors - Light` / `Bibata-Modern-Ice`

## Keybinds
 
### Launchers
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>X</kbd> | Open Terminal (Alacritty) |
| <kbd>Super</kbd> + <kbd>R</kbd> | Open App Launcher (Rofi) |
| <kbd>Super</kbd> + <kbd>E</kbd> | Open File Manager (Thunar) |
| <kbd>Super</kbd> + <kbd>B</kbd> | Open Default Browser |
 
### System
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>U</kbd> | Lock Screen (i3lock) |
| <kbd>Super</kbd> + <kbd>I</kbd> | Toggle Bar |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>I</kbd> | Hide Bar |
 
### Brightness
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> | Increase Brightness |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> | Decrease Brightness |
 
### Wallpaper
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd> | Change Wallpaper (feh) |
 
### Screenshots
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> | Screenshot Selected Area (Flameshot) |
| <kbd>Super</kbd> + <kbd>P</kbd> | Screenshot Entire Screen (Flameshot) |
 
### Window Management
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>Q</kbd> | Close Focused Window |
| <kbd>Alt</kbd> + <kbd>Tab</kbd> | Switch Windows |
| <kbd>Super</kbd> + <kbd>Number</kbd> | Switch Workspace |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Number</kbd> | Move Container to Workspace |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>G</kbd> | Gaps Mode |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> | Reload Config |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> | Restart i3 |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> | Exit i3 Session |
 
### Navigation
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>J</kbd> | Focus Left |
| <kbd>Super</kbd> + <kbd>K</kbd> | Focus Down |
| <kbd>Super</kbd> + <kbd>L</kbd> | Focus Up |
| <kbd>Super</kbd> + <kbd>O</kbd> | Focus Right |
 
### Moving Windows
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>J</kbd> | Move Left |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>K</kbd> | Move Down |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>L</kbd> | Move Up |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> | Move Right |
 
### Layouts
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>H</kbd> | Split Horizontally |
| <kbd>Super</kbd> + <kbd>V</kbd> | Split Vertically |
| <kbd>Super</kbd> + <kbd>F</kbd> | Toggle Fullscreen |
 
### Tiling/Floating
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Space</kbd> | Toggle Tiling/Floating |
| <kbd>Super</kbd> + <kbd>Space</kbd> | Switch Focus between Tiling/Floating |
| <kbd>Super</kbd> + <kbd>A</kbd> | Focus Parent Container |
| <kbd>Super</kbd> + <kbd>D</kbd> | Focus Child Container |

## ❓ FAQ

### Why is SDDM not showing after installation or showing a blank screen?

> This issue has happening because the theme name is not correctly set in `/etc/sddm.conf`. If the issue is happening again, check this config file. Also run `ls /usr/share/sddm/themes/sddm-astronaut-theme/` and see if `sddm-astronaut-theme` exists in that directory or not. Also make sure to check that SDDM is installed properly. The setup script will install SDDM, but you can always verify that.
>
> If this exists but still does not work, then run `sudo systemctl enable sddm` and reboot. The issue should be solved here. If anything else occurs, open an issue.

## Contributing
 
If you find any issue with the configs after installation, opening an issue is the best way to help. Your bug report helps me investigate and improve things for everyone. Finding and reporting bugs is the biggest contribution you can make & thanks for that.

## Credits

- [ChrisTitusTech](https://github.com/ChrisTitusTech/)
- [Justus0405](https://github.com/Justus0405/i3wm-dotfiles)
- [TheDistroHopper](https://github.com/TheDistroHopper/i3wm-nord)
- [sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme)

This guys become very helpful while setting this up. Thanks ;)
