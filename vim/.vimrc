"===============================================================================
" Plugins
"===============================================================================

call plug#begin('~/.vim/bundle')

Plug 'Townk/vim-autoclose'
Plug 'airblade/vim-gitgutter'
Plug 'chase/vim-ansible-yaml'
Plug 'dhruvasagar/vim-table-mode'
Plug 'eiginn/netrw' " includes fix for http://paulgorman.org/blog/1400942674
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'jmcantrell/vim-virtualenv'
Plug 'jplaut/vim-arduino-ino'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/syntastic'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/wikipedia.vim'
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

"===============================================================================
" Keymaps
"===============================================================================

let mapleader=","
" play nicely with soft-wrapping
map k gk
map <Up> gk
map j gj
map <Down> gj
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

" vim-gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager    = 1

" vim-go
let g:go_fmt_command         = 'goimports'
let g:go_highlight_functions = 1
let g:go_highlight_methods   = 1
let g:go_highlight_structs   = 1

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
    " use Puppet syntax highlighting for Puppetfiles
    autocmd BufRead,BufNewFile Puppetfile set filetype=puppet
    " use YAML syntax highlighting for RAML files
    autocmd BufRead,BufNewFile *.raml set filetype=yaml
augroup END

augroup writing
    autocmd!
    autocmd FileType markdown,rst,wiki,tex set spell spelllang=en_ca
    " Pandoc macros
    autocmd FileType markdown,rst nnoremap <leader>ph :w<CR>:!pandoc "%" -s -S -o "%".html<CR>
    autocmd FileType markdown,rst nnoremap <leader>pp :w<CR>:!pandoc "%" -s -S -o "%".pdf<CR>
    autocmd FileType markdown nnoremap <leader>pr :w<CR>:!pandoc "%" -o "%".rst<CR>
    autocmd FileType rst nnoremap <leader>pm :w<CR>:!pandoc "%" -o "%".md<CR>
    autocmd FileType markdown nnoremap <leader>pw :w<CR>:!pandoc "%" -t mediawiki -o "%".wiki<CR>
    " LaTeX (rubber) macro
    autocmd FileType tex nnoremap <leader>c :w<CR>:!rubber --pdf "%" && rubber --clean "%"<CR>
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

