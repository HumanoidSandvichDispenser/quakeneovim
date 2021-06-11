set nocompatible              " be iMproved, required

filetype off                  " required

call plug#begin()
" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

" Templates for new files
Plug 'aperezdc/vim-template'

" Autocomplete (, [, {, ", etc.
Plug 'Raimondi/delimitMate'

" Show indents
Plug 'Yggdroot/indentLine'

" Project drawer
Plug 'scrooloose/nerdtree'
Plug 'Nopik/vim-nerdtree-direnter'
Plug 'jistr/vim-nerdtree-tabs'

" Status line
Plug 'itchyny/lightline.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-conflicted'

" Autocomplete
Plug 'valloric/youcompleteme'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Auto tabbing / Alignment
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'

" Calculator
Plug 'gregsexton/VimCalc'

" Discord Rich Presence
Plug 'vbe0201/vimdiscord'

" Language Support
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'

" Search StackOverflow
Plug 'hienvd/vim-stackoverflow'

" Other Utilities
Plug 'ryanoasis/vim-devicons' " Icons for NERDTree
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger' " Debugger

call plug#end()

filetype plugin indent on    " required

set ruler
set number
set showcmd
set encoding=utf-8
set laststatus=2
set tabstop=4
set shiftwidth=4
set noshowmode
set linebreak
set breakindent
set timeoutlen=250
set hidden
set clipboard=unnamedplus
set title
set titlestring="[VIM] %t"
set termguicolors

highlight Pmenu ctermfg=15 ctermbg=8
highlight PmenuSel ctermfg=14 ctermbg=NONE
highlight function ctermfg=Yellow
highlight Comment cterm=italic
syntax on

colorscheme gruvbox

let g:loaded_python_provider = 0

" UltiSnips
let g:UltiSnipsExpandTrigger = "<c-f>"
let g:UltiSnipsJumpForwardTrigger="<c-x>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:indentLine_color_term = 8
let delimitMate_expand_cr = 1
let NERDTreeShowHidden = 1
let NERDTreeMapOpenInTab='<ENTER>'

" Language
let g:vim_markdown_conceal_code_blocks = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1
let g:vimtex_compiler_method = 'latexrun'

" YCM
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filetype_blacklist={'notes': 1, 'unite': 1, 'tagbar': 1, 'pandoc': 1, 'qf': 1, 'vimwiki': 1, 'text': 1, 'infolog': 1, 'mail': 1}

" Lightline Config
let g:lightline = { 
\   'colorscheme': 'gruvbox',
\	'active': {
\   'left':[ [ 'mode', 'paste' ],
\       [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] 
\	},
\   'component_function': {
\       'gitbranch': 'fugitive#head',
\   }
\}
let g:lightline.separator = {
	\   'left': '', 'right': ''
\}
let g:lightline.subseparator = {
	\   'left': '', 'right': ''
\}

" Scrolling
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
nmap <S-Left>  :tabmove -1<CR>
nmap <S-Right> :tabmove +1<CR>
nmap <silent> <C-/> :noh<CR>
noremap <C-q> <C-w><C-w>
noremap <C-w> :tabclose<CR>
noremap <C-t> :tabnew<CR>

" Remappings
nmap ; :
noremap <silent> j gj
noremap <silent> k gk
inoremap jj <Esc>

" Emacs
imap <C-a> <Home>
inoremap <C-e> <End>

" Plugin Shortcuts
map <C-n> :NERDTreeTabsToggle<CR>
nnoremap m :Goyo 75%x100%-4<CR>
nnoremap M :Goyo!<CR>
nnoremap <C-p> :YcmShowDetailedDiagnostic<CR>
nnoremap <Left> :tabprevious<CR>
nnoremap <Right> :tabnext<CR>

" Autocommands
autocmd FileType nerdtree noremap <buffer> <Left> <nop>
autocmd FileType nerdtree noremap <buffer> <Right> <nop>
autocmd FileType python nnoremap <F7> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd FileType c nnoremap <F7> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd FileType cpp nnoremap <F7> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd FileType tex nnoremap <F7> :VimtexCompile<CR>
autocmd InsertEnter * set conceallevel=0
autocmd InsertLeave * set conceallevel=1

vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

set mouse=a

"if !has('gui_running')
"	set t_Co=256
"endif

source ~/local.vimrc
