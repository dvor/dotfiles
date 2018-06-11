" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

"  Vim highlights curly braces in blocks as errors, fixing it
let c_no_curly_error = 1

" Use ag instead of grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" airline - set theme and remove stupid separators
let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline#extensions#whitespace#enabled=0

" remove buffergator mappings, add only buffer catalog
let g:buffergator_suppress_keymaps=1

" gist-vim
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

let g:vimwiki_list = [{'path': '~/CloudStation/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
" Highlight checked list items with a special color
let g:vimwiki_hl_cb_checked = 2
" Disable tab mapping to fix autocompletion
let g:vimwiki_table_mappings = 0

" let g:vimwiki_folding = 'expr'

" neoterm
let g:neoterm_autoinsert = 1

