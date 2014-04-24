" Vundle setup
    set nocompatible " be iMproved
    filetype off     " required!

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " let Vundle manage Vundle
    " required!
    Bundle 'git://github.com/gmarik/vundle.git'

    " My Bundles here:
    " NOTE: comments after Bundle command are not allowed...
    "
        Bundle 'flazz/vim-colorschemes'
        Bundle 'Rip-Rip/clang_complete'
        Bundle 'Townk/vim-autoclose'
        Bundle 'dvor/cocoa.vim'
        Bundle 'jeetsukumaran/vim-buffergator'
        Bundle 'ervandew/supertab'
        Bundle 'vim-scripts/IndexedSearch'
        Bundle 'mileszs/ack.vim'
        Bundle 'scrooloose/nerdcommenter'
        Bundle 'kien/ctrlp.vim'
        Bundle 'msanders/snipmate.vim'
        Bundle 'Lokaltog/vim-powerline'
        Bundle 'godlygeek/tabular'
        Bundle 'Lokaltog/vim-easymotion'
        "Bundle 'b4winckler/vim-objc'

    filetype plugin indent on     " required!
    " Brief help
    " :BundleList          - list configured bundles
    " :BundleInstall(!)    - install(update) bundles
    " :BundleSearch(!) foo - search(or refresh cache first) for foo
    " :BundleClean(!)      - confirm(or auto-ap prove) removal of unused bundles
    " see :h vundle for more details or wiki for FAQ

" russian language is broken on mac, so use english instead
if has("mac")
    language en_US
endif


" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" Interface

if has("gui_running")
    "set guifont=Menlo\ Regular:h15
    set guifont=Monaco:h16
    " guioptions
    set go=acg
else
endif

set t_Co=256
colo solarized
let g:solarized_termcolors=256

" Make the command-line completion better
set wildmenu

" Switch on syntax highlighting
 syntax on

" Automatically read a file that has changes on disk
set autoread

    set nonumber                  " Не показываем нумерацию строк
                                  " Во-первых, номер текущей строки всегда
                                  " есть в statusline, во-вторых, всегда можно
                                  " быстро перейти к нужной строке набрав :1
                                  " где 1 — номер строки.

    set encoding=utf-8 " character encoding used inside Vim.
    "set fileencodings=utf-8,cp1251 " Возможные кодировки файлов и последовательность определения

    set title    " window title
                 " the title of the window will be set to the value of 'titlestring'
                 " (if it is not empty), or to: filename [+=-] (path) - vim
    set showcmd  " show (partial) command in the last line of the screen
                 " set this option off if your terminal is slow.
                 " in visual mode the size of the selected area is shown:
                 " - when selecting characters within a line, the number of characters.
                 "   if the number of bytes is different it is also displayed: "2-6"
                 "   means two characters and six bytes.
                 " - when selecting more than one line, the number of lines.
                 " - when selecting a block, the size in screen characters:
                 "   {lines}x{columns}.

    set scrolloff=6       " if you set it to a very large value (999) the 
                            " cursor line will always be in the middle of the window
                            " (except at the start or end of the file or when long lines wrap).

    set showtabline=1       " показывать вкладки табов только когда их больше одной
    set list                " display unprintable characters
    set wrap                " включаем перенос строк (http://vimcasts.org/episodes/soft-wrapping-text/)
    if version >= 703
        set colorcolumn=90 " подсвечиваем 95 столбец
    end
    set textwidth=90
    set formatoptions-=o    " dont continue comments when pushing o/o
    set linebreak           " перенос не разрывая слов
    set autoindent          " копирует отступ от предыдущей строки
    set smartindent         " включаем 'умную' автоматическую расстановку отступов
    set expandtab
    set shiftwidth=4        " размер сдвига при нажатии на клавиши << и >>
    set tabstop=4           " размер табуляции
    set softtabstop=4
    set linespace=1         " add some line space for easy reading
    set gcr=n:blinkon0      " отключаем мигание курсора в macvim. больше никакого стресса.
    set guioptions=         " вырубаем все лишнее из гуи, если надо потогглить см <f6>
    set t_co=256            " кол-во цветов
    "set guicursor=          " отключаем мигание курсора
    set splitbelow          " новый сплит будет ниже текущего :sp
    set splitright          " новый сплит будет правее текущего :vsp
    set shortmess+=I        " не показывать intro screen
    set mouseshape=s:udsizing,m:no " turn to a sizing arrow over the status lines
    set mousehide " hide the mouse when typing text

    set hidden " this allows to edit several files in the same time without having to save them

    " не бибикать!
        set visualbell " use visual bell instead of beeping
        set t_vb=

    " символ табуляции и конца строки
        if has('multi_byte')
            if version >= 700
                set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
            else
                set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_
            endif
        endif

    " символ, который будет показан перед перенесенной строкой
        if has("linebreak")
              let &sbr = nr2char(8618).' '  " show ↪ at the beginning of wrapped lines
        endif


    " приводим в порядок status line

        function! FileSize()
            let bytes = getfsize(expand("%:p"))
            if bytes <= 0
                return ""
            endif
            if bytes < 1024
                return bytes . "b"
            else
                return (bytes / 1024) . "k"
            endif
        endfunction

        function! CurDir()
            return expand('%:p:~')
        endfunction

        set laststatus=2
        set statusline=\ 
        set statusline+=%n:\                 " buffer number
        set statusline+=%t                   " filename with full path
        set statusline+=%m                   " modified flag
        set statusline+=\ \ 
        set statusline+=%{&paste?'[paste]\ ':''}
        set statusline+=%{&fileencoding}
        set statusline+=\ \ %y               " type of file
        set statusline+=\ %3.3(%c%)          " column number
        set statusline+=\ \ %3.9(%l/%L%)     " line / total lines
        "set statusline+=\ \ %2.3p%%          " percentage through file in lines
        set statusline+=\ \ %{FileSize()}
        set statusline+=%<                   " where truncate if line too long
        set statusline+=\ \ CurDir:%{CurDir()}


    " не показывать парную скобку
        "let loaded_matchparen=1 " перестает прыгать на парную скобку, показывая где она. +100 к скорости



    " search
    set incsearch   " при поиске перескакивать на найденный текст в процессе набора строки
    set hlsearch    " включаем подсветку выражения, которое ищется в тексте
    set ignorecase  " игнорировать регистр букв при поиске
    set smartcase   " override the 'ignorecase' if the search pattern contains upper case characters


    " If you prefer the Omni-Completion tip window to close when a selection is
    " made, these lines close it on movement in insert mode or when leaving
    " insert mode
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif



