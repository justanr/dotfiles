filetype off
                                                                              
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

set nocompatible
set t_Co=16

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

au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwdith=4
    \set expandtab
    \set autoindent
    \set fileformat=unix


au BufNewFile,BufRead *.js, *.html, *.css,
    \set tabstop=2
    \set softtabstop=2
    \set shiftwidth=2



"python with venv support

py << EOF
import os
import sys
if "VIRTUAL_ENV" in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

syntax on
set background="dark"
let g:solarized_termcolors=256
colorscheme solarized
filetype plugin on

let g:pymode_lint_checkers = ['pep8', 'pyflakes']
let g:pymode_rope = 0
let g:pymode_lint_ignore = "E0501,E0401"
let g:pymode_options_max_line_length = 85

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignored files for nerdtree

set colorcolumn=85

nnoremap <F12> :!tox<CR>
