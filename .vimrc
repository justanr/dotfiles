filetype off
                                                                              
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

set nocompatible
set t_Co=256
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

"Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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
let g:pymode_options_max_line_length = 99

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignored files for nerdtree
let NERDTreeShowHidden=1
nnoremap ntt :NERDTreeToggle<CR>

set colorcolumn=99

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

noremap <silent> <Plug>AirlineTablineRefresh :set mod!<CR>
nnoremap <F12> :!tox<CR>
nnoremap <F5> :GundoToggle<CR>

autocmd VimEnter * NERDTreeToggle
let mapleader = "\<tab>"
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
set foldmethod=syntax
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"
