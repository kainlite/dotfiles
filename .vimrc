"" vim:set ts=2 sts=2 sw=2 expandtab:
"" This is kainlite vimrc

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

if filereadable(expand("~/.vimrc.bundles"))
  call plug#begin('~/.vim/plugged')
  source ~/.vimrc.bundles
  call plug#end()
endif

"" Load configs and bundles
if filereadable(expand("~/.vimrc.plugins"))
  source ~/.vimrc.plugins
endif

" Set encoding if available
if has('multi_byte')
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Set spellcheck
if has('spell')
  set spelllang=en_us
  nnoremap _s :set spell!<CR>
endif

if !exists('g:fugitive_git_executable')
  let g:fugitive_git_executable='LC_ALL=en_US git'
endif

if exists('+writebackup')
  set nobackup
  set writebackup
endif

" Tell vim to remember certain things when we exit
"  '50  :  marks will be remembered for up to 10 previously edited files
"  "1000 :  will save up to 100 lines for each register
"  :200  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
if has('nvim')
  set viminfo='50,\"1000,:200,%,n~/.nviminfo
else
  set viminfo='50,\"1000,:200,%,n~/.viminfo
endif

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost make nested copen
augroup END

set dictionary="/usr/dict/words"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set cindent
set smartindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set number
set nobomb
set nofoldenable
set modifiable
set nomodeline
" Ask to reload changes if there are external modifications
set autoread

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
set numberwidth=2
set showtabline=2
set winwidth=79
set ttimeoutlen=50
set conceallevel=0

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

set shell=zsh
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=/var/tmp,/tmp
set directory=/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype indent on
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
noremap <leader>s :update<CR>

" Yank directly to the clipboard
map <C-C> :%y+<CR>

" Move between the quicklist files
map <F11> :cp<CR>
map <F12> :cn<CR>

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set completeopt=menu,preview,noselect,noinsert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
let g:rehash256 = 1
colorscheme gruvbox

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=%#CursorColumn#
set statusline+=\ %F
set statusline+=\ (%{&ft})
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \>\ %{coc#status()}
set statusline+=\ %{get(b:,'coc_current_function','')}
set statusline+=\ %h%m%r%=%-14.(%l,%c%V%)\ %P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default move with display lines
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

imap <c-c> <esc>

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction

nnoremap <leader><leader> <c-^>
nnoremap <leader>. :nohlsearch<cr>
nnoremap _ts :silent !tmux set status<CR>

" for linux and windows users (using the control key)
map <c-a> gT
map <c-s> gt

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable arrow keys in command and visual mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Autocall and key binding
autocmd BufWritePre *.rb,*.erb,*.py,*.js,*.html,*.txt,*.csv,*.tsv,*.jsx,*.ex,*.eex,* call <SID>StripTrailingWhitespaces()
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
nnoremap <silent> <F5> :Format<CR>
autocmd FileType * set tabstop=2|set shiftwidth=2|set expandtab

" Strip annoying whitespaces
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  set modifiable
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
  retab
endfunction

map <leader>t :tabedit<Space>
map <leader>v :vsplit<Space>
map <leader>h :split<Space>

map <leader>p :%!python -m json.tool<cr>

" set mode paste in insert mode and line number
set pastetoggle=<C-b>
noremap <leader>n :set paste<CR>:put  *<CR>:set nopaste<CR>
nnoremap <leader>b :set number!<CR>

" Move lines
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

" duplicate line, preserve cursor
noremap <C-d> mzyyp`z

" Force save
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Invisibles characters setup
nmap <Leader>L :set list!<CR>
set listchars=tab:▸\ ,eol:¬
autocmd VimEnter * :IndentGuidesEnable

" Fix arrows for vim
if &term =~ '^screen' && exists('$TMUX')
  set mouse+=a
  " tmux knows the extended mouse mode
  " set ttymouse=xterm2
  " tmux will send xterm-style keys when xterm-keys is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
  map <Esc>OH <Home>
  map! <Esc>OH <Home>
  map <Esc>OF <End>
  map! <Esc>OF <End>
  execute "set <Insert>=\e[2;*~"
  execute "set <Delete>=\e[3;*~"
  execute "set <PageUp>=\e[5;*~"
  execute "set <PageDown>=\e[6;*~"
  execute "set <xF1>=\e[1;*P"
  execute "set <xF2>=\e[1;*Q"
  execute "set <xF3>=\e[1;*R"
  execute "set <xF4>=\e[1;*S"
  execute "set <F5>=\e[15;*~"
  execute "set <F6>=\e[17;*~"
  execute "set <F7>=\e[18;*~"
  execute "set <F8>=\e[19;*~"
  execute "set <F9>=\e[20;*~"
  execute "set <F10>=\e[21;*~"
  execute "set <F11>=\e[23;*~"
  execute "set <F12>=\e[24;*~"
endif

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

imap <C-f> <C-x>

call MapCR()
