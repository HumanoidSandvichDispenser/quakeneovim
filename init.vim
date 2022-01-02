set nocompatible              " be iMproved, required

filetype off                  " required

filetype plugin indent on    " required

lua require("plugins") -- packer plugins

set ruler
set number
set showcmd
set encoding=utf-8
set laststatus=0 " This will be set to 2 before feline is loaded
set expandtab
set tabstop=4
set shiftwidth=4
set noshowmode
set linebreak
set breakindent
set timeoutlen=250
set hidden
set clipboard^=unnamed,unnamedplus
set termguicolors
set cursorline
set guifont="Iosevka Sandvich:h11"
set list lcs=tab:▏\ 
set fillchars+=eob:*

syntax on

let g:loaded_python_provider = 0

" Language
"let g:vim_markdown_conceal_code_blocks = 1
"let g:vim_markdown_folding_disabled = 1
"let g:vim_markdown_conceal_code_blocks = 0
"let g:vim_markdown_folding_disabled = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_class_scope_highlight = 1
"let g:cpp_class_decl_highlight = 1
"let g:cpp_concepts_highlight = 1
let g:vimtex_compiler_method = 'latexmk'
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

nmap <silent> <C-/> :noh<CR>
noremap <silent> ZW <cmd>BD<CR>
noremap <silent> ZT :enew<CR>
noremap <silent> <Esc><Esc> :Alpha<CR>

" Remappings
nmap ; :
nnoremap Y yy
noremap <silent> j gj
noremap <silent> k gk
inoremap jj <Esc>
nnoremap Q gqq

" Emacs and standard editors insert bindings
imap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-h> <C-w>

" Plugin Shortcuts
map <silent> <leader>e :CocCommand explorer<CR>
map <silent> <leader>f :Files<CR>
map <silent> <leader>t :NvimTreeToggle<CR>
map <silent> <leader>h :CocCommand clangd.switchSourceHeader<CR>

" ShowDocumentation includes both native nvim and LSP documentation
"nnoremap <silent> K :call ShowDocumentation()<CR>
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

"inoremap <silent><expr> <Tab>
"\   pumvisible() ? "\<C-n>" :
"\   coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"\   <SID>check_back_space() ? "\<TAB>" :
"\   coc#refresh()
"let g:coc_snippet_next = '<tab>'

" The following keys will be mapped to their normal function unless a pmenu is
" visible; if so, map it to previous and next items in the pmenu
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <silent> <Tab> <cmd>lua require("lsp.cmp").next(true, "<Tab>")<CR>
"inoremap <silent> <S-Tab> <cmd>lua require("lsp.cmp").next(false, "<S-Tab>")<CR>
"inoremap <silent> <CR> <cmd>lua require("lsp.cmp").complete()<CR>
"inoremap <expr> <CR> pumvisible() ? "<cmd>call <SID>complete()<CR>" : "\<CR>"

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

" This file is automatically generated by the colorscheme picker
source /var/tmp/colorscheme.vim
