let g:python3_host_prog = 'C:\Users\akiya\AppData\Local\Programs\Python\Python37-32\python'

set clipboard=unnamed

"全角文字など、エラーにしたい空白文字の設定
augroup AdditionalHighlights
  autocmd!
  autocmd ColorScheme * highlight link ZenkakuSpace Error
  autocmd Syntax * syntax match ZenkakuSpace containedin=ALL /　/
augroup END

"@url POSIX互換関係の設定 http://tm.root-n.com/unix:command:git:operation:no_newline_at_end_of_file
set binary noeol

"タブ、行末、改行の可視設定
set listchars=tab:>\ ,trail:¬,extends:»,precedes:«
set list

set number
set cursorline

set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

"マークダウン用ファイル設定
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md hi Constant guifg=#fffe89

"キーアサイン
"矢印キー無効化
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
noremap E e
noremap i l
noremap I L

noremap j e
noremap J E

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

"キーアサイン
nnoremap <C-s> :w<CR>
noremap <C-l> :nohlsearch<CR><C-l>

noremap <C-p> :tabprevious<CR>
noremap <C-n> :tabnext<CR>

map <S-Insert> <C-R>*

"リーダー
let mapleader = "\<Space>"

noremap <leader>fi :Defx<CR>
noremap <leader>de :Denite file_rec<CR>
noremap <leader>so :so ~/AppData/Local/nvim/init.vim<CR>
noremap <leader>es :e ~/AppData/Local/nvim/init.vim<CR>

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

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

if dein#check_install()
    call dein#install()
endif

" プラグイン個別の設定

"Defx用キーマップ
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> i
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
endfunction


let g:ale_completion_enabled = 1

let g:deoplete#enable_at_startup = 1

"lightlineプラグインの設定 長いので常に末尾とする
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightLineModified',
        \   'readonly': 'LightLineReadonly',
        \   'fugitive': 'LightLineFugitive',
        \   'filename': 'LightLineFilename',
        \   'fileformat': 'LightLineFileformat',
        \   'filetype': 'LightLineFiletype',
        \   'fileencoding': 'LightLineFileencoding',
        \   'mode': 'LightLineMode'
        \ }
        \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"lightline end.