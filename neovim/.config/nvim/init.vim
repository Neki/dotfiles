" Basic settings
set nocompatible              " Eliminate backwards-compatability
set number                    " Enable line numbers
set ruler                     " Turn on the ruler
syntax on                     " Syntax highlighting
set ttyfast
set clipboard=unnamedplus
set splitbelow
set splitright
set hidden
set ttimeoutlen=0
set shiftround
set tags=./tags;
set mouse=a

" expand tabs by default
set expandtab
set shiftwidth=4

if has('nvim')
  set inccommand=split
endif

syntax enable
filetype plugin indent on

set undofile
set formatoptions="jcroql"

augroup filetypes
  autocmd!
  au BufRead,BufNewFile *.json set filetype=json
  au BufRead,BufNewFile *.yml.example set filetype=yaml
augroup END

set backspace=indent,eol,start
set textwidth=110

" Mappings

" Remap the <Leader> key to ,
let mapleader = ","
" and keep , somewhere else
nnoremap , -

" Open tig in a new shell
command! Gt silent !i3-msg exec "urxvt -e $SHELL -c \"cd $PWD && tig status\"" >/dev/null 2>&1
command! Gk !gitk --all

" :To git log %
command! -nargs=1 To silent !i3-msg exec "urxvt -e $SHELL -c \"cd $PWD && <args> \"" >/dev/null 2>&1

" paste last yanked text with <Leader>p
nnoremap <Leader>p "0p

" Remove trailing spaces on save, or with the sequence 'tws'
function! TrimWhiteSpace()
  if &modifiable
    %s/\s\+$//e
  endif
endfunction

nnoremap <silent> <Leader>tws :call TrimWhiteSpace()<CR>
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" I do not use ( and ), so use these two keys instead with vim-unimpaired
" (French keyboard layout)
nmap ( [
nmap ) ]
omap ( [
omap ) ]
xmap ( [
xmap ) ]

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe', { 'do': './install --racer-completer --tern-completer' }
Plug 'tomtom/tcomment_vim'
Plug 'xolox/vim-misc'
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'majutsushi/tagbar'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'
Plug 'mbbill/undotree'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'gioele/vim-autoswap'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/sideways.vim'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'sgur/vim-textobj-parameter'
Plug 'tommcdo/vim-exchange'
Plug 'michaeljsmith/vim-indent-object'
Plug 'henrik/vim-indexed-search'
Plug 'gcmt/taboo.vim'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'justinmk/vim-sneak'
Plug 'chase/vim-ansible-yaml', { 'for': 'ansible' }
Plug 'bps/vim-textobj-python', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'romainl/Apprentice'
" Haskell
" Plug 'bitc/lushtags', { 'for': 'haskell' }
" Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
" Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
" To make the Haskell plugins work:
" Install the Haskell platform: sudo apt-get install haskell-platform
" Update cabal-install: cabal install cabal-install
" Update pkg list: cabal update
" Install required packages: cabal install ghc-mod hdevtools lushtags

call plug#end()

" Color theme (using vim-plug for download)
colorscheme apprentice
hi clear VertSplit
:set fillchars+=vert:│

" vim-airline
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_theme='minimalist'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.crypt = 'c'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '↯'
let g:airline_symbols.paste = 'ρ'

" Neomake
autocmd! BufWritePost * Neomake
"highlight ErrorSign ctermbg=black ctermfg=red
let g:neomake_error_sign = {
            \ 'text': '✗',
            \ 'texthl': 'ErrorSign',
            \ }
let g:neomake_warning_sign = {
            \ 'text': '⚠',
            \ 'texthl': 'ErrorSign',
            \ }

" taglist
map <C-b> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_autofocus = 1

" Undotree
nnoremap U :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1

" CtrlSF
nnoremap <C-S-F> :CtrlSF<Space>

" neco-ghc
let g:ycm_semantic_triggers = {'haskell' : ['.']}

" ghcmod-vim
au BufRead,BufNewFile *.hs nnoremap <Leader>Ht :GhcModType<CR>
au BufRead,BufNewFile *.hs nnoremap <Leader>Hc :GhcModTypeClear<CR>

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = 'python'

" Tabular
if exists(":Tabularize")
  nnoremap <Leader>a= :Tabularize /=<CR>
  vnoremap <Leader>a= :Tabularize /=<CR>
  nnoremap <Leader>a: :Tabularize /:\zs<CR>
  vnoremap <Leader>a: :Tabularize /:\zs<CR>
endif

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"

" delimitMate
let g:delimitMate_expand_cr = 1

" sideways
nnoremap <Leader>( :SidewaysLeft<CR>
nnoremap <Leader>) :SidewaysRight<CR>



" temp
let errfor =
    \ '%E%f:%l: could not compile,%-Z%p^,' .
    \ '%A%f:%l:%c: %t%n %m,' .
    \ '%A%f:%l: %t%n %m,' .
    \ '%-G%.%#'
let g:neomake_flake8_maker = {
    \ 'exe': 'flake8',
    \ 'args': ['.'],
    \ 'errorformat': errfor
    \ }

" terminal
" use jk instead, so programs inside can receive Esc
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif
let g:neoterm_position = 'vertical'
nnoremap <silent> <Leader>th :Tclose<cr>
nnoremap <silent> <Leader>tr :TREPLSend<CR>
nnoremap <silent> <Leader>tf :TREPLSendFile<CR>

inoremap jk <Esc>
"tnoremap jk  <C-\><C-n>

nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>

tmap <silent> <A-k> <C-\><C-n>:wincmd k<CR>
tmap <silent> <A-j> <C-\><C-n>:wincmd j<CR>
tmap <silent> <A-h> <C-\><C-n>:wincmd h<CR>
tmap <silent> <A-l> <C-\><C-n>:wincmd l<CR>

nnoremap <C-L> :nohl<CR><C-L>

nmap <Leader>l :TabooOpen<space>

set wildmenu
set wildmode=list:longest,list:full

" Nerdtree
let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'egg-info$']
nnoremap <Space>E :NERDTreeToggle<CR>

function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction

nnoremap <Space>e :call NERDTreeToggleInCurDir()<cr>

"" FZF
nnoremap <Space>f :Files<CR>
nnoremap <Space>b :Buffers<CR>
nnoremap <Space>l :BLines<CR>
nnoremap <Space>L :Lines<CR>
nnoremap <Space>h :History<CR>
" outline
nnoremap <Space>o :BTags<CR>
nnoremap <Space>t :Tags<CR>
let g:fzf_commits_log_options = '--color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'


" yankstack
nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-P> <Plug>yankstack_substitute_newer_paste
let g:yankstack_yank_keys = ['y', 'd']

nnoremap <C-n> <C-^>