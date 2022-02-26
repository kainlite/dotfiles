" vim:set ts=2 sts=2 sw=2 expandtab:
" This is kainlite vimrc

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" Load bundles
if filereadable(expand("~/.vimrc.bundles"))
    call plug#begin('~/.vim/plugged')
    source ~/.vimrc.bundles
    call plug#end()
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

" Truffle
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost make nested copen
augroup END

let test#custom_runners = {'Solidity': ['Truffle']}
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
set tabstop=4
set shiftwidth=4
set softtabstop=4
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

" This makes RVM work inside Vim. I have no idea why.
set shell=zsh
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=
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
" filetype plugin indent on
filetype indent on
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

" Elm format on save
let g:elm_format_autosave = 1

" Disable scratch window for omnicompletion
set completeopt-=preview

" Elixir format
let g:mix_format_on_save = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clear all autocmds in the group
autocmd Filetype * set sw=2 sts=2  ts=2 tw=0 et

"for ruby, autoindent with two spaces, always expand tabs
autocmd FileType rb,ruby,haml,eruby,yml,yaml,html,tmpl,javascript,sass,cucumber,js,jsx,ex,eex set ai sw=2 sts=2 et

autocmd FileType rs,c,cpp set ai tabstop=2 softtabstop=2 shiftwidth=2 et
autocmd FileType python set sw=2 sts=2 et
autocmd Filetype prolog set syntax=prolog et

autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufNewFile,BufRead *.jsx set filetype=javascript
autocmd! BufRead,BufNewFile *.sass setfiletype sass

autocmd bufRead elm set sw=4 ts=4 et

autocmd BufRead mkd  set ai formatoptions=tcroqn2 comments=n:&gt; et
autocmd BufRead markdown  set ai formatoptions=tcroqn2 comments=n:&gt; et
autocmd Filetype txt set tw=0 noet

autocmd Filetype json set filetype=js sw=2 ts=2 et
autocmd Filetype jsonnet set filetype=js sw=2 ts=2 et
autocmd Filetype libjsonnet set filetype=js sw=2 ts=2 et

autocmd BufNewFile,BufRead *.prawn setf ruby et

autocmd BufNewFile,BufRead *.fe,*.rs set filetype=rust et

autocmd BufNewFile,BufRead *.sol set filetype=solidity sw=2 ts=2 et

au BufRead,BufNewFile *.gotpl,*.gohtml set filetype=gohtmltmpl et

autocmd FileType elixir setlocal formatprg=mix\ format\ -

autocmd FileType make set sw=2 sts=2 noet

" For everything else use this default to prevent the tab _casqueada_
autocmd Filetype * set sw=2 sts=2 ts=2 tw=0 et

autocmd BufReadPost quickfix setlocal modifiable
              \ | silent exe 'g/^/s//\=line(".")." "/'

autocmd BufRead * retab

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
:set statusline=%<%f\ (%{&ft})\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default move with display lines
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Can't be bothered to understand ESC vs <c-c> in insert mode
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
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Autocall and key binding
autocmd BufWritePre *.rb,*.erb,*.py,*.js,*.html,*.txt,*.csv,*.tsv,*.jsx,*.ex,*.eex,* call <SID>StripTrailingWhitespaces()
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
nnoremap <F6> :UndotreeToggle<CR>

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

" autocmd VimEnter * NERDTree
" autocmd BufWinEnter * NERDTreeMirror
let NERDTreeMapOpenInTab='<ENTER>'

map <leader>r :NERDTree<cr> :NERDTreeMirror<cr>
map <leader>c :NERDTreeClose<cr>
map <leader>t :tabedit<Space>
map <leader>v :vsplit<Space>
map <leader>h :split<Space>
map <leader>a :A<cr>
map <leader>z :R<cr>
map <leader>g :GoRun<cr>
map <leader>m :GoBuild<cr>
map <leader>gt :GoTest<cr>

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

" Convenient maps for vim-fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gp :Git push<CR>

