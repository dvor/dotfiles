" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

let g:clang_library_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"

" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 0

let g:clang_user_options='clang -cc1 -triple i386-apple-macosx10.6.7 -target-cpu yonah -target-linker-version 128.2 -resource-dir /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/4.2 -fblocks -x objective-c -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.1.sdk -D __IPHONE_OS_VERSION_MIN_REQUIRED=50100 || exit 0'

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
