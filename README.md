# dotfiles

Welcome to the **Woeter69/dotfiles** repository! This repository contains my personal configuration files (dotfiles) for various tools, shells, editors, and development environments. Dotfiles help keep your environment consistent across different machines and make it easy to share and update your setup.

## What's Inside?

This repo typically includes configuration for:
- Shells: `.bashrc`, `.zshrc`, etc.
- Git: `.gitconfig`
- Editors: Vim (`.vimrc`), Neovim (`init.vim`), VSCode settings, etc.
- Terminal: `.tmux.conf`, `.screenrc`
- Other tools: `.inputrc`, `.profile`, custom scripts, aliases, and more!

## Usage

To set up these dotfiles on a new machine:

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Woeter69/dotfiles.git ~/dotfiles
   ```

2. **Symlink the configuration files:**
   ```sh
   ln -s ~/dotfiles/.bashrc ~/.bashrc
   ln -s ~/dotfiles/.vimrc ~/.vimrc
   # Repeat for other dotfiles as needed
   ```

3. **(Optional) Use a setup script:**  
   If this repo contains a setup/install script, run it to automate symlinking and setup:
   ```sh
   cd ~/dotfiles
   ./install.sh
   ```

## Customization

Feel free to fork, modify, and use these dotfiles for your own setup!  
If you have suggestions or improvements, open a pull request or issue.

## License

These dotfiles are provided under the MIT License. See [LICENSE](LICENSE) for details.

---

> _“Your dotfiles are your toolbox. Take care of them!”_
