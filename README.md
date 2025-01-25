<p align="center"><strong>i3wm Dotfiles</strong>

<p align="center">These dotfiles come with <strong>Catppuccin & Nordic theme</strong>

<p align="center"><img src="https://img.shields.io/badge/Theme-Catppuccin-blue?colorA=363a4f&colorB=b7bdf8&style=for-the-badge">  <img src="https://img.shields.io/badge/Theme-Nord-blue?style=for-the-badge&colorA=4c566a&colorB=88c0d0">

![screenshot](https://github.com/harilvfs/assets/blob/main/i3/20240726_131459.png)
<p align="center"><strong>Nord BG Credit</strong> <a href="https://github.com/TheDistroHopper" target="_blank" rel="noopener noreferrer">TheDistroHopper</a>

![screenshot](https://github.com/harilvfs/i3wmdotfiles/blob/main/preview%20images/i3wm-nord.png)

![screenshot](https://github.com/harilvfs/i3wmdotfiles/blob/main/preview%20images/2024-08-21_22-03.png)
![screenshot](https://github.com/harilvfs/i3wmdotfiles/blob/main/preview%20images/2024-08-21_22-05.png)

<p>
<img src="https://github.com/harilvfs/i3wmdotfiles/blob/main/preview%20images/2024-08-14_23-57.png" alt="screenshot" style="display:inline-block; width:49%;">
<img src="https://github.com/harilvfs/i3wmdotfiles/blob/main/preview%20images/2024-08-19_15-23_1.png" alt="screenshot" style="display:inline-block; width:49%;">
</p>

![screenshot](https://raw.githubusercontent.com/harilvfs/assets/main/i3/macchiato.webp)

### Explore Configuration Branches

- **Catppuccin Configs:** [GitHub Link](https://github.com/harilvfs/i3wmdotfiles/tree/catppuccin)  
- **Nord Configs:** [GitHub Link](https://github.com/harilvfs/i3wmdotfiles/tree/nord)  

> [!NOTE] 
>
> All main i3 configurations are organized into separate branches to avoid conflicts and provide a cleaner, more structured experience. Check out the branches for a better understanding of each configuration.

> [!IMPORTANT]
> Note that the keybindings are based on my personal uses, so remember to change them after installation.

<h3>🚀 Quick Setup</h3>

<p>Use the following script to install dependencies for i3wm.If you encounter any issues, feel free to submit an issue:</p>

<pre><code>git clone https://github.com/harilvfs/i3wmdotfiles
cd i3wmdotfiles/
chmod +x setup.sh
./setup.sh
</code></pre>

Or just run this curl command:
<pre><code>curl -fsSL https://raw.githubusercontent.com/harilvfs/i3wmdotfiles/main/setup.sh | sh </code></pre>

### Dependencies
- `i3status`
- `polybar`
- `dmenu`
- `rofi`
- `alacritty`
- `kitty`
- `picom`
- `maim`
- `fish`
- `imwheel`
- `nitrogen`
- `polkit-gnome`
- `xclip`
- `flameshot`
- `lxappearance`
- `thunar`
- `gnome-keyring`
- `neovim`
- `pasystray`
- `nm-applet`
- `zsh`

### 🚀 Default Apps

- **Browser:** `Thorium` / `Brave`
- **File Manager:** `Nemo` / `Thunar`
- **Code Editor:** `Cursor` / `Vim`
- **Screenshot Tool:** `Flameshot`
- **Terminal:** `Alacritty` / `Kitty`
- **Launcher:** `Rofi` / `Dmenu`
- **Status Bar:** `Polybar` / `i3status`
- **Shell:** `Bash` / `Zsh`

### Nord Background
To use the Nord background, clone the repository with the following command:

```bash
git clone https://github.com/ChrisTitusTech/nord-background
```
#### Set Wallpaper using `nitrogen`

#### Change Theme, Icons and Mouse Cursor from `lxappearance`
- **Download `themes` and `icons` from my repositories**: [Themes Repository](https://github.com/harilvfs/themes) | [Icons Repository](https://github.com/harilvfs/icons).
- *Widget Theme* : `NordArc-Theme` / `Catppuccin-Moncha-Standard`
- *Icon Theme* : `NordArc` / `Nordzy`
- *Mouse Cursor* : `Capitaine Cursors - Light`  / `Bibata-Modern-Ice`

<div align="left">

## Keybinds

### Launchers
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>X</kbd> | Open Terminal (Kitty/Alacritty) |
| <kbd>Super</kbd> + <kbd>D</kbd> | Open App Launcher (Rofi/dmenu) |
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
  <li><strong>Fastfetch</strong> - <a href="https://github.com/ChrisTitusTech/mybash" target="_blank" rel="noopener noreferrer">ChrisTitusTech</a></li>
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


