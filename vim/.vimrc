"===============================================================================
" Plugins
"===============================================================================

call plug#begin('~/.vim/bundle')

" Syntax/Language
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'b4b4r07/vim-hcl'
Plug 'chase/vim-ansible-yaml'
Plug 'fatih/vim-go'
Plug 'ledger/vim-ledger'
Plug 'rust-lang/rust.vim'
Plug 'sevko/vim-nand2tetris-syntax'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/applescript.vim'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'Townk/vim-autoclose'
Plug 'dhruvasagar/vim-table-mode'
Plug 'editorconfig/editorconfig-vim'
Plug 'eiginn/netrw' " includes fix for http://paulgorman.org/blog/1400942674
Plug 'godlygeek/tabular'
Plug 'jmcantrell/vim-virtualenv'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vimwiki/vimwiki'

call plug#end()

"===============================================================================
" Lines and whitespace
"===============================================================================

" Tabs
set expandtab     " tabs are spaces
set tabstop=2     " 2-space tab width
set softtabstop=2 " treat expanded tabs as real tabs
set shiftwidth=2  " indent using << and >>

" Line handling
set textwidth=80
set wrap             " wrap lines
set linebreak        " wrap lines at word boundaries
set wrapmargin=0     " don't force text wrapping
set formatoptions=cq " don't automatically break lines at textwidth
set nolist           " list disables linebreak

"===============================================================================
" Appearance
"===============================================================================

colorscheme molokai
if v:version > 703
  " change background past column 80
  let &colorcolumn = join(range(&textwidth + 1, 255), ',')
endif
set cursorline " highlight current line
set number     " line numbers
set t_Co=256   " double rainbow

"===============================================================================
" Behaviour
"===============================================================================

set lazyredraw                 " only redraw when necessary
set modelines=5                " number of modelines to check (OS X default is 0)
set mouse=a                    " enable mouse
set shortmess=I                " ignore intro
set wildmenu                   " tab through filenames
set wildmode=longest,list,full " tab completion
set splitbelow                 " more natural splits
set splitright
set backspace=indent,eol,start " make backspace work as in other applications
set updatetime=250
set viminfo='100,<50,s10,h,n~/.vim/viminfo

" Reset normal/insert mode cursors. DECSCUSR changes apply to the termainl, not
" individual applications. Reset Vim's default cursors to override the ones
" inherited by Bash/readline (~/.inputrc).
" &t_SI: Enter insert mode (blinking pipe).
let &t_SI = "\e[5 q"
" &t_SR: Enter replace mode (blinking underline).
let &t_SR = "\e[3 q"
" &t_EI: Exit insert or replace mode (blinking block).
let &t_EI = "\e[1 q"

"===============================================================================
" Keymaps
"===============================================================================

let mapleader=","
" play nicely with soft-wrapping
map k gk
map j gj
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>s :Scriptify<CR>
nmap <leader>i :Isort<CR>

"===============================================================================
" Plugins
"===============================================================================

" Airline
set laststatus=2
set noshowmode
let g:airline#extensions#whitspace#enabled    = 0
let g:airline#extensions#virtualenv#enabled   = 1
let g:airline#extensions#branch#enabled       = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#virtualenv#enabled   = 1

" vim-go
let g:go_fmt_command         = 'goimports'
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_structs   = 1

" vim-ledger
let g:ledger_bin = 'hledger'

" vim-signify
let g:signify_realtime = 1
let g:signify_vcs_list = ['fossil', 'git', 'hg']
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0

" syntastic
let g:syntastic_sh_shellcheck_args = '-s bash'

"===============================================================================
" Functions
"===============================================================================

" Insert boilerplate for new files.
function! Boilerplate()
  execute '0r ~/.vim/templates/boilerplate.'.expand('%:e')
endfunction

" Insert boilerplate to make a file into a standalone script.
function! Scriptify()
  execute '$r ~/.vim/templates/script.'.expand('%:e')
endfunction

command! -nargs=0 Scriptify call Scriptify()

function! Header(comment, marker, ...)
  let line = substitute(&commentstring, '%s', repeat(a:marker, &textwidth - 1) . "\n", "")
  let message = substitute(&commentstring, '%s', " " . join(a:000, " ") . "\n", "")
  execute "normal! a" . line
  execute "normal! a" . message
  execute "normal! a" . line
endfunction

function! Isort()
  execute "silent !isort " . bufname("%")
  execute "silent e! " . bufname("%")
endfunction

command! -nargs=* Section call Header("#", "=", <f-args>)
command! -nargs=* Subsection call Header("#", "-", <f-args>)
command! Isort call Isort()

"===============================================================================
" Autocommands
"===============================================================================

augroup code
    autocmd!
    " write crontabs in place
    autocmd filetype crontab setlocal nobackup nowritebackup
    " use 4 spaces in Python and PowerShell
    autocmd FileType python setlocal ts=4 sts=4 sw=4
    autocmd FileType ps1 setlocal ts=4 sts=4 sw=4
    " use hard tabs for Go, Makefiles, and .gitconfig
    autocmd FileType go,make,gitconfig setlocal noet ts=4 sw=4 sts=4
    " use YAML syntax highlighting for RAML files
    autocmd BufRead,BufNewFile *.raml set filetype=yaml
augroup END

augroup writing
    autocmd!
    autocmd FileType markdown,rst,wiki,tex set spell spelllang=en_ca
    autocmd FileType markdown,rst,wiki,tex setlocal tw=0
augroup END

augroup templates
  autocmd!
  autocmd BufNewFile *.* silent! call Boilerplate()
augroup END

augroup vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

if filereadable(glob('~/.vimrc_local'))
  source ~/.vimrc_local
endif

syntax on " at the bottom for bundle compatibility

