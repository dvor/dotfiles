" ------------------------------------------------------------
" -- Pathogen
" ------------------------------------------------------------
call pathogen#infect()

" russian language is broken on mac, so use english instead
if has("mac")
    language en_US
endif

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

if has("gui_running")
    " Colorscheme and font
    colo navajo-night
    set guifont=Menlo\ Regular:h16

    " guioptions
    set go=acg
else
    " Colorscheme
    colo 256-grayvim
endif

set t_Co=256
" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
" !! with snipMate it is causing error on start
" set cpoptions=ces$

" Set the status line format
set stl =%f\  " filename
set stl+=%m\ %r\  " modified and readonly flags
set stl+=Buf:#%n\      " buffer number
set stl+=%{getcwd()}/  " current directory
set stl+=%=Col:%v\ Line:%l/%L[%p%%]\  " position in file

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Show the current mode
set showmode

" Switch on syntax highlighting
syntax on

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Make the command-line completion better
set wildmenu

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Case insensitive search
set ignorecase

" Add the unnamed register to the clipboard
set clipboard+=unnamed

" Automatically read a file that has changes on disk
set autoread

" Allow the cursor to go to "invalid" places
set virtualedit=all



" ------------------------------------------------------------------------------
" Mappings
" ------------------------------------------------------------------------------

" The default leader is '\', but many people prefer ','
let mapleader=','


" Easier moving in windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" FuzzyFinder
map <leader>f :FufFile<CR>





augroup Kiwi
  au!
  autocmd BufNewFile,BufRead *Spec.m,*Spec.mm set foldmethod=expr foldexpr=KiwiFoldLevel(v:lnum)
augroup END

function! KiwiFoldLevel(lnum)
  let line=getline(a:lnum)
  if line=~'^\s\s*\(context\|describe\|it\)\s*('
    return ">" . (indent(a:lnum) / (&sts ? &sts : &ts))
  elseif line=~'^\s\s*});\s*$' && getline(a:lnum+1)!~'^\s*$'
    return "<" . (indent(a:lnum) / (&sts ? &sts : &ts))
  elseif line=~'^\s*$' && getline(a:lnum-1)=~'^\s\s*});\s*$'
    return "<" . (indent(a:lnum-1) / (&sts ? &sts : &ts))
  elseif line=~'{{'.'{[0-9][0-9]*'
    return ">" . substitute(line, '^.*{{'.'{\([0-9]*\).*$', '\1', '')
  elseif line=~('{{'.'{')
    return 'a1'
  elseif line=~'[0-9][0-9]*}'.'}}'
    return "<" . substitute(line, '^.*\([0-9][0-9]*\)}'.'}}.*$', '\1', '')
  elseif line=~'}'.'}}'
    return 's1'
  else
    return '='
  endif
endfunction

