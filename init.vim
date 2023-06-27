set nocompatible              " be iMproved, required

lua require("plugins") -- packer plugins

set ruler
set number
set showcmd
set encoding=utf-8
set expandtab
set tabstop=4
set shiftwidth=4
set noshowmode
set linebreak
set breakindent
set timeoutlen=1500
set hidden
set clipboard^=unnamed,unnamedplus
set termguicolors
set cursorline
set guifont=Iosevka\ Sandvich:h12
set list lcs=tab:▏\ 
set fillchars+=eob:*,stlnc:─,vert:│
set smartcase
set ignorecase
set showtabline=0
set exrc

let g:loaded_python_provider = 0

" Language
let g:vimtex_compiler_method = 'latexrun'
let g:vimtex_view_method = 'zathura'
"let g:semshi#excluded_hl_groups = [ 'local', 'unresolved' ]
let g:OmniSharp_server_use_mono = 1

" Gutter Configuration
"let g:signify_sign_add = '▐'
"let g:signify_sign_change = '▐'
"let g:gitgutter_sign_removed = '▁'
"let g:gitgutter_sign_removed_first_line = '▔'
"let g:gitgutter_sign_removed_above_and_below = '🮀'
"let g:gitgutter_sign_modified_removed = '▁▐'

" Autocomplete configuration
let g:coc_global_extensions = [
\   'coc-snippets',
\   'coc-pairs',
\   'coc-tsserver',
\   'coc-prettier',
\   'coc-clangd',
\   'coc-sh',
\   'coc-python',
\   'coc-html',
\   'coc-css',
\   'coc-eslint',
\   'coc-json',
\   'coc-rls',
\   'coc-discord-neovim',
\   'coc-explorer',
\   'coc-prettier',
\   'coc-vetur'
\]

highlight CocErrorHighlight ctermfg=1

" Nvim Tree
let g:nvim_tree_indent_markers = 1

" Sneak Configuration
let g:sneak#label = 1
let g:sneak#s_next = 0
let g:sneak#prompt = 'sneak>'
let g:sneak#use_ic_scs = 1
let g:EasyMotion_smartcase = 1

"let mapleader=" "
map <space> <leader>
map <S-Down> <C-E>
map <S-Up> <C-Y>
map <ScrollWheelUp> 3<C-Y>
map <ScrollWheelDown> 3<C-E>
map <ScrollWheelLeft> 3zh
map <ScrollWheelRight> 3zl

" Editor shortcuts
map <C-s> :w<CR>

nmap <silent> <C-/> :noh<CR>
noremap <silent> ZW <cmd>BD<CR>
noremap <silent> ZT :enew<CR>
noremap <silent> <space><space> :Telescope buffers<CR>
nmap <C-l> 22zl
nmap <C-h> 22zh

" Remappings
nmap ; :
nnoremap Y yy
noremap <silent> j gj
noremap <silent> k gk
"inoremap jj <Esc>
nnoremap Q gqq
nnoremap <silent> <leader>rr :source $NVIM/init.vim<CR>
nnoremap <silent> <leader>pc :lua require('packer').compile() <CR>
nnoremap <silent> <leader>pu :lua require('packer').sync()<CR>
nnoremap <silent> <leader>pi :lua require('packer').install()<CR>
nnoremap <silent> <leader>fr :lua require('telescope.builtin').oldfiles()<CR>
nnoremap <silent> <leader>e :enew<CR>

" Emacs and standard editors insert bindings
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-h> <C-w>
inoremap <C-BS> <C-w>
inoremap <C-k> <C-o>dd
" Window shortctus
nmap <silent> <leader>wh <C-w>h
nmap <silent> <leader>wj <C-w>j
nmap <silent> <leader>wk <C-w>k
nmap <silent> <leader>wl <C-w>l
nmap <silent> <leader>wq <C-w>q

" Buffer shortcuts
map <silent> <leader>bd <cmd>bdelete<CR>

" Plugin Shortcuts
map <silent> <leader>t :Neotree toggle<CR>
map <silent> <leader>h :CocCommand clangd.switchSourceHeader<CR>
map <silent> <leader>H :call SynStack()<CR>
map <silent> <leader>fp :lua require('telescope-config').search_config_dir()<CR>
map <silent> <leader>ff :lua require('telescope-config').fd_dir()<CR>
map <silent> <leader>. :Telescope file_browser<CR>
nmap <silent> <leader>gg :Neogit<CR>
map <silent> <leader>om :Himalaya<CR>

" Emacs Enlightenment
map <silent> <M-x> :Telescope<CR>

" Snippets
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

" There is a VS Code extension that runs a hidden instance of neovim for
" editing, and these keys may mess up the hidden buffers.
if !exists("g:vscode")
    nnoremap <silent> <Right> :BufferNext<CR>
    nnoremap <silent> <Left> :BufferPrevious<CR>
    nnoremap <silent> <S-Right> :BufferMoveNext<CR>
    nnoremap <silent> <S-Left> :BufferMovePrevious<CR>
endif

" Autocommands
autocmd BufWrite *.tex VimtexCompile
autocmd InsertEnter * set conceallevel=0
autocmd InsertLeave * set conceallevel=1
autocmd TextYankPost * lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })

set mouse=a

" Functions
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" This file is automatically generated by the colorscheme picker
source /var/tmp/colorscheme.vim

filetype off                  " required

filetype plugin indent on    " required

syntax on
