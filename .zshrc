# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install Vim-Plug for Neovim if missing
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# ------------------------------
# Zinit (plugin manager)
# ------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------
# Plugins
# ------------------------------
zinit ice depth=1
zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# ------------------------------
# Load completions
# ------------------------------
autoload -U compinit && compinit

# ------------------------------
# Powerlevel10k config
# ------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ------------------------------
# Keybindings
# ------------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# ------------------------------
# History
# ------------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ------------------------------
# Completion styling
# ------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# ------------------------------
# Aliases
# ------------------------------
alias nv='nvim'
alias ls='ls --color=never'

# ------------------------------
# fzf integration
# ------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------
# PATH additions
# ------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/snap/bin

# ------------------------------
# NVM (Node Version Manager)
# ------------------------------
hash() { true; }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ------------------------------
# End of zshrc
# -----------------------------

export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/go/bin
