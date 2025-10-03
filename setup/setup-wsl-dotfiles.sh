# Update and upgrade Ubuntu
sudo apt update && sudo apt upgrade -y

# Install essentials
sudo apt install -y zsh git curl wget fzf neovim postgresql

# Install Oh My Zsh non-interactively
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Change default shell to zsh
chsh -s $(which zsh)

# Backup old configs
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup

# Clone your dotfiles if not already cloned
if [ ! -d ~/dotfiles ]; then
  git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
fi

# Symlink your dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/.psqlrc ~/.psqlrc

zsh
echo "Zsh + Neovim setup complete. Open a new WSL session to start using your dotfiles."
