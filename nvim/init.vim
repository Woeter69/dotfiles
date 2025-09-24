
" ===========================
" NEOVIM CONFIG - MODERN FUNCTIONALITY WITH SHORTCUTS (v0.9.5)
" ===========================

" --- Plugin Manager ---
call plug#begin('~/.local/share/nvim/plugged')

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" File tree
Plug 'preservim/nerdtree'

" Better syntax highlighting
Plug 'sheerun/vim-polyglot'

" Auto pairs / braces
Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'

" Comment/uncomment lines easily
Plug 'tpope/vim-commentary'

" Auto-completion & language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Treesitter for syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" --- Basic Settings ---
set number
set relativenumber
set hlsearch
set clipboard=unnamedplus
syntax on

" --- Key Mappings ---
" Insert mode
inoremap kj <Esc>
inoremap <C-s> <Esc>:w<CR>a

" Normal mode
nnoremap <C-s> :w<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> :C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <A-Up> :resize +2<CR>
nnoremap <A-Down> :resize -2<CR>
nnoremap <A-Left> :vertical resize -2<CR>
nnoremap <A-Right> :vertical resize +2<CR>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>


" fuzzy search inside the current buffer immediately
nnoremap \l :BLines<CR>

" fuzzy find files (current directory)
nnoremap \z :Files<CR>

" Toggle comments for selected lines
vnoremap <leader>c gc

" Map Alt+v to Visual Block mode
nnoremap <M-v> <C-v>

" --- Terminal Splits ---
nnoremap <S-x> :rightbelow vsplit<Bar>terminal<CR>
nnoremap <S-h> :belowright split<Bar>terminal<CR>
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>

" --- Plugin Shortcuts ---
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :Helptags<CR>

" --- coc.nvim settings ---
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Additional coc.nvim shortcuts
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
nnoremap <leader>r :call CocActionAsync('rename')<CR>
nnoremap <leader>F :call CocActionAsync('format')<CR>

" Map Alt+e to go to the end of the current line
nnoremap <M-e> $

" Close current buffer with Shift+Esc
nnoremap <S-Esc> :bd<CR>

" --- Load Lua plugin configs ---
lua require('plugins.autopairs')
lua require('plugins.treesitter')

lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { "c", "cpp" },
  },
}
EOF


" bootstrap packer if needed
lua << EOF
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end
EOF

" plugin setup
lua << EOF
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'andweeb/presence.nvim',
    config = function()
      require("presence"):setup({
        auto_update = true,
        neovim_image_text = "Editing with Neovim",
        main_image = "neovim",
        buttons = false,
      })
    end
  }
end)
EOF
