set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

syntax on

let mapleader = ','
tnoremap <Esc> <C-\><C-n>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
noremap <leader>y :Neoformat<CR>
vnoremap <leader>y :Neoformat 'full'<CR>


let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_history_log_output = 1
let g:ale_linters = {'typescript': ['tslint', 'tsserver', 'typecheck']}
let g:ale_sign_column_always = 1
let g:deoplete#enable_at_startup = 1
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
let g:neoformat_rust_rustfmt = {
            \ 'exe': 'rustup',
            \ 'stdin': 1,
            \ 'args': [
            \   'run',
            \   'rustfmt'
            \   ]
            \}
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_run_all_formatters = 1
let g:neoformat_verbose = 0
let g:Omnisharp_server_type = 'roslyn'
let g:Omnisharp_server_type = 'v1'
let g:python3_host_prog = '/home/anr/.virtualenvs/neovim/bin/python'
let g:python_host_prog = '/home/anr/.virtualenvs/neovim2/bin/python'

if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
endif

if executable('ag')
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
        let g:ctrlp_use_caching = 0
        set grepprg=ag\ --nogroup\ --nocolor
        command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
        nnoremap \ :Ag<SPACE>
endif

augroup FiletypeGroup
        autocmd!
        au BufRead,BufNewFile *.jsx set filetype=javascript.jsx
        au BufRead,BufNewFile *.tsx set filetype=typescript.tsx
augroup END

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 || pclose || endif
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

set guicursor=
set autoread