" шорткаты

    let mapleader = "," " мапим <leader> на запятую. по умолчанию <leader> это обратный слэш \

    noremap <leader>m :ListMethods<CR>

    " <esc><esc>
        " clear the search highlight in normal mode
        nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>

    " < >
        vnoremap < <gv
        vnoremap > >gv

    " ,p
        " вставлять код извне без этой строчки проблематично, без нее начитается
        " бешеный реформат кода
        set pastetoggle=<leader>p


    " ,g
        " Fast grep
        " грепает в текущей директории по слову, на котором стоит курсор
        noremap <Leader>g :execute "Ack " . expand("<cword>") <Bar> cw<CR>

    " Y янкает от курсора и до конца строки. На манер страндартных D и С.
        nnoremap Y y$

    " Disable <Arrow keys>
        " Warning: nightmare mode!
        inoremap <Up> <NOP>
        inoremap <Down> <NOP>
        inoremap <Left> <NOP>
        inoremap <Right> <NOP>
        noremap <Up> <NOP>
        noremap <Down> <NOP>
        noremap <Left> <NOP>
        noremap <Right> <NOP>
        " Позволяем передвигаться с помощью hjkl в Insert mode зажав <Ctrl>
        inoremap <C-h> <C-o>h
        inoremap <C-j> <C-o>j
        inoremap <C-k> <C-o>k
        inoremap <C-l> <C-o>l

    " Переключение по сплитам
        nnoremap <C-h> <C-W>h
        nnoremap <C-j> <C-W>j
        nnoremap <C-k> <C-W>k
        nnoremap <C-l> <C-W>l

    " ,v
        " Pressing ,v opens the .vimrc in a new tab
        nnoremap <leader>v :vsplit $MYVIMRC<CR>

    " <Space> = <PageDown> Как в браузерах
        nnoremap <Space> <PageDown>

    " n и N
        " когда бегаем по результатам поиска, то пусть они всегда будут в центре
        nnoremap n nzz
        nnoremap N Nzz
        nnoremap * *zz
        nnoremap # #zz
        nnoremap g* g*zz
        nnoremap g# g#zz

    " Don't skip wrap lines
        " Еще раз и попонятнее:
        " если строка n длиная и не влезла в окно — она перенесется на
        " следующую (wrap on). Шокткаты ниже нужны, чтобы попасть
        " на каждую псевдострочку этой врапнутой строки.
        noremap j gj
        noremap k gk

    " 
        nnoremap <Leader>n :cnext<CR>
        nnoremap <Leader>N :cprevious<CR>


    " {<CR>
        " auto complete {} indent and position the cursor in the middle line
        inoremap {<CR> {<CR>}<Esc>O
        inoremap (<CR> (<CR>)<Esc>O
        inoremap [<CR> [<CR>]<Esc>O

    " Ремапим русские символы
        set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>


    inoremap <C-u> <esc>viwUea

    " clear CtrlPCache (in case is new file was added)
    nnoremap <Leader>c :CtrlPClearAllCaches<CR>

    nnoremap <Leader>a :Alternate<CR>

    nnoremap <Leader>s :split<CR>
    nnoremap <Leader>d :close<CR>
    nnoremap <Leader>f :vsplit<CR>
    nnoremap <Leader>o :only<CR>

    " Tabularize plugin
    nnoremap <leader>t :Tabularize /
    vnoremap <leader>t :Tabularize /

    " remove buffergator mappings, add only buffer catalog
    let g:buffergator_suppress_keymaps=1
    nnoremap <leader>b :BuffergatorOpen<CR>


" Environment
    set history=1000 " store lots of :cmdline history

    " Backspacing settings
        " start     allow backspacing over the start of insert;
        "           CTRL-W and CTRL-U stop once at the start of insert.
        " indent    allow backspacing over autoindent
        " eol       allow backspacing over line breaks (join lines)
        set backspace=indent,eol,start

    " Backup и swp файлы
        set nobackup " Отключаем создание бэкапов
        set noswapfile " Отключаем создание swap файлов
        "set backupdir=~/.vimi/bac//,/tmp " Директория для backup файлов
        "set directory=~/.vimi/swp//,/tmp " Директория для swp файлов

    " AutoReload .vimrc
        " from http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
        " Source the vimrc file after saving it
        if has("autocmd")
          autocmd! bufwritepost .vimrc source $MYVIMRC
        endif

    " Auto change the directory to the current file I'm working on
        "autocmd BufEnter * lcd %:p:h

    " Актуально только для MacVim
        " Save on losing focus
            "autocmd FocusLost * :wa

        " Resize splits when the window is resized
            au VimResized * exe "normal! \<c-w>="



" Плагины
    " UltiSnips
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
        

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

" Complete options (disable preview scratch window)
set completeopt=menu,preview,longest
 
let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"

" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 0

"not strictly necessary
set omnifunc=ClangComplete

let g:clang_user_options='clang -cc1 -triple i386-apple-macosx10.6.7 -target-cpu yonah -target-linker-version 128.2 -resource-dir /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/4.2 -fblocks -x objective-c -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.1.sdk -D __IPHONE_OS_VERSION_MIN_REQUIRED=50100 || exit 0'

let g:EasyMotion_keys = 'hjklasdfgyuiopqwertnmzxcvb'
hi link EasyMotionTarget ErrorMsg


"  Vim highlights curly braces in blocks as errors, fixing it
let c_no_curly_error = 1

"set runtimepath-=~/.vim/bundle/vim-autoclose
"set runtimepath-=~/.vim/bundle/vim-autoclose/after
"
"set runtimepath-=~/.vim/bundle/vim-buffergator
"set runtimepath-=~/.vim/bundle/vim-buffergator/after
"
"set runtimepath-=~/.vim/bundle/supertab
"set runtimepath-=~/.vim/bundle/supertab/after
"
"set runtimepath-=~/.vim/bundle/IndexedSearch
"set runtimepath-=~/.vim/bundle/IndexedSearch/after
"
"set runtimepath-=~/.vim/bundle/ack.vim
"set runtimepath-=~/.vim/bundle/ack.vim/after
"
"set runtimepath-=~/.vim/bundle/nerdcommenter
"set runtimepath-=~/.vim/bundle/nerdcommenter/after
"
"set runtimepath-=~/.vim/bundle/ctrlp.vim
"set runtimepath-=~/.vim/bundle/ctrlp.vim/after
"
"set runtimepath-=~/.vim/bundle/snipmate.vim
"set runtimepath-=~/.vim/bundle/snipmate.vim/after
"
"set runtimepath-=~/.vim/bundle/vim-powerline
"set runtimepath-=~/.vim/bundle/vim-powerline/after


" ObjC
"set runtimepath-=~/.vim/bundle/clang_complete
"set runtimepath-=~/.vim/bundle/clang_complete/after

"set runtimepath-=~/.vim/bundle/cocoa.vim
"set runtimepath-=~/.vim/bundle/cocoa.vim/after


