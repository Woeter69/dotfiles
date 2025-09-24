# dotfiles

Welcome to the **Woeter69/dotfiles** repository! This repository contains my personal configuration files (dotfiles) for various tools, shells, editors, and development environments. Dotfiles help keep your environment consistent across different machines and make it easy to share and update your setup.

## What's Inside?

This repo typically includes configuration for:
- Shells: `.zshrc`, etc.
- Git: `.gitconfig`
- Editors: Neovim (`init.vim`), VSCode settings, etc.
- Terminal: `.tmux.conf`, `.screenrc`
- Other tools: `.inputrc`, `.profile`, custom scripts, aliases, and more!

## Usage

To set up these dotfiles on a new machine:

## WSL + Zsh + Neovim Setup

This setup installs WSL (Ubuntu), Zsh, Oh My Zsh, Neovim, and links the dotfiles from this repository.

### Requirements

- Windows 10/11
- Admin access for PowerShell

### Steps

1. **Install WSL**

   Run the PowerShell script as Administrator:

   ```powershell
   cd ~/dotfiles/setup
   .\setup-wsl.ps1
   ```

   This installs WSL and Ubuntu. Once done, open Ubuntu.

2. **Clone the dotfiles in WSL**

   _Inside Ubuntu WSL:_
   ```sh
   git clone https://github.com/Woeter69/dotfiles.git ~/dotfiles
   cd ~/dotfiles/setup
   ```

3. **Install Zsh, Neovim, and link dotfiles**

   ```sh
   chmod +x setup-wsl-dotfiles.sh
   ./setup-wsl-dotfiles.sh
   ```

   - Installs Zsh, Oh My Zsh, Neovim, and essential tools.
   - Symlinks `.zshrc` and `nvim/` from this repo.
   - Backs up any existing configs automatically.

4. **Start using your dotfiles**

   Open a new WSL session to use Zsh with your configuration.

   Neovim will use `~/dotfiles/nvim/init.vim`.

### Optional

- Customize `.zshrc` or `init.vim` in the repo. Changes automatically reflect if symlinks exist.
- To restore old configs, check `~/.zshrc.backup` and `~/.config/nvim.backup`.

## License

These dotfiles are provided under the MIT License. See [LICENSE](LICENSE) for details.

---

> _“Your dotfiles are your toolbox. Take care of them!”_
