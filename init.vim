set guicursor=
set termguicolors
let mapleader = ','
tnoremap <Esc> <C-\><C-n>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
let g:python3_host_prog = '/home/anr/.virtualenvs/neovim/bin/python3.6'
let g:python_host_prog = '/home/anr/.virtualenvs/neovim2/bin/python'

set nocompatible
set noshowmode
set incsearch
set ignorecase
set smartcase
set scrolloff=2
set wildmode=longest,list
set autoindent
set backspace=indent,eol,start
set expandtab
set number
set cursorline
set splitbelow
set splitright
set foldmethod=syntax
set hidden

call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kien/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim'
Plug 'racer-rust/vim-racer'
Plug 'zchee/deoplete-jedi'
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
call plug#end()

colorscheme molokai

syntax on
filetype plugin on

let NERDTreeIgnore=['\.pyc$', '\~$', '\.git$', '\.tox$', '\.cache$', '\.sw[a-z]$', 'node_modules', 'gmon.out']
let NERDTreeShowHidden=1
nnoremap ntt :NERDTreeToggle<CR>
autocmd VimEnter * NERDTreeToggle


let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%severity%] [%linter%] %s'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_history_log_output = 1
let g:ale_linters = {
                        \'typescript': ['tslint', 'tsserver', 'typecheck'],
                        \'python': ['flake8', 'mypy'],
                        \'rust': ['rustc', 'rls']
                        \}
let g:ale_sign_column_always = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary = '/home/anr/.cargo/bin/racer'
let g:deoplete#sources#rust#src='/home/anr/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#show_duplicates=1
let g:deoplete#sources#rust#disable_keymap=1
let g:deoplete#source#rust#documentation_max_height=20

let g:highlighter#auto_update = 2
let g:highlighter#project_root_signs = ['.git']

let g:neoformat_python_yapf = {
                        \ 'exe': '/home/anr/.virtualenvs/neovim/bin/yapf',
                        \ 'args': ['--style', '~/.style.yapf'],
                        \ }
let g:neoformat_python_isort = {
                        \ 'exe': '/home/anr/.virtualenvs/neovim/bin/isort',
                        \ 'args': ['-', '--quiet'],
                        \ 'stdin': 1
                        \ }
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
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_html = ['htmlbeautify']
let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_run_all_formatters = 1
let g:neoformat_verbose = 0

noremap <leader>y :Neoformat<CR>
vnoremap <leader>y :Neoformat 'full'<CR>

if executable('rg')
        set grepprg=rg\ --color=never
        let g:ctrlp_user_command = 'rg %s --files --color=never --smartcase --glob "" --hidden'
        let g:ctrlp_use_caching = 0
        command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
        nnoremap \ :Rg<SPACE>
endif

augroup FiletypeGroup
        autocmd!
        au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
        au BufRead,BufNewFile *.tsx set filetype=typescript.tsx
augroup END

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 || pclose || endif
