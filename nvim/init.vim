
" ===========================
" NEOVIM CONFIG - MODERN FUNCTIONALITY WITH SHORTCUTS (v0.9.5)
" ===========================


let g:python3_host_prog = expand("~/.venvs/nvim/bin/python")

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

Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim' 

" Avante AI plugin
Plug 'yetone/avante.nvim'

" Colorschemes
Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

call plug#end()

set termguicolors
colorscheme catppuccin


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

" Disable default keybindings if you want
let g:codeium_disable_bindings = 1

" Accept full suggestion with Ctrl+F
imap <script><silent><nowait><expr> <C-f> codeium#Accept()

" Accept next word or line
imap <script><silent><nowait><expr> <C-h> codeium#AcceptNextWord()
imap <script><silent><nowait><expr> <C-j> codeium#AcceptNextLine()

" Cycle completions
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>

" Clear suggestion
imap <C-x>   <Cmd>call codeium#Clear()<CR>

hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE
hi StatusLine guibg=NONE
hi StatusLineNC guibg=NONE
hi LineNr guibg=NONE
hi NonText guibg=NONE
hi SignColumn guibg=NONE
hi Pmenu guibg=NONE
hi PmenuSel guibg=NONE

" --- Avante AI Panel ---
" Open floating AI popup
nnoremap <silent> \t :lua require('avante').ask_popup()<CR>

" Close popup
nnoremap <silent> \q :lua require('avante').close_popup()<CR>

lua << EOF
require('avante').setup({
  ai = {
    provider = 'claude',           -- or another supported AI
    model = 'claude-sonnet-4',
    api_key = os.getenv("CLAUDE_API_KEY"), -- set in your environment if needed
  },
  float = {
    width = 0.35,                  -- 35% of editor width
    height = 0.8,                  -- 80% of editor height
    border = 'rounded'
  }
})
EOF
