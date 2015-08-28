
execute pathogen#infect()

let mapleader = ','
let maplocalleader = ','

let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'

let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|target|dist|node_modules|jspm_packages|build)$'
let g:ctrlp_map = '<leader>f'
let g:ctrlp_match_window = 'bottom,orger:btt,min:1,max:10,results:10'

" Supertab settings
let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1
let g:SuperTabDefaultCompletionType = 'context'

" Rainbow
let g:rainbow_active = 1

" Ensure that only the longest match is selected on completion
" This allows me to continue to type to match 
set completeopt=longest,menuone

" Eclim settings
" ,i imports whatever is needed for current line
nnoremap <silent> <LocalLeader>i :JavaImport<cr>
" ,d opens javadoc for statement in browser
nnoremap <silent> <LocalLeader>d :JavaDocSearch -x declarations<cr>
" ,<enter> searches context for statement
nnoremap <silent> <LocalLeader><cr> :JavaSearchContext<cr>
" ,jv validates current java file
nnoremap <silent> <LocalLeader>jv :Validate<cr>
" ,jc shows corrections for the current line of java
nnoremap <silent> <LocalLeader>jc :JavaCorrect<cr>
" 'open' on OSX will open the url in the default browser without issue
let g:EclimBrowser='open'

" Window movements
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

set background=dark
colorscheme solarized
