
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

tnoremap <Esc> <C-\><C-n>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_column_always = 1
let g:deoplete#enable_at_startup = 1
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
augroup END

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 || pclose || endif
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
