let g:python3_host_prog = 'C:\Users\akiya\AppData\Local\Programs\Python\Python37-32\python'

"@url POSIX互換関係の設定 http://tm.root-n.com/unix:command:git:operation:no_newline_at_end_of_file
set binary noeol

set clipboard=unnamed

set number
set bg=light

"set shell=powershell.exe
"set shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command
"set shellpipe=|
"set shellredir=>

"全角文字など、エラーにしたい空白文字の設定
augroup AdditionalHighlights
  autocmd!
  autocmd ColorScheme * highlight link ZenkakuSpace Error
  autocmd Syntax * syntax match ZenkakuSpace containedin=ALL /　/
augroup END

let g:deoplete#enable_at_startup = 1
autocmd FileType php :set dictionary='C:/users/akiya/AppData/Local/nvim/dictionary/wordpress/functions.dict'
autocmd FileType php :call deoplete#custom#source('dictionary', 'min_pattern_length', 2)

"タブ、行末、改行の可視設定
set listchars=tab:>\ ,trail:¬,extends:»,precedes:«
set list

set cursorline

set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

set splitright
set splitbelow

filetype indent on
"sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
autocmd FileType yaml setlocal sw=2 sts=2 ts=2 et
"autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et

"マークダウン用ファイル設定
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md hi Constant guifg=#fffe89

autocmd ColorScheme * highlight LineNr ctermbg=1 guibg=#00000

"キーアサイン
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Up> <nop>
noremap <Down> <nop>

cmap <Up> <nop>
cmap <Down> <nop>

"Colemak対応 hはQWERTYと同じ

"モーション
noremap n gj
noremap N J
noremap e gk
noremap E K
noremap i l
noremap I L

"オペレータ
noremap l i
noremap L I

"noremap o i
"noremap O I

noremap <C-w>n <C-w>j
noremap <C-w>e <C-w>k
noremap <C-w>i <C-w>l

noremap <C-w>N <C-w>J
noremap <C-w>E <C-w>K
noremap <C-w>I <C-w>L

nnoremap k n
nnoremap K N

noremap j e
noremap J E

"コマンドのエイリアス
nnoremap <C-s> :w<CR>
noremap <C-l> :nohlsearch<CR><C-l>

noremap <C-p> :tabprevious<CR>
noremap <C-n> :tabnext<CR>

map <S-Insert> <C-R>*

tnoremap <silent> <ESC> <C-\><C-n>

"リーダー プラグインの呼び出しに使う
let mapleader = "\<Space>"

noremap <leader>tr :Defx -split=vertical -winwidth=50 -direction=topleft<CR>
noremap <leader>fi :Defx<CR>
noremap <leader>so :so ~/AppData/Local/nvim/init.vim<CR>
noremap <leader>es :e ~/AppData/Local/nvim/init.vim<CR>

"set Project dir
noremap <leader>pr :cd %:h<CR>:pwd<CR>

"セッションの保存とロード ゴリラさんより
"session path
let s:session_path = expand('~\.cache\sessions')

if !isdirectory(s:session_path)
    call mkdir(s:session_path, "p")
endif
" save session
command! -nargs=1 SaveSession call s:saveSession(<f-args>)
function! s:saveSession(file)
    execute 'silent mksession!' s:session_path . '/' . a:file
endfunction
" load session
command! -nargs=1 LoadSession call s:loadSession(<f-args>)
function! s:loadSession(file)
    execute 'silent source' s:session_path . '/' . a:file
endfunction
" delete session
command! -nargs=1 DeleteSession call s:deleteSession(<f-args>)
function! s:deleteSession(file)
    call delete(expand(a:file))
endfunction

"qargs.vim 実践VIMより
command! -nargs=0 -bar Qargs execute 'args' Quickfixfilenames()
function! Quickfixfilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
      let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"プラグイン

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:dein_dir = expand('~\.cache\dein')

" Required:
if dein#load_state('C:\Users\akiya\.cache\dein')
  call dein#begin('C:\Users\akiya\.cache\dein')

  " Let dein manage dein
  " Required:
  call dein#add('C:\Users\akiya\.cache\dein\repos\github.com\Shougo\dein.vim')

  call dein#load_toml( 'C:\Users\akiya\AppData\Local\nvim\dein.toml')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

"End dein Scripts-------------------------

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

function! s:deinClean()
  if len(dein#check_clean())
    call map(dein#check_clean(), 'delete(v:val, "rf")')
  else
    echo '[ERR] no disabled plugins'
  endif
endfunction

augroup filetypedetect
    au BufRead,BufNewFile *.yml setfiletype ruby
augroup END

"Defx用キーマップ 変更が多いかもなのでこの位置
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> i
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> k
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> D
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> ,
  \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
endfunction

"call deoplete#enable_logging('DEBUG', 'D:/deoplete.log')
"call deoplete#custom#option('profile', v:true)