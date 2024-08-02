![screenshot](https://github.com/aayushx402/Linux-Background/blob/main/i3/20240726_131459.png)
<h1>🌈 i3-CatDotfiles</h1>
<h2>🌟 Personalized Dotfiles for i3 Window Manager</h2>

<p>Welcome to my collection of <strong>personalized dotfiles</strong> for the <strong>i3 window manager</strong>! 🎨</p>

<p>These dotfiles come with a stunning <strong>Catppuccin theme</strong> that enhances your workspace with a beautiful, cohesive look.</p>


![screenshot](https://github.com/aayushx402/Linux-Background/blob/main/i3/2024-07-26_11-51.png)
![screenshot](https://github.com/aayushx402/Linux-Background/blob/main/i3/2024-08-02_23-08.png)
![screenshot](https://github.com/aayushx402/Linux-Background/blob/main/i3/macchiato.webp)

<strong>✨ Added Nord Theme For Alacritty and i3Status ❄️</strong>

<p>
    <img src="https://github.com/aayushx402/Linux-Background/blob/main/Nordic%20Theme/2024-08-02_11-32.png" alt="screenshot" style="display:inline-block; width:49%;">
    <img src="https://github.com/aayushx402/Linux-Background/blob/main/Nordic%20Theme/2024-08-02_11-39.png" alt="screenshot" style="display:inline-block; width:49%;">
</p>

<h3>🚀 Quick Setup</h3>

<p>Use the following script to set up my i3 configuration. Note that I'm still working on it, so it might not work on all systems. If you have issues, you can manually apply my dotfiles:</p>

<pre><code>sudo pacman -Syy git
git clone https://github.com/aayushx402/i3-CatDotfiles
cd i3-CatDotfiles
chmod +x setup.sh
./setup.sh
</code></pre>

<h2>🎨 Wallpapers</h2>
<ul>
  <li><strong>Homescreen:</strong> <a href="https://raw.githubusercontent.com/aayushx402/Linux-Background/main/i3/ign_evening.webp">View</a></li>
  <li><strong>Loginscreen:</strong> <a href="https://raw.githubusercontent.com/aayushx402/Linux-Background/main/i3/macchiato.webp">View</a></li>
</ul>

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

#### Set Wallpaper using `nitrogen`

#### Change Theme, Icons and Mouse Cursor from `lxappearance`
- *Widget Theme* : `Catppuccin-Mocha-Standard`
- *Icon Theme* : `Papirus-Dark`
- *Mouse Cursor* : `Qogir-Dark`

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

<p>Big thanks to these amazing projects that helped shape my setup:</p>

<ul>
  <li><strong>Fastfetch</strong> - <a href="https://github.com/ChrisTitusTech/mybash" target="_blank" rel="noopener noreferrer">ChrisTitusTech</a></li>
  <li><strong>Alacritty</strong> - <a href="https://github.com/ChrisTitusTech/dwm-titus" target="_blank" rel="noopener noreferrer">ChrisTitusTech</a></li>
  <li><strong>Kitty</strong> - <a href="https://github.com/ChrisTitusTech/linutil" target="_blank" rel="noopener noreferrer">ChrisTitusTech</a></li>
  <li><strong>Rofi</strong> - <a href="https://github.com/typecraft-dev/dotfiles" target="_blank" rel="noopener noreferrer">TypeCraft</a> , <a href="https://github.com/Justus0405/i3wm-dotfiles" target="_blank" rel="noopener noreferrer">Justus0405</a> & <a href="https://github.com/ChrisTitusTech/dwm-titus/tree/main/config/rofi" target="_blank" rel="noopener noreferrer">ChrisTitusTech</a></li>
  <li><strong>GTK</strong> - <a href="https://github.com/catppuccin/gtk" target="_blank" rel="noopener noreferrer">Catppuccin</a></li>
  <li><strong>SDDM</strong> - <a href="https://github.com/catppuccin/sddm" target="_blank" rel="noopener noreferrer">Catppuccin</a></li>
</ul>

<h2>🙏 Special Thanks</h2>

<p>A huge shoutout to <strong><a href="https://github.com/Justus0405/i3wm-dotfiles" target="_blank" rel="noopener noreferrer">Justus0405</a></strong> & <strong><a href="https://github.com/TheDistroHopper/i3wm-nord" target="_blank" rel="noopener noreferrer">TheDistroHopper</a></strong> for their incredible <strong>i3wm dotfiles</strong>. Their work has been an invaluable resource and inspiration for my own setup.</p>


