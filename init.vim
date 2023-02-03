"Leader {{{
let mapleader = ','
"}}}

"Python interpreter {{{
let home = expand('~')
let py3path = home . '/.venvs/neovim/bin/'
let py3interp = py3path . 'python'
let g:python3_host_prog = py3interp
"}}}

" Settings {{{
set autoindent
set autoread
set backspace=indent,eol,start
set cmdheight=2
set colorcolumn=79
set cursorline
set dictionary+=/usr/share/dict/words
set dictionary?
set encoding=utf-8
set expandtab
set foldlevel=99
set foldmethod=syntax
set guicursor=
set hidden
set hlsearch
set ignorecase
set inccommand=nosplit
set incsearch
set laststatus=2
set nocompatible
set noshowmode
set number
set path+=**
set scrolloff=2
set shiftwidth=4
set shortmess+=c
set showcmd
set signcolumn=yes
set smartcase
set smarttab
set splitbelow
set splitright
set t_Co=256
set tabstop=4
set termguicolors
set updatetime=300
set wildmenu
set wildmode=longest,list
set mouse=
set ffs=unix
syntax on
filetype plugin on
"}}}

" Terminal {{{
tnoremap <Esc> <C-\><C-n>
" }}}

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'cespare/vim-toml'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mhartington/nvim-typescript', {'do': 'sh install.sh'}
Plug 'mhinz/vim-grepper'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'preservim/tagbar'
Plug 'preservim/vim-markdown'
Plug 'puremourning/vimspector'
Plug 'rust-lang/rust.vim'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shougo/echodoc'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'yssl/QFEnter'
Plug 'vim-python/python-syntax'
Plug 'arzg/vim-sh'
Plug 'airblade/vim-gitgutter'
Plug 'kana/vim-submode'
Plug 'tpope/vim-surround'
Plug 'mustache/vim-mustache-handlebars'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-abolish'
Plug 'wesQ3/vim-windowswap'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'inkarkat/vim-ingo-library'
call plug#end()
" }}}

"Colorscheme {{{
colorscheme molokai
"}}}

" Local functions {{{
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! ProjectTab(projectDir) abort
    tabnew
    execute 'tcd' a:projectDir
    NERDTreeToggle
endfunction

function! ActionLint() abort
    if executable('actionlint')
        cgete system('actionlint -oneline')
        copen
    endif
endfunction

" }}}
" Commands {{{
command! -nargs=1 -complete=file ProjectTab call ProjectTab(<f-args>)
command! ActionLint call ActionLint()
" }}}

