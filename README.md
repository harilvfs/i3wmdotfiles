> [!NOTE]
> These days, I’m not daily driving i3 as my window manager. So if you run into any problems, feel free to open an issue.

<div align="center">
  
# `i3wm Dotfiles`

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
> sudo pacman -S fzf --no-confirm
> ```
> For Fedora:
> ```sh
> sudo dnf install fzf -y
> ```

### ⚡ One-Liner Installation

Run this command for a quick setup:

```bash
bash <(curl -L https://chalisehari.com.np/i3wm)
```

or

If you are using fish shell

```bash
 bash -c "$(curl -fsSL chalisehari.com.np/i3wm)"
```

### 🚀 Manually

>
> ```bash
> git clone https://github.com/harilvfs/i3wmdotfiles ~/i3wmdotfiles
> cd ~/i3wmdotfiles
> chmod +x setup.sh
> ./setup.sh
> ```

### Dependencies

> - `i3status`
> - `polybar`
> - `dmenu`
> - `rofi`
> - `alacritty`
> - `kitty`
> - `picom`
> - `maim`
> - `fish`
> - `imwheel`
> - `nitrogen`
> - `polkit-gnome`
> - `xclip`
> - `flameshot`
> - `lxappearance`
> - `thunar`
> - `gnome-keyring`
> - `neovim`
> - `pasystray`
> - `network-manager-applet`
> - `zsh`
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
> - `xterm`

### 🚀 Default Apps

> - **Browser:** `Thorium` / `Brave`
> - **File Manager:** `Nemo` / `Thunar`
> - **Code Editor:** `Cursor` / `Vim`
> - **Screenshot Tool:** `Flameshot`
> - **Terminal:** `Alacritty` / `Kitty`
> - **Launcher:** `Rofi` / `Dmenu`
> - **Status Bar:** `Polybar` / `i3status`
> - **Shell:** `Bash` / `Zsh`

### Wallpapers

> If you want additional wallpapers, clone this repository.
> 
> ```bash
> git clone https://github.com/harilvfs/wallpapers
> ```
>
> Set Wallpaper using `nitrogen` or `feh`

#### Change Theme, Icons and Mouse Cursor from `lxappearance`
> - **Download `themes` and `icons` from my repositories**: [Themes Repository](https://github.com/harilvfs/themes) | [Icons Repository](https://github.com/harilvfs/icons).
> - *Widget Theme* : `NordArc-Theme` / `Catppuccin-Moncha-Standard`
> - *Icon Theme* : `NordArc` / `Nordzy`
> - *Mouse Cursor* : `Capitaine Cursors - Light`  / `Bibata-Modern-Ice`

<div align="left">

## Keybinds

### Launchers
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>X</kbd> | Open Terminal (Kitty/Alacritty) |
| <kbd>Super</kbd> + <kbd>R</kbd> | Open App Launcher (Rofi/dmenu) |
| <kbd>Super</kbd> + <kbd>E</kbd> | Open File Manager (Thunar) |
| <kbd>Super</kbd> + <kbd>B</kbd> | Open Browser (Brave) |

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
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> | Reload Config |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd> | Restart i3 |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> | Exit i3 Session |

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

</div>

<h2>🔗 Credits</h2>

<ul>
  <li><strong>Fastfetch</strong> - <a href="https://github.com/harilvfs/fastfetch" target="_blank" rel="noopener noreferrer">harilvfs/fastfech</a></li>
  <li><strong>Alacritty</strong> - <a href="https://github.com/ChrisTitusTech/dwm-titus" target="_blank" rel="noopener noreferrer">ChrisTitusTech</a></li>
  <li><strong>Kitty</strong> - <a href="https://github.com/ChrisTitusTech/linutil" target="_blank" rel="noopener noreferrer">ChrisTitusTech</a></li>
  <li><strong>Rofi</strong> - <a href="https://github.com/typecraft-dev/dotfiles" target="_blank" rel="noopener noreferrer">TypeCraft</a> , <a     
href="https://github.com/Justus0405/i3wm-dotfiles" target="_blank" rel="noopener noreferrer">Justus0405</a> & <a href="https://github.com/ChrisTitusTech/dwm-titus/tree/main/config/rofi" target="_blank" rel="noopener noreferrer">ChrisTitusTech</a></li>
  <li><strong>Polybar</strong> - <a href="https://github.com/typecraft-dev/dotfiles" target="_blank" rel="noopener noreferrer">TypeCraft</a></li>
  <li><strong>Picom</strong> - <a href="https://github.com/lactua/dotfiles" target="_blank" rel="noopener noreferrer">lactua</a></li>
  <li><strong>GTK</strong> - <a href="https://github.com/catppuccin/gtk" target="_blank" rel="noopener noreferrer">Catppuccin</a></li>
  <li><strong>SDDM</strong> - <a href="https://github.com/catppuccin/sddm" target="_blank" rel="noopener noreferrer">Catppuccin</a></li>
</ul>

<h2>Special Thanks</h2>

<p>Shoutout to <strong><a href="https://github.com/Justus0405/i3wm-dotfiles" target="_blank" rel="noopener noreferrer">Justus0405</a></strong> & <strong><a href="https://github.com/TheDistroHopper/i3wm-nord" target="_blank" rel="noopener noreferrer">TheDistroHopper</a></strong> for their <strong>i3wm dotfiles.</strong></p>


