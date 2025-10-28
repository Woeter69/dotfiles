" NEOVIM CONFIG - MODERN FUNCTIONALITY WITH SHORTCUTS (v0.9.5)
" ===========================
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

" emmet
Plug 'mattn/emmet-vim'

" LSP support
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" Codesnap
Plug 'mistricky/codesnap.nvim', { 'do': 'make' }
" Optional: snippets
Plug 'L3MON4D3/LuaSnip'
call plug#end()

set termguicolors
colorscheme tokyonight


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
imap <leader>e <C-y>,
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
nnoremap ; `

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
vnoremap <A-S-s> :CodeSnapSave<CR>
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
nnoremap <silent> \qa :lua require('avante').close_popup()<CR>

lua << EOF
-- suppress lspconfig deprecation warnings
vim.notify = (function(orig_notify)
  return function(msg, ...)
    if type(msg) == "string" and msg:match("require%(\'lspconfig\'%)") then
      return
    end
    orig_notify(msg, ...)
  end
end)(vim.notify)
EOF

" ========================
" LSP + Completion Setup
" ========================

lua << EOF
local lspconfig = require('lspconfig')
local cmp = require'cmp'

-- Common on_attach function
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
end

-- ========================
-- Setup LSP servers
-- ========================

-- Go
lspconfig.gopls.setup{
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
}

-- Python
lspconfig.pyright.setup{
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
}

-- C/C++
lspconfig.clangd.setup{
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
}

-- ========================
-- nvim-cmp setup
-- ========================

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)  -- or use luasnip
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),              -- manual trigger
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {'i','s'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {'i','s'}),
  },
  sources = {
    { name = 'nvim_lsp' },
  },
  completion = { autocomplete = { cmp.TriggerEvent.TextChanged } }, -- auto suggestions
})
EOF

lua << EOF
require("codesnap").setup({
  save_path = "~/Pictures/Codesnap",
	bg_theme = "grape",
  code_font_family = "JetBrainsMono Nerd Font",
  has_breadcrumbs = true,
  has_line_number = true,
  mac_window_bar = true,
  rounded_corner = true,
  frame = true,
  border_color = "#7aa2f7",
  watermark = "",
})
EOF
autocmd VimEnter * call feedkeys("\<CR>", 'n')