" Keymaps {{{
" Insert {{{
imap <Left> <Nop>
imap <Right> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>
inoremap <Insert> <Nop>
inoremap <Home> <Nop>
inoremap <End> <Nop>
inoremap <Del> <Nop>
inoremap <C-h> <Left>
imap <C-j> <C-o>gj
imap <C-k> <C-o>gk
inoremap <C-l> <Right>
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#_select_confirm() : "\<TAB>"
"}}}
" Normal {{{
nnoremap <leader>qf :call ToggleQuickFix()<CR><C-W>p
nnoremap [q :cn<CR>
nnoremap ]q :cp<CR>
nnoremap [Q :clast<CR>
nnoremap ]Q :crewind<CR>
nmap <leader>T :TagbarToggle<CR>
nmap <Leader>di <Plug>VimspectorBalloonEval
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>de :VimspectorEval
nmap <leader>do :VimspectorShowOutput
nmap <leader>dw :VimspectorWatch
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>f <Plug>(coc-format)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>gd :call CocAction('jumpDefinition', 'edit')<CR>
nmap <silent> <leader>gi :call CocAction('jumpImplementation', 'edit')<CR>
nmap <silent> <leader>gr :call CocAction('jumpReferences', 'edit')<CR>
nmap <silent> <leader>gy :call CocAction('jumpTypeDefinition', 'edit')<CR>
nmap <silent> [n <Plug>(coc-diagnostic-prev>
nmap <silent> ]n <Plug>(coc-diagnostic-next>
nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gi :call CocAction('jumpImplementation', 'vsplit')<CR>
nmap <silent> gr :call CocAction('jumpReferences', 'vsplit')<CR>
nmap <silent> gy :call CocAction('jumpTypeDefinition', 'vsplit')<CR>
" I'm sure ZZ is useful to someone but not me
nnoremap ZZ <Nop>
nnoremap <space> za
nnoremap <C-j> gT
nnoremap <C-k> gt
nnoremap <C-t> :tabnew<CR>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>
nnoremap <Insert> <Nop>
nnoremap <Home> <Nop>
nnoremap <End> <Nop>
nnoremap <Del> <Nop>
nnoremap <leader>gq gqip
nnoremap <silent> <leader><space> :noh<CR>
nnoremap <silent> <space>a :<C-u>CocList diagnostics<CR>
nnoremap <silent> <space>c :<C-u>CocList commands<CR>
nnoremap <silent> <space>e :<C-u>CocList extensions<CR>
nnoremap <silent> <space>f <Plug>(coc-fix-current)
nnoremap <silent> <space>j :<C-u>CocNext<CR>
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
nnoremap <silent> <space>o :<C-u>CocList outline<CR>
nnoremap <silent> <space>p :<C-u>CocListResume<CR>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<CR>
nnoremap <silent> U :call <SID>show_documentations()<CR>
nnoremap H ^
nnoremap J }
nnoremap K {
nnoremap L $
nnoremap gj j
nnoremap gk k
nnoremap j gj
nnoremap k gk
nnoremap ntt :NERDTreeToggle<CR>
nnoremap <leader>y :Neoformat<CR>
nnoremap <leader>J J
"}}}
"Visual {{{
vnoremap <leader>y :Neoformat 'full'<CR>
xmap <Leader>di <Plug>VimspectorBalloonEval
vmap <leader>f <Plug>(coc-format-selected)
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
"}}}
"Command {{{
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>
cnoremap <PageUp> <Nop>
cnoremap <PageDown> <Nop>
cnoremap <Insert> <Nop>
cnoremap <Home> <Nop>
cnoremap <End> <Nop>
"}}}
"}}}

" NERDTree {{{
let NERDTreeIgnore=['\.pyc$', '\~$', '\.git$', '\.tox$', '\.cache$', '\.sw[a-z]$', 'node_modules', 'gmon.out', '.mypy_cache', '.pytest_cache', 'tags', '__pycache__']
let NERDTreeShowHidden=1
let NERDTreeUseTCD=1
let NERDTreeShowLineNumbers=1
let NERDTreeAutoDeleteBuffer=1
" }}}

"neoformat {{{
let g:neoformat_python_isort = {
                        \ 'exe': py3path . 'isort',
                        \ 'args': ['-', '--quiet'],
                        \ 'stdin': 1
                        \ }
let g:neoformat_python_black = {
            \ 'exe': py3path . 'black',
            \ 'args': ['-', '2>/dev/null'],
            \ 'stdin': 1
            \}
let g:neoformat_javascript_prettier = {
                        \ 'exe': 'prettier',
                        \ 'stdin': 1,
                        \ 'args': [
                        \       '--stdin',
                        \       '--single-quote',
                        \       '--no-bracket-spacing',
                        \       '--trailing-comma', 'none'
                        \]
                        \ }
let g:neoformat_typescript_prettier = {
                        \ 'exe': 'prettier',
                        \ 'stdin': 1,
                        \ 'args': [
                        \       '--stdin',
                        \       '--single-quote',
                        \       '--trailing-comma', 'none',
                        \       '--parser', 'typescript'
                        \]
                        \ }
let g:neoformat_yaml_pyaml = {
            \ 'exe': py3interp,
            \ 'args': ['-m', 'pyaml'],
            \ 'stdin': 1,
            \}
let g:neoformat_yaml_yamlfmt = {
            \'exe': 'yamlfmt',
            \'args': ['-'],
            \'stdin':1,
            \}
let g:neoformat_enabled_python = ['isort', 'black']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_html = ['htmlbeautify']
let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_enabled_yaml = ['yamlfmt']
let g:neoformat_run_all_formatters = 1
let g:neoformat_verbose = 0
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
"}}}

" CtrlP/Vimgrepper Ripgrep {{{
let g:ctrlp_extensions = ['line', 'buffertag', 'tag', 'dir']
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_show_hidden = 1
if executable('rg')
        let g:ctrlp_user_command = 'rg %s --files --color=never --smart-case --glob "" --hidden -g''!.git/*'' -g''!.worktree/*'' '
        let g:ctrlp_use_caching = 0
        nnoremap \ :GrepperRg<SPACE>
else
    nnoremap \ :Grepper -tool grep<SPACE>
endif
"}}}

" Autocommands {{{
if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    augroup Fugitive
        au FileType fugitive wincmd J
    augroup END

    augroup Dockerfile
        autocmd!
        au BufRead,BufNewFile Dockerfile* set filetype=Dockerfile
    augroup END

    augroup Typescript
        autocmd!
        au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
        au BufRead,BufNewFile *.tsx set filetype=typescript.tsx
    augroup END

    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup END

    augroup Go
        autocmd!
        au FileType go nmap <leader>r <Plug>(go-run)
        au FileType go nmap <leader>b <Plug>(go-build)
        au FileType go nmap <leader>t :GoTest!<CR>
        au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
        au FileType go nmap <leader>e <Plug>(go-rename)
        au FileType go iab iferr if err != nil {}<Up>
        au FileType go nmap <Leader>a <Plug>(go-alternate-vertical)
        au FileType go nmap <Leader>i :GoImport!
        au FileType go nmap <Leader>I :GoImportAs!
    augroup END

    augroup Markdown
        autocmd!
        au FileType markdown nmap <leader>toc :Toc<CR>
        au FileType markdown setlocal spell spelllang=en_us
    augroup END

    augroup Quickfix
        autocmd!
        au FileType qf wincmd J
    augroup END

    augroup Nerdtree
        autocmd!
        au VimEnter * NERDTreeToggle
    augroup END

    augroup Help
        autocmd!
        au FileType help set nu
        au FileType help set rnu
    augroup END

    au TabLeave * let g:lasttab = tabpagenr()
    au InsertLeave,CompleteDone * if pumvisible() == 0 || pclose || endif

    augroup InlineSyntax
        autocmd!
        autocmd Syntax * call SyntaxRange#Include('@begin=sh@', '@end=sh@', 'sh', 'NonText')
        autocmd Syntax * call SyntaxRange#Include('@begin=bash@', '@end=bash@', 'bash', 'NonText')
        autocmd Syntax * call SyntaxRange#Include('@begin=js@', '@end=js@', 'javascript', 'NonText')
        autocmd Syntax * call SyntaxRange#Include('@begin=sql@', '@end=sql@','sql', 'NonText')
        autocmd Syntax * call SyntaxRange#Include('@begin=py@', '@end=py@', 'python', 'NonText')
    augroup END
endif
"}}}


" Vimspector {{{
let g:vimspector_base_dir=expand('$HOME/.config/nvim/vimspector')
let g:vimspector_enable_mappings='HUMAN'
let g:vimspector_install_gadgets=['debugpy', 'CodeLLDB', 'vscode-cpptools', 'vscode-go']
"""

"Vim Go {{{
let g:go_def_mapping_enabled = 0
"}}}

"Quickfix {{{
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']
"}}}
"Indents {{{
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_setConceal = 0
"}}}

"Docs {{{
let g:echodoc#enable_at_startup = 1
"}}}

"Gitgutter {{{
let g:gitgutter_map_keys = 0
let g:gitgutter_use_location_list = 1
nnoremap ]h <Plug>(GitGutterNextHunk)
nnoremap [h <Plug>(GitGutterPrevHunk)
nnoremap <Leader>ghs <Plug>(GitGutterStageHunk)
nnoremap <Leader>ghu <Plug>(GitGutterUndoHunk)
nnoremap <Leader>ghp <Plug>(GitGutterPreviewHunk)
"}}}

"Submode {{{
let g:submode_always_show_submode = 1
"Window Submode {{{
" We're taking over the default <C-w> setting. Don't worry we'll do
" our best to put back the default functionality.
call submode#enter_with('window', 'n', '', '<C-w>')

" Note: <C-c> will also get you out to the mode without this mapping.
" Note: <C-[> also behaves as <ESC>
call submode#leave_with('window', 'n', '', '<ESC>')

" Go through every letter
for key in ['a','b','c','d','e','f','g','h','i','j','k','l','m',
\           'n','o','p','q','r','s','t','u','v','w','x','y','z']
  " maps lowercase, uppercase and <C-key>
  call submode#map('window', 'n', '', key, '<C-w>' . key)
  call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
  call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-'.key . '>')
endfor
" Go through symbols. Sadly, '|', not supported in submode plugin.
for key in ['=','_','+','-','<','>']
  call submode#map('window', 'n', '', key, '<C-w>' . key)
endfor

" Old way, just in case.
nnoremap <Leader>w <C-w>
"}}}
"}}}

