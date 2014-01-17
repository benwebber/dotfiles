" .vimrc

" bundles
source ~/.vim/bundles.vim

" formatting
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" behaviour
set shortmess=I                             " ignore intro
set wrap                                    " wrap lines
set linebreak                               " ...unless manually broken
set modelines=1                             " default on OS X is modelines=0
set mouse=a                                 " enable mouse
set nolist                                  " list disables linebreak
set textwidth=0
set wrapmargin=0                            " don't force text wrapping
set wildmode=longest,list,full              " tab completion
set wildmenu                                " tab through filenames

" keymaps
" play nicely with soft-wrapping
map k gk
map <Up> gk
map j gj
map <Down> gj

let mapleader=","

" appearance
set number
set t_Co=256                                " double rainbow
colorscheme molokai
let &colorcolumn=join(range(81,255), ',')   " change background past column 80

" returns current git branch as [branch]
function! GetGitBranch(...)
  let branch = fugitive#head()
  if branch ==# ''
    return ''
  endif
  return '['.branch.']'
endfunction

" statusline
set laststatus=2                            " always show statusline
set statusline=%{GetGitBranch()}\           " current git branch as [branch]
set statusline+=%f                          " path to file from pwd
set statusline+=%=                          " separate LHS and RHS
set statusline+=%y                          " filetype
set statusline+=%r                          " read-only flag as [RO]
set statusline+=\ %m                        " modified flag as [+]
set statusline+=\ %c,                       " column number
set statusline+=%l/%L                       " line number / total lines

" airline:
set noshowmode
let g:airline#extensions#whitspace#enabled = 0
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#virtualenv#enabled = 1

" use 4 spaces in Python
autocmd FileType python setlocal ts=4 sts=4 sts=4

" use Puppet syntax highlighting for Puppetfiles
autocmd BufRead,BufNewFile Puppetfile set filetype=puppet

" use tabs in Makefiles
autocmd FileType make setlocal noexpandtab tabstop=8

" LaTeX (rubber) macro
autocmd FileType tex nnoremap <leader>c :w<CR>:!rubber --pdf "%" && rubber --clean "%"<CR>

syntax on                                   " at the bottom for bundle compatibility 

