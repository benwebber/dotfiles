" vim:foldmethod=marker:foldlevel=0

source ~/.vim/bundles.vim

" Appearance {{{
colorscheme molokai
if v:version > 703
  let &colorcolumn=join(range(80,255), ',')   " change background past column 79
endif
set cursorline                              " highlight current line
set number                                  " line numbers
set t_Co=256                                " double rainbow
" }}}
" Lines and whitespace {{{
" Tabs
set expandtab                               " tabs are spaces
set tabstop=2                               " 2-space tab width
set softtabstop=2                           " treat expanded tabs as real tabs
set shiftwidth=2                            " indent using << and >>
" Line handling
set wrap                                    " wrap lines
set wrapmargin=0                            " don't force text wrapping
set textwidth=0                             " don't automatically break lines
set linebreak                               " ...unless manually broken
set nolist                                  " list disables linebreak
" }}}
" Behaviour {{{
set lazyredraw                              " only redraw when necessary
set modelines=5                             " number of modelines to check (OS X default is 0)
set mouse=a                                 " enable mouse
set shortmess=I                             " ignore intro
set wildmenu                                " tab through filenames
set wildmode=longest,list,full              " tab completion
set splitbelow                              " more natural splits
set splitright
" }}}
" Keymaps {{{
let mapleader=","
imap ;; <Esc>
" play nicely with soft-wrapping
map k gk
map <Up> gk
map j gj
map <Down> gj
" }}}
" Statusline {{{
set laststatus=2                            " always show statusline
set statusline=%{GetGitBranch()}\           " current git branch as [branch]
set statusline+=%f                          " path to file from pwd
set statusline+=%=                          " separate LHS and RHS
set statusline+=%y                          " filetype
set statusline+=%r                          " read-only flag as [RO]
set statusline+=\ %m                        " modified flag as [+]
set statusline+=\ %c,                       " column number
set statusline+=%l/%L                       " line number / total lines
" }}}
" Airline {{{
set noshowmode
let g:airline#extensions#whitspace#enabled = 0
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#virtualenv#enabled = 1
" }}}
" Autocommands {{{
augroup config
    autocmd!
    " use 4 spaces in Python and PowerShell
    autocmd FileType python setlocal ts=4 sts=4 sw=4
    autocmd FileType ps1 setlocal ts=4 sts=4 sw=4
    " use hard tabs for Go and Makefiles
    autocmd FileType go setlocal noexpandtab
    autocmd FileType make setlocal noexpandtab tabstop=8
    " use Puppet syntax highlighting for Puppetfiles
    autocmd BufRead,BufNewFile Puppetfile set filetype=puppet
    " use YAML syntax highlighting for RAML files
    autocmd BufRead,BufNewFile *.raml set filetype=yaml
    " LaTeX (rubber) macro
    autocmd FileType tex nnoremap <leader>c :w<CR>:!rubber --pdf "%" && rubber --clean "%"<CR>
    " Markdown (Pandoc) macros
    autocmd FileType markdown nnoremap <leader>ph :w<CR>:!pandoc "%" -s -S -o "%".html<CR>
    autocmd FileType markdown nnoremap <leader>pp :w<CR>:!pandoc "%" -s -S -o "%".pdf<CR>
    autocmd FileType markdown nnoremap <leader>pr :w<CR>:!pandoc "%" -o "%".rst<CR>
    autocmd FileType markdown nnoremap <leader>pw :w<CR>:!pandoc "%" -t mediawiki -o "%".wiki<CR>
augroup END
" }}}
" Functions {{{
" returns current git branch as [branch]
function! GetGitBranch(...)
  let branch = fugitive#head()
  if branch ==# ''
    return ''
  endif
  return '['.branch.']'
endfunction
" }}}

syntax on                                   " at the bottom for bundle compatibility

