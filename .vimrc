filetype off
execute pathogen#infect()

filetype plugin indent on
syntax on
colorscheme desert

set nocompatible
set noshowmode
set incsearch
set ignorecase
set smartcase
set scrolloff=2
set wildmode=list:longest
set autoindent
set backspace=indent,eol,start
set expandtab
set number
set cursorline
set splitbelow
set splitright
set foldmethod=syntax
set colorcolumn=99

"Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
nnoremap ntt :NERDTreeToggle<CR>
noremap <silent> <Plug>AirlineTablineRefresh :set mod!<CR>
autocmd VimEnter * NERDTreeToggle


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

let g:javascript_conceal_arrow_function = "⇒"
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

let NERDTreeIgnore=['\.pyc$', '\~$', '\.git$', '\.tox', '\.cache', '\.sw[a-z]$', 'node_modules']
let NERDTreeShowHidden=1

let g:solarized_termcolors=256
