# dotfiles — Arch + Hyprland full desktop (Alacritty, Kitty, btop, cava, Fastfetch, rofi, unimatrix, Waybar, and more)

This repository is a complete, opinionated yet highly-personalizable Arch Linux + Hyprland desktop setup. It's not just a Neovim config anymore — this is a full Hyprland/Wayland workstation that includes terminal emulators, status bars, launchers, visualizers, system fetchers and small utilities, all intentionally exposed and documented so you can make it yours.

Everything is designed to be customized further: colors, fonts, keybindings, modules, scripts and small program tweaks are easy to find and edit.

Quick summary of what's included
- hypr/ — Hyprland config (compositor, keybindings, monitor rules, autostart)
- waybar/ — fully customized Waybar modules, CSS and scripts
- rofi/ — themed rofi menus: run, window-switcher, powermenu and custom menus
- alacritty/ — Alacritty GPU-backed terminal config and color presets
- kitty/ — Kitty config (advanced features, graphics and ligatures) — choose either or both
- btop/ — btop configuration (modern TUI resource monitor)
- cava/ — cava config (terminal audio visualizer integration)
- fastfetch/ — fastfetch configs for screenshots and login output
- unimatrix/ — unimatrix config for eye-candy / screenshots
- nvim/ — Neovim config (still included, optional)
- scripts/ — helper scripts and installers (installation scripts and guided README will be published soon)
- fonts/, icons/, themes/ — fonts, icon packs and theme assets used by the configs

What each major piece is and how to customize it

- Hyprland (hypr/)
  - What: core Wayland compositor config: monitors, workspace layout, window rules, keybinds and autostart.
  - Where: hypr/hyprland.conf (or hypr/hypr.conf depending on layout). Machine-specific overrides should live in hypr/local.conf (ignored by git).
  - Customize: edit bindings, workspace names, per-monitor scale and rules. Add autostart entries or systemd user units for services.
  - Tip: Keep per-machine secrets or overrides out of the main files and use local/ignored files.

- Waybar (waybar/)
  - What: the status bar. Includes modules for network, audio, battery, updates and many small custom scripts.
  - Customize: change CSS in waybar/style.css, add modules in config.json/config.toml, drop scripts into waybar/scripts/ and reference them from config.
  - Tip: update fonts and icon references in CSS when swapping fonts or icon packs.

- Rofi (rofi/)
  - What: launcher and menus with several pre-made themes and scripts (run menu, appgrid, powermenu, i3/Hypr app switch).
  - Customize: edit themes in rofi/themes/, change colors and padding, and wire hotkeys in Hyprland keybindings.

- Alacritty (alacritty/) and Kitty (kitty/)
  - What: two terminal options. Alacritty is fast and minimal (GPU-accelerated); Kitty is feature-rich (graphics, layout, remote control).
  - Customize:
    - Alacritty: edit alacritty/alacritty.yml to change font family/size, colors, padding and scrollback.
    - Kitty: edit kitty/kitty.conf for tabs, ligatures, images and advanced shortcuts.
  - Integration: both work well with cava and fastfetch. Pick one as your daily driver or keep both.

- btop (btop/)
  - What: modern terminal resource monitor configurable via a single config file.
  - Customize: colors, update intervals, sort behavior and what columns to show. Use with a Hyprland scratchpad or bind it to a key.

- cava (cava/)
  - What: terminal audio visualizer that reads pulse audio and draws bars in the terminal.
  - Customize: adjust colors and bar layout in cava/config to match your theme. Run inside a floating terminal bound to a key.

- fastfetch (fastfetch/)
  - What: lightweight system information fetcher used for screenshots and terminal welcome messages.
  - Customize: change which fields are displayed, ASCII logo, colors and add custom lines.

- unimatrix (unimatrix/)
  - What: fun matrix-style terminal effect for screenshots or idle displays.
  - Customize: density, speed and color.

Personalization philosophy
- Opinionated defaults, easy to edit: Most configs expose top-of-file variables for colors, fonts and behavior so you can change the look quickly.
- Per-host overrides: Use hypr/local.conf or ~/.config/<app>/local.conf (gitignored) for machine-specific differences (GPU, monitors, hardware).
- Symlink strategy: Keep this repo as your source-of-truth and symlink into ~/.config (or use stow).
- Swap pieces freely: You can use Alacritty OR Kitty (or both) without changing other configs. The stack is modular.

Installation (short) — full guides and setup files coming soon
- I will publish a step-by-step installation guide and automated installer scripts (.sh) that:
  - install packages (pacman + AUR helper)
  - back up existing dotfiles safely
  - create symlinks/stow entries from this repo into ~/.config
  - enable user services (pipewire, etc.)
  - provide toggles for Alacritty vs Kitty, and optional features (cava, unimatrix)
- NOTE: setup files and full installation guides will be out soon — they will be added to the scripts/ directory with usage examples and safety checks.

Quick manual setup (minimal)
1. Backup current config:
   cp -r ~/.config ~/.config.backup
2. Clone here:
   git clone https://github.com/Woeter69/dotfiles.git ~/dotfiles
3. Inspect top-of-file variables (colors/fonts) and edit them to taste.
4. Link what you want:
   mkdir -p ~/.config
   ln -s ~/dotfiles/hypr ~/.config/hypr
   ln -s ~/dotfiles/waybar ~/.config/waybar
   ln -s ~/dotfiles/alacritty ~/.config/alacritty   # or kitty
   ln -s ~/dotfiles/rofi ~/.config/rofi
   ln -s ~/dotfiles/btop ~/.config/btop
   ln -s ~/dotfiles/cava ~/.config/cava
5. Install packages (example):
   sudo pacman -Syu hyprland waybar mako wl-clipboard grim slurp pipewire pipewire-pulse xdg-desktop-portal-wlr swaylock
   paru -S alacritty kitty btop cava fastfetch rofi unimatrix hyprpaper hyprpicker
6. Enable essential user services:
   systemctl --user enable --now pipewire pipewire-pulse
7. Start your Hyprland session via your greeter or a Wayland-capable login method.

Customization examples
- Global colors: change base colors in waybar/style.css and alacritty/alacritty.yml to update the look across bar and terminal.
- Fonts: install a patched Nerd Font and set it in both Alacritty and Waybar for consistent icon rendering.
- New Waybar module: drop a script in waybar/scripts/, reference it in config.json and give it a CSS class for styling.
- Audio visualizer: run cava in a floating Alacritty/Kitty instance and bind a Hyprland key to toggle it.

Safety notes
- Always back up current dotfiles before overwriting.
- Use local, gitignored files for secrets or machine differences.
- Test new configs in a spare user or VM if unsure.

Contributing
- PRs welcome for modules, themes, scripts and small fixes. Open an issue first for larger changes.
- Keep local/host-specific files out of git and document changes in PR descriptions.

License
- MIT License — see LICENSE for details.

Contact
- Maintained by Woeter69 — https://github.com/Woeter69