" Force save
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Invisibles characters setup
nmap <Leader>L :set list!<CR>
set listchars=tab:▸\ ,eol:¬
autocmd VimEnter * :IndentGuidesEnable

" Toggler
nmap <script> <silent> <leader>w :call ToggleQuickfixList()<CR>

" Auto generate imports go on save
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1

" Surround shortcuts
map <Leader>y <Plug>Yssurround=<cr>
map <Leader>i <Plug>Yssurround-<cr>
map <leader># ysiw#
imap <C-c> <CR><Esc>O

autocmd FileType ruby let b:surround_35 = "#{\r}"
autocmd FileType eruby let b:surround_35 = "#{\r}"

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

let $JS_CMD='node'

nmap <Leader>f= :Tabularize /=<CR>
vmap <Leader>f= :Tabularize /=<CR>
nmap <Leader>f :Tabularize /:\zs<CR>
vmap <Leader>f :Tabularize /:\zs<CR>

" Enable auto-fmt for rust files
let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
let g:racer_no_default_keymappings = 1

nmap <leader>def <Plug>(rust-def-vertical)
nmap <leader>doc <Plug>(rust-doc-vertical)

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_maker = {
    \ 'args': ['--format', 'compact', '--fix'],
    \ 'errorformat': '%f: line %l\, col %c\, %m'
    \ }

augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished :checktime
augroup END

let g:coc_global_extensions = ['coc-elixir', 'coc-diagnostic', 'coc-tsserver']

let g:ElixirLS = {}
let ElixirLS.path = stdpath('config').'/plugged/elixir-ls'
let ElixirLS.lsp = ElixirLS.path.'/release/language_server.sh'
let ElixirLS.cmd = join([
        \ 'cp .release-tool-versions .tool-versions &&',
        \ 'asdf install &&',
        \ 'mix do',
        \ 'local.hex --force --if-missing,',
        \ 'local.rebar --force,',
        \ 'deps.get,',
        \ 'compile,',
        \ 'elixir_ls.release &&',
        \ 'rm .tool-versions'
        \ ], ' ')

function ElixirLS.on_stdout(_job_id, data, _event)
  let self.output[-1] .= a:data[0]
  call extend(self.output, a:data[1:])
endfunction

let ElixirLS.on_stderr = function(ElixirLS.on_stdout)

function ElixirLS.on_exit(_job_id, exitcode, _event)
  if a:exitcode[0] == 0
    echom '>>> ElixirLS compiled'
  else
    echoerr join(self.output, ' ')
    echoerr '>>> ElixirLS compilation failed'
  endif
endfunction

function ElixirLS.compile()
  let me = copy(g:ElixirLS)
  let me.output = ['']
  echom '>>> compiling ElixirLS'
  let me.id = jobstart('cd ' . me.path . ' && git pull && ' . me.cmd, me)
endfunction

" If you want to wait on the compilation only when running :PlugUpdate
" then have the post-update hook use this function instead:

" function ElixirLS.compile_sync()
"   echom '>>> compiling ElixirLS'
"   silent call system(g:ElixirLS.cmd)
"   echom '>>> ElixirLS compiled'
" endfunction


" Then, update the Elixir language server
call coc#config('elixir', {
  \ 'command': g:ElixirLS.lsp,
  \ 'filetypes': ['elixir', 'eelixir']
  \})
call coc#config('elixir.pathToElixirLS', g:ElixirLS.lsp)

augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished :checktime
augroup END

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set cmdheight=1
set completeopt=longest,menuone

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

nnoremap <silent> K :call CocAction('doHover')<CR>
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nmap <leader>do <Plug>(coc-codeaction)

imap <C-f> <C-x>

call neomake#configure#automake('w')

call MapCR()

function! InstallCocPlugins()
  :call coc#util#install_extension(["coc-json", "coc-prettier", "coc-snippets", "coc-tabnine", "coc-tsserver", "coc-ultisnips", "coc-rls", "coc-rust-analyzer"])
endfunction

lua << EOF
require'lspconfig'.solang.setup{}
EOF
