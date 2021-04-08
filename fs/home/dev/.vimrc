set nocompatible              " be iMproved

call plug#begin()

" custom plugins
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'wangtiga/vim-im'
Plug 'wangtiga/vim-ydict'

" Plug 'shougo/neocomplete.vim'
" Plug 'bling/vim-airline'
" Plug 'tpope/vim-fugitive'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'mbbill/undotree'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'scrooloose/nerdcommenter'

" all of your Plugins must be added before the following line
call plug#end()            " required

" " general customizations
" syntax on
" set ts=4
" set sw=4
" set number
" set cursorline
" set scrolloff=999
" set encoding=utf-8
" " colorscheme molokai
" 
" " plugin customizations
" " neocomplete
" let g:neocomplete#enable_at_startup = 1
" 
" " vim go
" " disable open browser after posting snippet
" let g:go_play_open_browser = 0
" " enable goimports
" let g:go_fmt_command = "goimports"
" " enable additional highlighting
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1

" " vim-airline
" set laststatus=2
" let g:bufferline_echo = 0
" let g:airline#extensions#tabline#enabled = 1
" " let g:airline_theme = 'dark'

" " tagbar
" let g:tagbar_type_go = {
"     \ 'ctagstype' : 'go',
"     \ 'kinds' : [
"         \ 'p:package',
"         \ 'i:imports:1',
"         \ 'c:constants',
"         \ 'v:variables',
"         \ 't:types',
"         \ 'n:interfaces',
"         \ 'w:fields',
"         \ 'e:embedded',
"         \ 'm:methods',
"         \ 'r:constructor',
"         \ 'f:functions'
"     \ ],
"     \ 'sro' : '.',
"     \ 'kind2scope' : {
"         \ 't' : 'ctype',
"         \ 'n' : 'ntype'
"     \ },
"     \ 'scope2kind' : {
"         \ 'ctype' : 't',
"         \ 'ntype' : 'n'
"     \ },
"     \ 'ctagsbin'  : 'gotags',
"     \ 'ctagsargs' : '-sort -silent'
" \ }
" 
" 
" " shortcuts remap
" nmap <F2> :tabnew<CR>
" nmap <F3> :tabclose<CR>
" nmap <F5> :UndotreeToggle<CR>
" nmap <F7> :NERDTreeTabsToggle<CR>
" nmap <F8> :TagbarToggle<CR>
" nmap <C-Left> :tabprevious<CR>
" nmap <C-Right> :tabnext<CR>
" 
" " show a list of interfaces which is implemented by the type under your cursor
" au FileType go nmap <Leader>s <Plug>(go-implements)
" " show type info for the word under your cursor
" au FileType go nmap <Leader>gi <Plug>(go-info)
" " open the relevant Godoc for the word under the cursor
" au FileType go nmap <Leader>gd <Plug>(go-doc)
" au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
" " run Go commands
" au FileType go nmap <leader>r <Plug>(go-run)
" au FileType go nmap <leader>b <Plug>(go-build)
" au FileType go nmap <leader>t <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)
" au FileType go nmap <leader>i <Plug>(go-install)
" " open the definition/declaration in a new vertical, horizontal or tab for the
" " word under your cursor
" au FileType go nmap <Leader>ds <Plug>(go-def-split)
" au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" " rename the identifier under the cursor to a new name
" au FileType go nmap <Leader>e <Plug>(go-rename)

"""""""""" by ws

" vim-airline
set laststatus=2
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme = 'dark'

set backspace=indent,eol,start " backspace over everything in insert mode
set scrolloff=99 ":set so=7  " 设置光标上下两侧最少保留的屏幕行数
set hlsearch     " 高亮显示当前搜索的关键字
set nu           " 显示行号
set imsearch=0   " disable vim-im plugin in search

syntax on        " 语法高亮
autocmd FileType qf wincmd J   " 强制 quickfix 窗口默认在最底部显示

" ctrlp
let g:ctrlp_max_files=0
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100' " 显示尽可能多的文件，方便自己手动选择需要的文件
let g:ctrlp_match_current_file = 1 " 显示已经打开的文件


au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <Leader>rn <Plug>(go-rename)
au FileType go nmap <Leader>rf <Plug>(go-reference)

" How to undo/revert making current window the only window only <ctrl+w O>
nnoremap <C-w>o :mksession! ~/.vim.session.bak<CR>:wincmd o<CR>
nnoremap <C-w>u :source ~/.vim.session.bak<CR>

" ydict search word
vnoremap tV :<C-u>Ydv<CR>
nnoremap tC :<C-u>Ydc<CR>

" gG 在当前目录的*.go文件中，搜索当前光标所在的单词
" gF 在当前文件中，搜索当前光标所在的单词
" 后缀增加 <CR>  代表回车，可以输入快捷键后立即搜索
nnoremap gG :execute "vimgrep /" . expand("<cword>") . "/j **/*.go" <Bar> cw
nnoremap gF :execute "vimgrep /" . GetVisualSelection() . "/j **/*.go " <Bar> cw
nnoremap gC :execute "vimgrep /" . expand("<cword>") . "/j **/*.cpp **/*.c **/*.h" <Bar> cw



