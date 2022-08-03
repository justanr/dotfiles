set guicursor=
set termguicolors
let mapleader = ','
let home = expand('~')
tnoremap <Esc> <C-\><C-n>
let py3path = home . '/.venvs/neovim/bin/'
let py3interp = py3path . 'python'
let g:python3_host_prog = py3interp


set t_Co=256
set nocompatible
set noshowmode
set incsearch
set ignorecase
set smartcase
set scrolloff=2
set wildmode=longest,list
set autoindent
set backspace=indent,eol,start
set hlsearch
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set number
set cursorline
set splitbelow
set splitright
set foldmethod=syntax
set hidden
set colorcolumn=79
set autoread
set dictionary?
set dictionary+=/usr/share/dict/words
set inccommand=nosplit

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'dense-analysis/ale'
Plug 'sbdchd/neoformat'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kien/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'flazz/vim-colorschemes'
Plug 'Shougo/deoplete.nvim'
Plug 'racer-rust/vim-racer'
Plug 'zchee/deoplete-jedi'
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'puremourning/vimspector'
Plug 'fatih/vim-go'
Plug 'ekalinin/Dockerfile.vim'
Plug 'yssl/QFEnter'
Plug 'Yggdroot/indentLine'
call plug#end()

nnoremap <silent> <leader><space> :noh<CR>

colorscheme molokai

syntax on
filetype plugin on

let NERDTreeIgnore=['\.pyc$', '\~$', '\.git$', '\.tox$', '\.cache$', '\.sw[a-z]$', 'node_modules', 'gmon.out', '.mypy_cache', '.pytest_cache', 'tags']
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
                        \'rust': ['rustc', 'rls'],
                        \'go': ['gofmt', 'staticcheck', 'golint', 'gobuild']
                        \}
let g:ale_sign_column_always = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#max_list = 10
let g:deoplete#enable_refresh_always = 1
let g:deoplete#sources#rust#racer_binary = home . '/.cargo/bin/racer'
let g:deoplete#sources#rust#src=home . '/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#show_duplicates=1
let g:deoplete#sources#rust#disable_keymap=1
let g:deoplete#source#rust#documentation_max_height=20
let g:deoplete#sources#jedi#python_path=py3interp

let g:highlighter#auto_update = 2
let g:highlighter#project_root_signs = ['.git']

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
let g:neoformat_enabled_python = ['isort', 'black']

let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_html = ['htmlbeautify']
let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_run_all_formatters = 1
let g:neoformat_verbose = 0
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

noremap <leader>y :Neoformat<CR>
vnoremap <leader>y :Neoformat 'full'<CR>

if executable('rg')
        let g:ctrlp_user_command = 'rg %s --files --color=never --smart-case --glob ""'
        let g:ctrlp_use_caching = 0
        nnoremap \ :GrepperRg<SPACE>
        nnoremap K :Grepper -tool rg -cword<CR><CR>
else
    nnoremap \ :Grepper -tool grep<SPACE>
    nnoremap K :Grepper -cword -tool grep<CR><CR>
endif

augroup FiletypeGroup
        autocmd!
        au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
        au BufRead,BufNewFile *.tsx set filetype=typescript.tsx
augroup END

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 || pclose || endif

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <leader>w gqip

packadd termdebug
au BufNewFile,BufRead *.rs let termdebug="rust-dgb"

nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval
let g:vimspector_base_dir=expand('$HOME/.config/nvim/vimspector')
let g:vimspector_enable_mappings='HUMAN'
let g:vimspector_install_gadgets=['debugpy', 'CodeLLDB', 'vscode-cpptools']
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput


" coc settings
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refesh()

nmap <silent> [c <Plug>(coc-diagnostic-prev>
nmap <silent> ]c <Plug>(coc-diagnostic-next>


nmap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gy :call CocAction('jumpTypeDefinition', 'vsplit')<CR>
nmap <silent> gi :call CocAction('jumpImplementation', 'vsplit')<CR>
nmap <silent> gr :call CocAction('jumpReferences', 'vsplit')<CR>
nmap <silent> gd :call CocAction('jumpDefinition', 'edit')<CR>
nmap <silent> gy :call CocAction('jumpTypeDefinition', 'edit')<CR>
nmap <silent> gi :call CocAction('jumpImplementation', 'edit')<CR>
nmap <silent> gr :call CocAction('jumpReferences', 'edit')<CR>

nnoremap <silent> U :call <SID>show_documentations()<CR>
nmap <leader>rn <Plug>(coc-rename)
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
nnoremap <silent> <space>a :<C-u>CocList diagnostics<CR>
nnoremap <silent> <space>e :<C-u>CocList extensions<CR>
nnoremap <silent> <space>c :<C-u>CocList commands<CR>
nnoremap <silent> <space>o :<C-u>CocList outline<CR>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<CR>
nnoremap <silent> <space>j :<C-u>CocNext<CR>
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
nnoremap <silent> <space>p :<C-u>CocListResume<CR>

let g:go_def_mapping_enabled = 0

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <leader>e <Plug>(go-rename)

inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<CR>', '<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_setConceal = 0

