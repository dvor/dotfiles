
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

" Text
autocmd FileType text setlocal textwidth=80

" Objective C
autocmd FileType objc setlocal colorcolumn=115           " Highlight 115 column
autocmd FileType objc setlocal commentstring=//\ %s      " Comment string for vim-commentary plugin
autocmd FileType objc nnoremap <Leader>a :Alternate<CR>  " cocoa.vim plugin
autocmd FileType objc noremap <leader>m :ListMethods<CR> " cocoa.vim plugin

autocmd FileType swift setlocal colorcolumn=115 "Highlight 115 column
autocmd FileType swift setlocal commentstring=//\ %s      " Comment string for vim-commentary plugin

" autocmd FileType objc setlocal omnifunc=ClangComplete
" autocmd FileType objc let g:clang_complete_auto = 0   " Disable auto popup, use <Tab> to autocomplete
" autocmd FileType objc let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
" autocmd FileType objc let g:clang_user_options='clang -cc1 -triple i386-apple-macosx10.6.7 -target-cpu yonah -target-linker-version 128.2 -resource-dir /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/4.2 -fblocks -x objective-c -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.1.sdk -D __IPHONE_OS_VERSION_MIN_REQUIRED=50100 || exit 0'

" Disable auto completion, always <c-x> <c-o> to complete
let g:clang_complete_auto = 0 
let g:clang_use_library = 1
let g:clang_periodic_quickfix = 0
let g:clang_close_preview = 1

" For Objective-C, this needs to be active, otherwise multi-parameter methods won't be completed correctly
let g:clang_snippets = 1

" Snipmate does not work anymore, ultisnips is the recommended plugin
" let g:clang_snippets_engine = 'ultisnips'

" This might change depending on your installation
let g:clang_exec = '/usr/local/bin/clang'
let g:clang_library_path = '/usr/local/lib/'

let g:clang_debug=1
