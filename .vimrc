if &compatible
	set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein')

	let g:toml_dir = expand('~/.vim/rc')
	let s:toml = g:toml_dir . '/dein.toml'
	let s:lazy_toml = g:toml_dir . '/dein_lazy.toml'

	" tomlを読み込み、キャッシュさせる
	call dein#load_toml(s:toml, {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	" pluginをtomlで管理する
	call dein#end()
	call dein#save_state()
endif

" installされていないプラグインがある場合はinstall
if dein#check_install()
	call dein#install()
endif

" colorscheme
" cleared colorStyle
autocmd colorscheme * highlight cssURL NONE
colorscheme molokai

syntax on
filetype on
filetype indent on
filetype plugin indent on

set noswapfile
set number
set showtabline=2 " 常にタブラインを表示
set helplang=ja
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set hidden
set backspace=indent,eol,start
set complete+=k
set dictionary=javascript.dict
set showmode
set autoread
set showcmd
set wildmenu
set clipboard+=unnamed
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,sjis,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決
set hlsearch
set tags=tags
set t_Co=256
set list listchars=tab:\¦\ 
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'calendar', 'thumbnail', 'tweetvim']
let mapleader = "_"
let NERDTreeShowHidden = 1

"autocmd VimEnter * execute 'NERDTree'
if has("autocmd")
  autocmd FileType scss setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vue setlocal sw=2 sts=2 ts=2 et
  autocmd FileType pug setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ruby setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vim setlocal sw=2 sts=2 ts=2 et
  autocmd FileType dart setlocal sw=2 sts=2 ts=2 et
endif


" map
map <C-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" inoremap
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" nnoremap
nnoremap    [Tag]   <Nop>
nnoremap <C-l> ggvG$
nnoremap <C-k> 0v$
nnoremap <Tab>b :Unite bookmark<CR>

nnoremap <C-d>k :LspPeekDefinition<CR>
nnoremap <C-d>j :LspDefinition<CR>
nnoremap <C-d>f :LspDocumentFormat<CR>
nnoremap <C-d>h :LspHover<CR>
nnoremap <C-d>r :LspReferences<CR>
nnoremap <C-d>n :LspRename<CR>
nnoremap <C-d>c :LspCodeAction<CR>
nnoremap <C-d>i :ImportJSWord<CR>


" vimrc内で設定しないと動かない
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/s <Plug>NERDCommenterSexy

" cmap
cmap <silent> :vf<Enter> :VimFiler<Enter>

" nmap
nmap    t [Tag]

" autocmd
autocmd FileType html :setlocal path+=;/

let g:lsp_async_completion = 1
let g:lsp_log_file = ""
"let g:lsp_log_verbose = 1

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" html閉じタグ補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" map
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>

"%でhtmlのタグをジャンプ
source /usr/local/share/vim/vim82/macros/matchit.vim

autocmd colorscheme * highlight cssURL NONE

" safariで現在開いているファイルを開く
command! Opens call s:opens()
function! s:opens()
  !open -a /Applications/Safari.app %
endfunction

" tigをvimTerminalで開く
command! Tig call s:vtig()
function! s:vtig()
  vert term ++close tig status
endfunction

" vimTerminalを縦分割で開く
command! Vterm call s:vterm()
function! s:vterm()
  vert term ++cols=50
endfunction

