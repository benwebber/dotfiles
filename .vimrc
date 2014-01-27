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
set modeline
set modelines=1                             " default on OS X is modelines=0
set mouse=a                                 " enable mouse
set nolist                                  " list disables linebreak
set textwidth=0
set wrapmargin=0                            " don't force text wrapping
set wildmode=longest,list,full              " tab completion
set wildmenu                                " tab through filenames

" keymaps
imap ;; <Esc>

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

" airline
set noshowmode
let g:airline#extensions#whitspace#enabled = 0
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#virtualenv#enabled = 1

" use 4 spaces in Python and PowerShell
autocmd FileType python setlocal ts=4 sts=4 sts=4
autocmd FileType ps1 setlocal ts=4 sts=4 sts=4

" use Puppet syntax highlighting for Puppetfiles
autocmd BufRead,BufNewFile Puppetfile set filetype=puppet

" use Ruby syntax highlighting for Vagrantfiles
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" use tabs in Makefiles
autocmd FileType make setlocal noexpandtab tabstop=8

" LaTeX (rubber) macro
autocmd FileType tex nnoremap <leader>c :w<CR>:!rubber --pdf "%" && rubber --clean "%"<CR>

" Markdown (Pandoc) macros:
autocmd FileType markdown nnoremap <leader>ph :w<CR>:!pandoc "%" -s -S -o "%".html<CR>
autocmd FileType markdown nnoremap <leader>pp :w<CR>:!pandoc "%" -s -S -o "%".pdf<CR>
autocmd FileType markdown nnoremap <leader>pr :w<CR>:!pandoc "%" -o "%".rst<CR>
autocmd FileType markdown nnoremap <leader>pw :w<CR>:!pandoc "%" -t mediawiki -o "%".wiki<CR>

syntax on                                   " at the bottom for bundle compatibility 

