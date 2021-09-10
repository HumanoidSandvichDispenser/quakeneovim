set nocompatible              " be iMproved, required

filetype off                  " required

call plug#begin()
" ALL PLUGINS

" Themes
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'easysid/mod8.vim'
Plug 'franbach/miramare'

" Templates for new files
Plug 'aperezdc/vim-template'

" Show indents
Plug 'lukas-reineke/indent-blankline.nvim'

" Project drawer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-tree.lua'

" Status line
"Plug 'hoob3rt/lualine.nvim'
Plug 'glepnir/galaxyline.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'qpkorr/vim-bufkill' " Kill buffer without removing split

" Git
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'christoomey/vim-conflicted'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Quramy/tsuquyomi'
Plug 'williamboman/vim-import-ts'

" Snippets
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Auto tabbing / Alignment
Plug 'godlygeek/tabular'

" Language Support
let g:polyglot_disabled = [ 'python', 'py', 'vimrc', 'sh', 'js', 'json', 'ts' ] " Semshi has better support for python files
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'numirias/semshi'
Plug 'moll/vim-node'
Plug 'rafcamlet/coc-nvim-lua' " Nvim lua support for CoC
Plug 'OmniSharp/omnisharp-vim' " Omnisharp (C#)

" Other Utilities
Plug 'ryanoasis/vim-devicons' " Icons
Plug 'kyazdani42/nvim-web-devicons' " Colored icons
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger' " Debugger
"Plug 'mhinz/vim-startify' " Startup screen
Plug 'goolord/alpha-nvim'
Plug 'https://github.com/JMcKiern/vim-shoot', { 'do': '\"./install.py\" geckodriver' } " Code screenshotter
Plug 'justinmk/vim-sneak' " Sneak mode
Plug 'chrisbra/Colorizer'

call plug#end()

filetype plugin indent on    " required

"source $DOTFILES/statusline.nvim

set ruler
set number
set showcmd
set encoding=utf-8
set laststatus=2
set expandtab
set tabstop=4
set shiftwidth=4
set noshowmode
set linebreak
set breakindent
set timeoutlen=250
set hidden
set clipboard^=unnamed,unnamedplus
set title
set titlestring="[VIM] %t"
set termguicolors
set cursorline
set guifont="Iosevka Sandvich:h11"
set list lcs=tab:▏\ 
set fillchars+=eob:*
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{noscrollbar#statusline()}

" Syntax highlighting
syntax on

let g:gruvbox_sign_column = "bg0"
let g:gruvbox_italicize_comments = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_invert_selection = 0

let g:loaded_python_provider = 0

" Indent guides
call luaeval('require("indent-line-config").init()')

" Language
let g:vim_markdown_conceal_code_blocks = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1
let g:vimtex_compiler_method = 'latexmk'
let g:semshi#excluded_hl_groups = [ 'local', 'unresolved' ]

" Gutter Configuration
let g:gitgutter_sign_added = '▐'
let g:gitgutter_sign_modified = '▐'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_removed_above_and_below = '🮀'
let g:gitgutter_sign_modified_removed = '▁▐'

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
\   'coc-lua',
\   'coc-prettier'
\]

highlight CocErrorHighlight ctermfg=1

" Lightline configuration
"source $DOTFILES/lightline-config.vim
source $DOTFILES/barbar-config.vim

" Startify
let g:startify_bookmarks = [
\	{ 'v': '$DOTFILES/.config/nvim/init.vim' },
\	{ 'z': '$DOTFILES/.zshrc' },
\	{ 's': '$HOME/.config/sxhkd/sxhkdrc' },
\	{ 'b': '$HOME/.config/bspwm/bspwmrc' },
\	{ 'd': '$HOME/.config/dunst/dunstrc' },
\	{ 'f': '$HOME/.config/vifm/vifmrc' },
\   { 'x': '$HOME/.Xresources' },
\]
"let s:startify_ascii_header = [
"\   '                                        ▟▙            ',
"\   '                                        ▝▘            ',
"\   '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
"\   '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
"\   '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
"\   '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
"\   '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
"\   '',
"\]
"let g:startify_custom_header = startify#center(s:startify_ascii_header)
""startify#fortune#cowsay('', '─','│','╭','╮','╯','╰')
"let g:webdevicons_enable_startify = 1
"let g:startify_padding_left = 8
"let g:startify_files_number = 5
"let g:startify_center = 72
let g:startify_lists = [
\   { 'type': 'bookmarks', 'header': ['          Bookmarks'] },
\   { 'type': 'sessions',  'header': ['          Sessions' ] },
\   { 'type': 'files',     'header': ['          Recent Files'] },
\]
"call luaeval('require("startify-config")')
call luaeval('require("alpha-config").init()')

