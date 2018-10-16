
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

" Text
autocmd FileType text setlocal textwidth=80
autocmd FileType text setlocal spell

" Mail
autocmd FileType mail setlocal textwidth=0
autocmd FileType mail setlocal spell

autocmd FileType vimwiki setlocal spell

" Git commit
autocmd FileType gitcommit set spell

" Objective C
autocmd FileType objc setlocal colorcolumn=115           " Highlight 115 column
autocmd FileType objc setlocal commentstring=//\ %s      " Comment string for vim-commentary plugin
autocmd FileType objc setlocal spell
autocmd FileType objc nnoremap <Leader>a :Alternate<CR>  " cocoa.vim plugin
autocmd FileType objc noremap <leader>m :ListMethods<CR> " cocoa.vim plugin

autocmd FileType swift setlocal colorcolumn=115 "Highlight 115 column
autocmd FileType swift setlocal commentstring=//\ %s      " Comment string for vim-commentary plugin
autocmd FileType swift set nospell

autocmd BufRead,BufNewFile *.swift setfiletype swift
autocmd FileType swift call FileType_Swift()

" Go
autocmd FileType go set nolist

" Podfiles and podspecs
autocmd BufNewFile,BufRead *.podspec set filetype=ruby
autocmd BufNewFile,BufRead Podfile set filetype=ruby

function! FileType_Swift()
    if exists("b:did_ftswift") | return | endif
    let b:did_ftswift = 1

    nnoremap <buffer> <Leader>sw :!xcrun swift -i %<CR>
endfunction

command! Uncrustify :silent !uncrustify -c uncrustify.cfg -l OC+ --no-backup "%"

autocmd BufWritePost *.ldg,*.ledger 1,$LedgerAlign

autocmd FileType ledger inoremap <silent> <buffer> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>
autocmd FileType ledger vnoremap <silent> <buffer> <Tab> :LedgerAlign<CR>
autocmd FileType ledger inoremap <C-j> <c-r>=TriggerSnippet()<cr>
autocmd FileType ledger snoremap <C-j> <esc>i<right><c-r>=TriggerSnippet()<cr>
