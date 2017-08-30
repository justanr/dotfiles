filetype off
execute pathogen#infect()
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
set foldmethod=syntax

"Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

colorscheme desert 
syntax on
let g:solarized_termcolors=256
filetype plugin on


"let g:pymode_python = 'python3'
"let g:pymode_lint_checkers = ['pep8', 'pyflakes']
"let g:pymode_rope = 0
"let g:pymode_lint_ignore = "E0501,E0401"
"let g:pymode_options_max_line_length = 99


let g:ycm_rust_src_path = "/home/anr/.cargo/bin/rustc"
"let g:ycm_python_binary_path = "python"


let NERDTreeIgnore=['\.pyc$', '\~$', '\.git$', '\.tox', '\.cache', '\.sw[a-z]$', 'node_modules']
let NERDTreeShowHidden=1
nnoremap ntt :NERDTreeToggle<CR>

set colorcolumn=99

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

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

autocmd VimEnter * NERDTreeToggle
let mapleader = "\<tab>"
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
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