" Nvim Tree
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_lsp_diagnostics = 1
call luaeval('require("nvim-tree-config")')

" Sneak Configuration
let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#prompt = 'sneak>'

let mapleader=" "
map <S-Down> <C-E>
map <S-Up> <C-Y>
map <ScrollWheelUp> 3<C-Y>
map <ScrollWheelDown> 3<C-E>
map <ScrollWheelLeft> 3zh
map <ScrollWheelRight> 3zl

" Editor shortcuts
map <C-s> :w<CR>
map <silent> ` :VBGtoggleBreakpointThisLine<CR>
map <silent> <S-`> :VBGclearBreakpints<CR>
"nmap <silent> <S-Left>  :tabmove -1<CR>
"nmap <silent> <S-Right> :tabmove +1<CR>

nmap <silent> <C-/> :noh<CR>
"noremap <C-q> <C-w><C-w>
noremap <silent> ZW :call CloseBuffer()<CR>
noremap <silent> ZT :enew<CR>
noremap <silent> <Esc><Esc> :Alpha<CR>

" Remappings
nmap ; :
noremap <silent> j gj
noremap <silent> k gk
inoremap jj <Esc>
nnoremap Q gqq

" Emacs and standard editors insert bindings
imap <C-a> <C-o>I
inoremap <C-e> <C-o>A
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-n> <C-o>j
inoremap <C-p> <C-o>k
inoremap <C-h> <C-w>

" Plugin Shortcuts
map <silent> <C-n> :NERDTreeTabsToggle<CR>
map <silent> <leader>e :CocCommand explorer<CR>
map <silent> <leader>f :Files<CR>
map <silent> <leader>t :NvimTreeToggle<CR>

nnoremap <silent> K :call ShowDocumentation()<CR>

if !exists('g:vscode')
    nnoremap <silent> <Right> :BufferNext<CR>
    nnoremap <silent> <Left> :BufferPrevious<CR>
    nnoremap <silent> <S-Right> :BufferMoveNext<CR>
    nnoremap <silent> <S-Left> :BufferMovePrevious<CR>
endif

inoremap <silent><expr> <Tab>
\   pumvisible() ? "\<C-n>" :
\   coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
\   <SID>check_back_space() ? "\<TAB>" :
\   coc#refresh()
let g:coc_snippet_next = '<tab>'

inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Autocommands
autocmd FileType nerdtree noremap <buffer> <Left> <nop>
autocmd FileType nerdtree noremap <buffer> <Right> <nop>
autocmd FileType python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd FileType c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd FileType cpp nnoremap <F5> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd FileType tex nnoremap <F5> :VimtexCompile<CR>
autocmd BufWrite *.tex VimtexCompile
autocmd InsertEnter * set conceallevel=0
autocmd InsertLeave * set conceallevel=1
"autocmd ColorScheme * call HighlightOverrides()
autocmd User Startified setlocal cursorline

set mouse=a

"if !has('gui_running')
"   set t_Co=256
"endif

" Functions
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! CloseBuffer()
    BD " Delete buffer, preserve windows
    call bufferline#update() " Update the bufferline
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

" Highlight Overrides
function! HighlightOverrides()
    call luaeval('require("highlight-overrides").highlight_overrides()')
    call BarbarHighlight()
endfunction

function! SetColorscheme(scheme)
    execute 'colorscheme ' . a:scheme
    call HighlightOverrides()
endfunction

call luaeval('require("galaxyline-config")')
"call luaeval('require("lualine-config").init()')

" Load Configs
source ~/local.vimrc
source /var/tmp/colorscheme.vim
