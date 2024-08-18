<h1>i3-CatDotfiles</h1>

<p>These dotfiles come with <strong>Catppuccin theme & Nordic theme</strong> </p>

![screenshot](https://github.com/aayushx402/Linux-Background/blob/main/i3/20240726_131459.png)
![screenshot](https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/i3wm-nord.png)


![screenshot](https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/2024-08-19_01-30.png)
![screenshot](https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/2024-08-19_01-32_1.png)

<p>
<img src="https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/2024-08-14_23-57.png" alt="screenshot" style="display:inline-block; width:49%;">
<img src="https://github.com/aayushx402/i3-CatDotfiles/blob/main/preview%20images/2024-08-19_01-36.png" alt="screenshot" style="display:inline-block; width:49%;">
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

<p>Use the following script to set up my i3 configuration. Note that I'm still working on it, so it might not work on all systems. If you have issues, you can manually apply my dotfiles:</p>

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

<h2>🎨 Wallpapers</h2>
<ul>
<li><strong>Homescreen:</strong> <a href="https://raw.githubusercontent.com/aayushx402/Linux-Background/main/i3/ign_evening.webp">View</a></li>
<li><strong>Loginscreen:</strong> <a href="https://raw.githubusercontent.com/aayushx402/Linux-Background/main/i3/macchiato.webp">View</a></li>
</ul>

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

<div align = left><br><br>
    
## Keybinds

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>RETURN / ENTER</kbd> | launch kitty/alacritty (terminal)
| <kbd>Super</kbd> + <kbd>D</kbd> | launch rofi/dmenu (application launcher)
| <kbd>Super</kbd> + <kbd>E</kbd> | launch thunar (filemanager)
| <kbd>Super</kbd> + <kbd>B</kbd> | launch brave (browser)
| <kbd>Super</kbd> + <kbd>N</kbd> | screenshot selected area (flameshot)
| <kbd>Super</kbd> + <kbd>M</kbd> | screenshot entire screen (flameshot)
| <kbd>Super</kbd> + <kbd>Q</kbd> | quit active/focused window
| <kbd>ALT</kbd> + <kbd>TAB</kbd> | switch windows

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>NUMBER</kbd> | switch to workspace
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>NUMBER</kbd> | move focused container to workspace
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>C</kbd> | reload the configuration file
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>R</kbd> | restart i3
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> | quit i3 session

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>J</kbd> | focus left
| <kbd>Super</kbd> + <kbd>K</kbd> | focus down
| <kbd>Super</kbd> + <kbd>L</kbd> | focus up
| <kbd>Super</kbd> + <kbd>O</kbd> | focus right

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>J</kbd> | move left
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>K</kbd> | move down
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>L</kbd> | move up
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>O</kbd> | move right

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>H</kbd> | split in horizontal orientation
| <kbd>Super</kbd> + <kbd>V</kbd> | split in vertical orientation
| <kbd>Super</kbd> + <kbd>F</kbd> | enter fullscreen mode for the focused container

<br>

| Keys | Action |
| :--  | :-- |
| <kbd>Super</kbd> + <kbd>SHIFT</kbd> + <kbd>SPACE</kbd> | toggle tiling / floating
| <kbd>Super</kbd> + <kbd>SPACE</kbd> | change focus between tiling / floating windows
| <kbd>Super</kbd> + <kbd>A</kbd> | focus the parent container
| <kbd>Super</kbd> + <kbd>D</kbd> | focus the child container

<div align = left><br><br>

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


