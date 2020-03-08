" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " .toml file
    let s:rc_dir = expand('~/.vim')
    if !isdirectory(s:rc_dir)
        call mkdir(s:rc_dir, 'p')
    endif
    let s:toml = s:rc_dir . '/dein.toml'

    " read toml and cache
    call dein#load_toml(s:toml, {'lazy': 0})

    " end settings
    call dein#end()
    call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
    call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif
" }}}
" }}}
" カラー
colorscheme onedark

" VimのVimのバッファやレジスタ内などで使用する文字コードを設定
set encoding=utf-8

" Vimがスクリプトを処理するとき、scriptencodingで指定した文字コードから
" encodingで指定した文字コードに変換される
scriptencoding utf-8

" 既存のファイルを開くとき、Vimが使用する文字コードを判定する順番
" 先頭から順に試される
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

" シンタックスハイライトを有効にする
syntax enable

" ファイルの種類に応じて自動で設定を行うような プラグイン
filetype plugin indent on

" カーソルラインを表示
set cursorline

" カーソルラインのトグル
" set cursorline!

" 行番号
set number

" 相対的な行番号
"set relativenumber
set helplang=ja,en
" 検索結果をハイライトする
set hlsearch

" 検索時大文字小文字を区別しない
set ignorecase

" 検索時、大文字を入力した場合大文字小文字を区別する
set smartcase

" 文字を入力するたびに、その時点でパターンマッチしたテキストをハイライト
set incsearch

if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	" ディレクトリが存在しない場合は作成
	if !isdirectory(undo_path)
		call mkdir(undo_path, 'p')
	endif
	let &undodir = undo_path
	set undofile
endif
" 展開するスペースの個数
set tabstop=4

" タブをスペースに展開
set expandtab

" インデントを考慮して改行
set smartindent

" インデントのスペースの数
set shiftwidth=4

" タブページ
set showtabline=2

"ステータスライン
set laststatus=2

"クリップボードコピー
set clipboard+=unnamed

"短形選択
set virtualedit=block

" コマンドライン補完
set wildmenu
" 開いたときにカレンとディレクトリ
set autochdir
  " set autochdir
" autocmd BufEnter * execute 'silent! lcd '.expand('%:h')

" Go で :w　を実行したときに importとfmtを自動でしてくれるようにした
autocmd BufWritePre *.go
              \ call execute('LspCodeActionSync source.organizeImports')
autocmd BufWritePre *.go
             \ call execute('LspDocumentFormat')
" Key bindの設定
" 検索ハイライトの消去
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" 段落の移動
nnoremap <C-j> }
nnoremap <C-k> {
"ターミナルを垂直で開く
nnoremap <C-n>\ :vert term ++close 
"ターミナルを水平で開く
nnoremap <C-n>- :bo term ++close 
" ターミナルを新しいタブページで開く
nnoremap <C-t> :tab term ++close
" 画面分割しlazygitを開く
nnoremap <silent><C-n>g :vert term ++close lazygit<CR>
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap ; :
inoremap <C-[> <ESC>
" 画面増やすためのキーバインド
nnoremap s <Nop>
" nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L

nnoremap sw <C-w>w
nnoremap sr <C-w>r

nnoremap sq :q<CR>
nnoremap sQ :bd<CR>

nnoremap st :tabnew<CR>
nnoremap sn gt
nnoremap sp gT

" nnoremap sl <C-w>l
"nnoremap sl <C-w>l
"nnoremap sl <C-w>l
" 行の最初の文字の前にコメント文字をトグル
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" 行頭にコメントをトグル
nmap <Leader>, <Plug>(caw:zeropos:toggle)
vmap <Leader>, <Plug>(caw:zeropos:toggle)


inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 補完表示時のEnterで改行をしない
" inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
"
" set completeopt=menuone,noinsert
" inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
" inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
" call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
" call submode#map('bufmove', 'n', '', '>', '<C-w>>')
" call submode#map('bufmove', 'n', '', '<', '<C-w><')
set nocompatible
"カーソルを行頭，行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"BSで削除できるものを指定する
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction

command! SyntaxInfo call s:get_syn_info()
let g:python_host_prog = expand('/usr/bin/python')
let g:python3_host_prog = expand('/usr/local/Cellar/python/3.7.6_1/bin/python3.7')


"競プロ
function MakeCquery()
  let temp = expand('%:p')
  echo system('echo ''[{"directory": "/Users/Daiki/Atcoder","command": "/usr/bin/c++  ' . temp . ' -std=c++11 -I/usr/local/include -I/Library/Developer/CommandLineTools/usr/bin/../include/c++/v1 -I/Library/Developer/CommandLineTools/usr/lib/clang/11.0.0/include -I/Library/Developer/CommandLineTools/usr/include -I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include","file": "' . temp . '"}]'' > compile_commands.json')
endfunction

autocmd BufNewFile ~/Atcoder/*.cpp :0r ~/.vim/templates/atcoder.cpp
autocmd BufNewFile  ~/Atcoder/*.cpp call MakeCquery()
autocmd BufReadPre ~/Atcoder/*.cpp call MakeCquery()


