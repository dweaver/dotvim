call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

let mapleader = ","

" Command-T mappings
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR> noremap <leader>m <Esc>:CommandTBuffer<CR>
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'


filetype plugin on
filetype indent on

let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" Solarized color scheme
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', '\.o$']

" Make the command line two lines high and change the statusline display to
" something that looks useful.
set cmdheight=2
set laststatus=2
set statusline=[%l,%v\ %P%M][CWD:\ %{CWD()}][FILE:\ %f]\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}\ %#warningmsg#%{SyntasticStatuslineFlag()}%* 
set showcmd 
set showmode
set number

function! CWD()
    let curdir = substitute(getcwd(), '/home/danw', "~/", "g")
    return curdir
endfunction

set ignorecase

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Shortcuts for navigating (<F7>, <F8>) and creating (<F6>, ',n') tabs
noremap <F7> :tabp<CR>
noremap <F8> :tabn<CR>
noremap <F6> :tabe 
noremap <Leader>n :tabe <C-R>=expand("%:p:h") . "/" <CR>


" Paste over selection without replacing contents of register
" I haven't found how to hide this function (yet)
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

