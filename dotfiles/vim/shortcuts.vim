" map <leader> to "," instead of "\"
let mapleader = ","

set pastetoggle=<F2>

" <esc><esc>
" clear the search highlight in normal mode
nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>

" indentation in visual mode with < >
vnoremap < <gv
vnoremap > >gv

" Fast grep the word under cursor
" noremap <Leader>g :execute "Ack " . expand("<cword>") <Bar> cw<CR>
noremap <leader>g :execute "Ag " . expand("<cword>") <Bar> cw<CR>

" Y yanks from cursor to the end of line, like D and C
nnoremap Y y$

" Moving around in Insert mode with Ctrl+hjkl
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" Moving around spits in Normal mode with Ctrl+hjkl
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" working with splits
nnoremap <Leader>s :split<CR>
nnoremap <Leader>d :close<CR>
nnoremap <Leader>f :vsplit<CR>
nnoremap <Leader>o :only<CR>

" Don't skip wrap lines
noremap j gj
noremap k gk

" Jumping around errors
nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>N :cprevious<CR>

" Make word under cursor uppercase
inoremap <C-u> <esc>viwUea

" auto complete {} indent and position the cursor in the middle line
inoremap {<CR> {<CR>}<Esc>O

" clear CtrlPCache (in case is new file was added)
nnoremap <Leader>c :CtrlPClearAllCaches<CR>

" Tabular plugin
nnoremap <leader>t :Tabularize /
vnoremap <leader>t :Tabularize /

nnoremap <leader>b :BuffergatorOpen<CR>

" open dash
nnoremap <leader>h :!open dash://<cword><cr><cr>

" format json
nnoremap <leader>j :%!python -m json.tool<CR>

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nnoremap <leader>x :XcodeActionsOpenFile<CR>

nnoremap <C-S-space> :VimwikiToggleListItem<CR>

let g:kanbanBoardIsOpened = 0

function KanbanOpenFile(folder, file)
    let wikiPath = g:vimwiki_list[0]["path"]
    execute ":e " . wikiPath . "Kanban/" . a:folder . "/" . a:file . ".wiki"

    :normal j
    :normal j
endfunction

function KanbanOpenBoard(folder)
    let g:kanbanBoardIsOpened = 1
    :tabnew

    :only
    :call KanbanOpenFile(a:folder, "Backlog")
    :vsplit
    :call KanbanOpenFile(a:folder, "InProgress")
    :vsplit
    :call KanbanOpenFile(a:folder, "Done")
    :wincmd h

    " Skip wrap lines
    :noremap j j
    :noremap k k
endfunction

function KanbanCloseBoard()
    if g:kanbanBoardIsOpened == 1
        let g:kanbanBoardIsOpened = 0
        :tabclose
    endif
endfunction


nnoremap ,kw :call KanbanOpenBoard("Work")<CR>
nnoremap ,kh :call KanbanOpenBoard("Home")<CR>
nnoremap ,kd :call KanbanCloseBoard()<CR>
