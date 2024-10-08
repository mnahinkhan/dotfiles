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
if strftime("%H") < 18 && strftime("%H") > 6
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

" Danke to
" https://stackoverflow.com/questions/76863960/mouse-scrolling-clicking-in-vim-v9-stopped-working-with-no-changes-to-vimrc
" Allow using the mouse to resize windows
"set ttymouse=xterm2


" Keep window split thin
" https://vi.stackexchange.com/questions/2938/can-the-split-separator-in-vim-be-less-than-a-full-column-wide
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE

"Configure ALE Fixers
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort', 'black'],
\   'javascript': ['prettier', 'eslint'],
\   'r': ['styler'],
\   'html': ['prettier'],
\   'css': ['stylelint', 'prettier'],
\}

" Trying something
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>


imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


" Set the window minimum width
set winwidth=79


" Set the leader
nnoremap <SPACE> <Nop>
let mapleader=" "

" Map Leader s to git blame status line
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
"


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

" nmap f <Plug>(easymotion-fl)
" xmap f <Plug>(easymotion-fl)

" nmap F <Plug>(easymotion-Fl)
" xmap F <Plug>(easymotion-Fl)

" nmap t <Plug>(easymotion-tl)
" xmap t <Plug>(easymotion-tl)

" nmap T <Plug>(easymotion-Tl)
" xmap T <Plug>(easymotion-Tl)

" Highlight trailing white space (https://stackoverflow.com/a/4617156/8551394)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


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

nnoremap ccs# :setlocal commentstring=#\ %s<CR>:echo "Comment string set to \"#\""<CR>
nnoremap ccs" :setlocal commentstring=\"\ %s<CR>:echo "Comment string set to '\"'"<CR>
nnoremap ccs/ :setlocal commentstring=/*\ %s\ */<CR>:echo "Comment string set to \"/*...*/\""<CR>


" Fold using indents
set foldmethod=indent
set foldlevelstart=99


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
" set textwidth=79       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line

" Indent soft wrapped text
" https://stackoverflow.com/a/26015800/8551394
set breakindent

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

" Change cursor during insert mode
" (https://stackoverflow.com/questions/6488683/how-do-i-change-the-cursor-between-normal-and-insert-modes-in-vim)
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
" hi CursorLine cterm=NONE ctermbg=black
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" Highlight yank duration in milliseconds
let g:highlightedyank_highlight_duration = 100


" coc nvim updates
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A


" coc nvim stuff....
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction


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

"add spell checking for tex, txt, md files
autocmd BufRead,BufNewFile *.tex setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.py setlocal spell

hi SpellBad cterm=underline

" python syntax highlighting
let g:python_highlight_all = 1

" FZF integration
set rtp+=/usr/local/opt/fzf
set rtp+=~/.linuxbrew/opt/fzf
set rtp+=~/.fzf
nmap <C-P> :FZF<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-f> :Rg<CR><C-P>

" make clipboard system wide
set clipboard^=unnamed

" Try snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Manage coc extensions
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-jedi',
      \ 'coc-r-lsp',
      \ 'coc-snippets',
\ ]

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
