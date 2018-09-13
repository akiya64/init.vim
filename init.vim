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
set listchars=tab:»-,trail:¬,extends:»,precedes:«
set list

"ハイライト設定 全角をエラーとする設定後に記載すること
colorscheme Soifon
set number
set cursorline

"タブの設定
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"マークダウン用ファイル設定
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md hi Constant guifg=#fffe89

"キーアサイン
noremap <C-l> :nohlsearch<CR><C-l>

imap <S-Insert> <C-R>*

"キーアサイン
"矢印キー無効化
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Up> <nop>
noremap <Down> <nop>

cmap <Up> <nop>
cmap <Down> <nop>

"移動設定 Colemak対応 hはQWERTYと同じ

noremap n j
noremap N J
noremap e k
nnoremap i l
nnoremap I L

noremap l i
noremap L I

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

"Defx用キーマップ
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> i
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

"リーダー
let mapleader = "\<Space>"

noremap <leader>fi :vs<CR>:Defx<CR>
noremap <leader>de :Denite file_rec<CR>

"qargs.vim 実践VIMより
command! -nargs=0 -bar Qargs execute 'args' Quickfixfilenames()
function! Quickfixfilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
      let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

"プラグイン設定
" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on

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