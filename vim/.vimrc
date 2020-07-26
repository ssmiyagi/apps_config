colorscheme default
source ~/command.vim
call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'easymotion/vim-easymotion'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'tpope/vim-surround'
  Plug 'nathanaelkane/vim-indent-guides'

  Plug 'Shougo/deoplete.nvim'
  if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'Shougo/deoplete.nvim'
  endif
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
  Plug 'junegunn/fzf.vim'
  Plug 'juneedahamed/svnj.vim'
  Plug 'ternjs/tern_for_vim', {'do' : 'npm install'}
  Plug 'moll/vim-node'
  Plug 'Townk/vim-autoclose'
call plug#end()

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/vim_snippets/'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <C-k>     <Plug>(neosnippet_expand_target)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"xmap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
"タブ、スペースを色付け
let g:indent_guides_enable_on_vim_startup = 1
"スペースをラダーにする
let mapleader = "\<Space>"
nnoremap <Leader><Leader>j <C-w>j
nnoremap <Leader><Leader>k <C-w>k
nnoremap <Leader><Leader>h <C-w>h
nnoremap <Leader><Leader>l <C-w>l
"nnoremap <Leader>f <Leader><Leader>s
"最後のカーソル位置を記憶する
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
"ヤンクしたデータをクリップボードで使用＆選択範囲自動コピーヤンクしたデータをクリップボードで使用＆選択範囲自動コピー
set clipboard=unnamed,autoselect
"ｊｊでインサートモード
inoremap <silent> jj <ESC>
" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っｊ <ESC>
inoremap <silent> っj <ESC>
set imdisable
"setting
"文字を折り返さない
set nowrap
"文字コードをUFT-8に設定
set encoding=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
"set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable


" Tab系
" 不可視文字を可視化(タブが「?-」と表示される)
set list listchars=tab:\?\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する

set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
set guifont=Cica:h11
set printfont=Cica:h8
"set renderingoptions=type:directx,renmode:5
set ambiwidth=double
""""""""""""""""""""""""""""""
"全角スペースを表示
""""""""""""""""""""""""""""""
"コメント以外で全角スペースを指定しているので scriptencodingと、
"このファイルのエンコードが一致するよう注意！
"全角スペースが強調表示されない場合、ここでscriptencodingを指定すると良い。
"scriptencoding cp932
"
"デフォルトのZenkakuSpaceを定義
"function! ZenkakuSpace()
"  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
"endfunction

"if has('syntax')
"  augroup ZenkakuSpace
"    autocmd!
"    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
"    autocmd ColorScheme       * call ZenkakuSpace()
"    " 全角スペースのハイライト指定
"    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
"  augroup END
"
"  call ZenkakuSpace()
"endif

"ノーマルモードenterでカーソル位置で改行
nnoremap <CR> i<Return><Esc>
"shell起動をpowershellにする
"FZFが使えなくなるからコメントアウト
"if has('win32')
"  set shell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
"  set shellcmdflag=-c
"  set shellquote=\"
"  set shellxquote=
"endif
:command Terp terminal powershell 
:command Ter terminal  
:command Q q!  
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
\ <bang>0)


" 指定のデータをレジスタに登録する
function! s:Clip(data)
  let @*=a:data
  echo "clipped: " . a:data
endfunction

" 現在開いているファイルのパスをレジスタへ
command! -nargs=0 ClipPath call s:Clip(expand('%:p'))
" 現在開いているファイルのファイル名をレジスタへ
command! -nargs=0 ClipFile call s:Clip(expand('%:t'))
" 現在開いているファイルのディレクトリパスをレジスタへ
command! -nargs=0 ClipDir  call s:Clip(expand('%:p:h'))
"折り畳み ファイルオープンについて
set foldenable
set foldmethod=marker

"Auto completetion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"require gf jump
"set suffixesadd=.php,.js,.rb,.java,.json,.md,.as
"nnoremap gf :<C-u>execute printf('edit %s', MyProjectRootFindFile(expand('<cfile>')))<CR>
"nnoremap gfs :<C-u>execute printf('split %s', MyProjectRootFindFile(expand('<cfile>')))<CR>
"nnoremap gfv :<C-u>execute printf('vsplit %s', MyProjectRootFindFile(expand('<cfile>')))<CR>
"
"function! MyProjectRootFindFile(path)
"  return findfile(substitute(a:path, '^[\.\/]*', '', 'g'), MyProjectRoot(expand('%:p')) . '**;')
"endfunction
"
"function! MyProjectRoot(path)
"  let path = a:path
"  while path != '/'
"    for target in ['.svn', '.git', 'package.json', 'composer.json'] " etc...
"      let targetPath = printf('%s/%s', path, target)
"      if isdirectory(targetPath) || filereadable(targetPath)
"        return path " found project root.
"      endif
"    endfor
"    let path = fnamemodify(path, ':p:h:h')
"  endwhile
"  return expand('%:p:h') " not found project root.
"endfunction


"tab page settings
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
