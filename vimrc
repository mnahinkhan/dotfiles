" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible



" Turn on syntax highlighting.
syntax on

" solarized color?
if strftime("%H") < 18 && strftime("%H") > 8
  set background=light
else
  set background=dark
endif
let g:solarized_termcolors=256
colorscheme solarized

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a"

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" EasyMotion bindings 
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

nmap f <Plug>(easymotion-fl)
xmap f <Plug>(easymotion-fl)

nmap F <Plug>(easymotion-Fl)
xmap F <Plug>(easymotion-Fl)

nmap t <Plug>(easymotion-tl)
xmap t <Plug>(easymotion-tl)

nmap T <Plug>(easymotion-Tl)
xmap T <Plug>(easymotion-Tl)


" Highlighting of characters beyond 79th character
autocmd FileType python match ErrorMsg '\%>79v.\+'
autocmd FileType c match ErrorMsg '\%>79v.\+'
autocmd FileType tex match ErrorMsg '\%>79v.\+'
autocmd FileType cpp match ErrorMsg '\%>79v.\+'
autocmd FileType markdown match ErrorMsg '\%>79v.\+'
autocmd FileType text match ErrorMsg '\%>79v.\+'

" Too-long-highlight enable and disable
nnoremap <silent> tlhe :hi ErrorMsg term=reverse cterm=reverse ctermfg=124 guifg=White guibg=Red<CR>
nnoremap <silent> tlhd :hi ErrorMsg None<CR>

" Start-up vimtex
autocmd FileType tex call vimtex#init()

" change comment strings
autocmd FileType python setlocal commentstring=#\ %s
autocmd FileType sh setlocal commentstring=#\ %s

nnoremap cs# :setlocal commentstring=#\ %s<CR>:echo "Comment string set to \"#\""<CR>
nnoremap cs" :setlocal commentstring=\"\ %s<CR>:echo "Comment string set to '\"'"<CR>
nnoremap cs/ :setlocal commentstring=/*\ %s\ */<CR>:echo "Comment string set to \"/*...*/\""<CR>


"vimtex plugin options
let g:vimtex_view_method='skim'

" Set the filetype based on the file's extension, overriding any
" 'filetype' that has already been set
au BufRead,BufNewFile *.s set filetype=ia64

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set expandtab
au BufRead,BufNewFile *.h set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set textwidth=79       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line

" make backspaces more powerfull
set backspace=indent,eol,start


" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile



" coc nvim stuff....
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" use <c-space>for trigger completion
inoremap <silent><expr> <NUL> coc#refresh()
"Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"for tagbar...
nmap <F8> :TagbarToggle<CR>

" for undotree
nnoremap <F5> :UndotreeToggle<CR>

"for nerdtree
nnoremap <C-t> :NERDTreeToggle<CR>

"change color of git-guttter
highlight! link SignColumn LineNr

"maybe comment this out 
let g:tex_flavor = 'latex'

"add spell checking for tex  files
autocmd BufRead,BufNewFile *.tex setlocal spell

" python syntax highlighting
let g:python_highlight_all = 1

" FZF integration
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap <C-P> :FZF<CR>

" make clipboard system wide
set clipboard^=unnamed


"test feature:
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename', ], [ 'tagbar' ] ]
      \ },
      \ 'component': {
      \         'tagbar': '%{tagbar#currenttag("%s", "", "f")}',
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode'}
      \ }
function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction
function! LightLineFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
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
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:coc_disable_startup_warning = 1
