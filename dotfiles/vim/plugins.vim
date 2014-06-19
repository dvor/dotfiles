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

let g:clang_complete_auto=0
