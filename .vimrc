call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

let mapleader = ","

" Command-T mappings
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

filetype plugin on
filetype indent on

let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

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

noremap tn :tabnew<CR>
noremap tj :tabprevious<CR>
noremap tk :tabnext<CR>


