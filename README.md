<h1>i3-CatDotfiles</h1>

<p>These dotfiles come with <strong>Catppuccin theme & Nordic theme</strong> </p>

![screenshot](https://github.com/aayushx402/Linux-Background/blob/main/i3/20240726_131459.png)
<p><strong>Nord BG Credit</strong> <a href="https://github.com/TheDistroHopper" target="_blank" rel="noopener noreferrer">TheDistroHopper</a></p>

![screenshot](https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/i3wm-nord.png)

![screenshot](https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/2024-08-19_15-23.png)
![screenshot](https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/2024-08-19_01-32_1.png)

<p>
<img src="https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/2024-08-14_23-57.png" alt="screenshot" style="display:inline-block; width:49%;">
<img src="https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/2024-08-19_15-23_1.png" alt="screenshot" style="display:inline-block; width:49%;">
</p>

![screenshot](https://raw.githubusercontent.com/aayushx402/images/main/i3/macchiato.webp)

### Config File Overview

- [fastfetch-png](https://github.com/aayushx402/i3-CatDotfiles/tree/main/fastfetch-png) - Fastfetch config with png add ones, Remember alacritty doesn't support image rendering so perfer kitty.    
- [fastfetch](https://github.com/aayushx402/i3-CatDotfiles/tree/main/fastfetch) - Fastfetch config with some changes.
- [i3-i3status](https://github.com/aayushx402/i3-CatDotfiles/tree/main/i3-i3status) - i3wm config with i3status setup.
- [i3-polybar](https://github.com/aayushx402/i3-CatDotfiles/tree/main/i3-polybar) - i3wm config with polybar setup
- [i3status-nord](https://github.com/aayushx402/i3-CatDotfiles/tree/main/i3status-nord) - i3status with nord theme
- [i3status-nordic-2](https://github.com/aayushx402/i3-CatDotfiles/tree/main/i3status-nordic-2) - i3status config with nordic theme but it is bit tweak.
- [polybar-catppuccin](https://github.com/aayushx402/i3-CatDotfiles/tree/main/polybar-catppuccin) - Polybar config with catppuccin theme
- [polybar-nordic](https://github.com/aayushx402/i3-CatDotfiles/tree/main/polybar-nordic) - Polybar config with nordic theme
- [rofi-catppuccin](https://github.com/aayushx402/i3-CatDotfiles/tree/main/rofi-catppuccin) - Rofi config with additional catppuccin theme.
- [rofi-nordic](https://github.com/aayushx402/i3-CatDotfiles/tree/main/rofi-nordic) - Rofi config with nordic theme
- [rofi](https://github.com/aayushx402/i3-CatDotfiles/tree/main/rofi) - Rofi config with catppuccin normal theme

> [!IMPORTANT]
> Note that the keybindings are based on my personal uses, so remember to change them after installation.

<h3>🚀 Quick Setup</h3>

<p>Use the following script to set up my i3 configuration.If you encounter any issues, feel free to submit an issue:</p>

<pre><code>sudo pacman -Syy git
git clone https://github.com/aayushx402/i3-CatDotfiles
cd i3-CatDotfiles
chmod +x setup.sh
./setup.sh
</code></pre>

Or just run this curl command:
<pre><code>curl -fsSL https://raw.githubusercontent.com/aayushx402/i3-CatDotfiles/main/setup.sh | sh </code></pre>

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
- `variety`
- `polkit-gnome`
- `xclip`
- `flameshot`
- `lxappearance`
- `thunar`

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
- *Widget Theme* : `NordArc-Theme` / `Catppuccin-Moncha-Standard`
- *Icon Theme* : `NordArc` / `Nordzy`
- *Mouse Cursor* : `Capitaine Cursors - Light`  / `Qogir`

<div align="left">

## Keybinds

### Launchers
| Key Combo | Action |
|:---------:|:-------|
| <kbd>Super</kbd> + <kbd>Enter</kbd> | Open Terminal (Kitty/Alacritty) |
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
  <li><strong>GTK</strong> - <a href="https://github.com/catppuccin/gtk" target="_blank" rel="noopener noreferrer">Catppuccin</a></li>
  <li><strong>SDDM</strong> - <a href="https://github.com/catppuccin/sddm" target="_blank" rel="noopener noreferrer">Catppuccin</a></li>
</ul>

<h2>Special Thanks</h2>

<p>Shoutout to <strong><a href="https://github.com/Justus0405/i3wm-dotfiles" target="_blank" rel="noopener noreferrer">Justus0405</a></strong> & <strong><a href="https://github.com/TheDistroHopper/i3wm-nord" target="_blank" rel="noopener noreferrer">TheDistroHopper</a></strong> for their <strong>i3wm dotfiles</strong></p>


