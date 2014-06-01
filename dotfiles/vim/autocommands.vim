
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

" Objective C
autocmd FileType objc setlocal omnifunc=ClangComplete
autocmd FileType objc setlocal colorcolumn=115           " Highlight 115 column
autocmd FileType objc setlocal commentstring=//\ %s      " Comment string for vim-commentary plugin
autocmd FileType objc nnoremap <Leader>a :Alternate<CR>  " cocoa.vim plugin
autocmd FileType objc noremap <leader>m :ListMethods<CR> " cocoa.vim plugin
