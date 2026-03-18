> [!NOTE]
> These days, I'm not daily driving i3 as my window manager. So if you run into any problems, feel free to open an issue.

<div align="center">
  
# `i3wm Dotfiles`

[❓ FAQ](#-faq)

</div>

<p align="center">These dotfiles come with <strong>Catppuccin & Nordic theme</strong>

<div align="center">
  <table><tr><td>

[![Nordic](https://placehold.co/130x30/4c566a/88c0d0?text=Nordic&font=Oswald)](https://github.com/harilvfs/i3wmdotfiles/tree/nord)
[![Catppuccin](https://placehold.co/130x30/b4befe/11111b?text=Catppuccin&font=Oswald)](https://github.com/harilvfs/i3wmdotfiles/tree/catppuccin)

  </td></tr></table>
</div>

<div align="center"><table><tr><strong>Nordic</strong></tr><tr><td>
<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/2024-08-21_22-03.png"/></td><td>
<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/2024-08-21_22-05.png"/></td></tr></table></div>

<div align="center"><table><tr><strong>Catppuccin</strong></tr><tr><td>
<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/2024-08-14_23-57.png"/></td><td>
<img src="https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/refs/heads/main/preview/2024-08-14_23-58.png"/></td></tr></table></div>

### Explore Configuration Branches

> - **Catppuccin Configs:** [GitHub Link](https://github.com/harilvfs/i3wmdotfiles/tree/catppuccin)  
> - **Nord Configs:** [GitHub Link](https://github.com/harilvfs/i3wmdotfiles/tree/nord)  

> [!NOTE] 
>
> Theme-specific configurations are placed in different branches of the repository to avoid conflicts. Make sure to check them out before using.

> [!IMPORTANT]  
> Note that the keybindings are based on my personal use, so remember to change them after installation.  
> Also, make sure to install **fzf** before running the setup script, depending on your distro:
>
> For **Arch Linux**:
> ```sh
> sudo pacman -S fzf --noconfirm
> ```
> For **Fedora**:
> ```sh
> sudo dnf install fzf -y
> ```

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
 
**Manually:**
```bash
git clone https://github.com/harilvfs/i3wmdotfiles ~/i3wmdotfiles
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
> - `dunst`
> - `starship`
> - `zoxide`
> - `fastfetch`
> - `brightnessctl`

### Default Apps

> - **Browser:** `Brave`
> - **File Manager:** `Thunar`
> - **Code Editor:** `Neovim` aka `nvim`
> - **Screenshot Tool:** `Flameshot`
> - **Terminal:** `Alacritty`
> - **Launcher:** `Rofi`
> - **Status Bar:** `Polybar`
> - **Shell:** `Bash`
> - **Screen Locker:** `slock`

### Wallpapers

> If you want additional wallpapers, clone this repository.
> 
> ```bash
> git clone https://github.com/harilvfs/wallpapers
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

### Themes & Icons
 
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
| <kbd>Super</kbd> + <kbd>U</kbd> | Lock Screen (slock) |
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
| <kbd>Super</kbd> + <kbd>N</kbd> | Screenshot Selected Area (Flameshot) |
| <kbd>Super</kbd> + <kbd>M</kbd> | Screenshot Entire Screen (Flameshot) |
 
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

### Why is the configuration after installation different from the image preview in the README?

> Hear me out. The main difference you will see from that image is in the Polybar and Fastfetch config. In Polybar, I was using Nerd icons instead of simple 1,2,3 workspace indicators. But I found some bugs or maybe it was my *skill issue* that didn’t make it a *best* choice. So I simplify it by removing those and using 1,2,3 as the workspace indicator.
> 
> The Fastfetch config I used a year ago worked fine because I was using Kitty as my main terminal. There are also some issues nowadays with image-based Fastfetch configs (idk why) maybe due to some new Kitty updates or something else that idk. So I'vee removed that and used a simple one that works just fine.
>
> If you want the old one, you can grab it from the Fastfetch **branch** in this repo. You will also need a terminal that supports image rendering for it to work.

### Why is SDDM not showing after installation or showing a blank screen?

> This is the core issue I was facing for the past few months. Due to less time, I couldn’t solve it earlier. But recently, I've refactored everything, found some issue, and fixed it. It should work fine now.
> 
> I have tested it on Arch, and it works fine with both Catppuccin and Nordic theme. If you still face any issues, feel free to open a bug report. I will take a look.

### Does everything work fine now?

> Yeah, it should work fine.

## Contributing
 
If you find any issue with the configs after installation, opening an issue is the best way to help. Your bug report helps me investigate and improve things for everyone. Finding and reporting bugs is the biggest contribution you can make & thanks for that.

## Credits

- **Fastfetch** - [harilvfs/fastfetch](https://github.com/harilvfs/fastfetch)
- **Alacritty** - [ChrisTitusTech](https://github.com/ChrisTitusTech/dwm-titus)
- **Rofi** - [TypeCraft](https://github.com/typecraft-dev/dotfiles) , [harilvfs](https://github.com/harilvfs/dwm/tree/main/config/rofi)
- **Polybar** - [TypeCraft](https://github.com/typecraft-dev/dotfiles)
- **Picom** - [lactua](https://github.com/lactua/dotfiles)
- **GTK** - [Catppuccin](https://github.com/catppuccin/gtk) & some nord themes from the internet (i forgot whose, but yeah thanks).
- **SDDM** - [Catppuccin](https://github.com/catppuccin/sddm) , [sddm-astronaut-theme](https://github.com/Keyitdev/sddm-astronaut-theme)

## Special Thanks
 
Shoutout to [Justus0405](https://github.com/Justus0405/i3wm-dotfiles) & [TheDistroHopper](https://github.com/TheDistroHopper/i3wm-nord) for their i3wm dotfiles.
