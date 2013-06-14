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
set nolist                                  " list disables linebreak
set textwidth=0
set wrapmargin=0                            " don't force text wrapping
set wildmode=longest,list,full              " tab completion
set wildmenu                                " tab through filenames

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
set statusline+=%r                          " read-only flag as [RO]
set statusline+=\ %m                        " modified flag as [+]
set statusline+=\ %c,                       " column number
set statusline+=%l/%L                       " line number / total lines
set statusline+=\ %P                        " percentage of file

au BufRead,BufNewFile Puppetfile set filetype=puppet

syntax on                                   " at the bottom for bundle compatibility 
