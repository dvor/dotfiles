" Switch on syntax highlighting
syntax on

" russian language is broken on mac, so use english instead
if has("mac")
    language en_US
endif

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

set wildmenu                         " Make the command-line completion better
set autoread                         " Automatically read a file that has changes on disk
set nonumber                         " No line numbers
set encoding=utf-8                   " Character encoding used inside Vim.
set showcmd                          " Show (partial) command in the last line of the screen
set scrolloff=6                      " Minimal number of screen lines to keep above and below the cursor.
set showtabline=1                    " Show tabs only if there is more than one tab
set list                             " Display unprintable characters
set wrap                             " Wrap lines
set formatoptions-=o                 " Don't continue comments when pushing o/O
set autoindent                       " Copy indent from previous line
set smartindent                      " Auto indent extra indent levels in certain case
set expandtab                        " Make spaces not tabs
set shiftwidth=4                     " 4 spaces when indented
set tabstop=4                        " 4 space tabs
set splitbelow                       " :sp new split will be below current
set splitright                       " :vsp new split will be on the right side of current
set shortmess+=I                     " Removing intro screen
set mouseshape=s:udsizing,m:no       " Turn to a sizing arrow over the status lines
set mousehide                        " Hide the mouse when typing text
set hidden                           " This allows to edit several files in the same time without having to save them
set noerrorbells                     " Obvious
set laststatus=2                     " Always show statusline
set incsearch                        " Searches for text as entered
set hlsearch                         " Highlights search
set ignorecase                       " Ignore case in searches
set smartcase                        " Override the 'ignorecase' if the search pattern contains upper case characters
set history=1000                     " Store lots of :cmdline history
set backspace=indent,eol,start       " Adds intuitive backspacing
set nobackup                         " No backup files
set noswapfile                       " No swap files
set completeopt=menu,preview,longest " Complete options (disable preview scratch window)
set visualbell                       " Don't beep!
set t_vb=                            " Don't beep!

set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:× " Show tabs and trailing spaces

if has("gui_running")
    set linespace=1        " Add some line space for easy reading
    set guioptions=        " Removing gui elements
    set guifont=Monaco:h16
    set gcr=n:blinkon0     " Disabling cursor flashing. No more stress.
endif

" Vim and OS share clipboard
if exists("+clipboard")
  set clipboard=unnamed
endif
