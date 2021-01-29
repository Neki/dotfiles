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
set tags=./.tags;
set mouse=a

" expand tabs by default
set expandtab
set shiftwidth=4
set tabstop=4
augroup filetypes
  autocmd!
  au BufRead,BufNewFile *.json set filetype=json
  au BufRead,BufNewFile *.yml.example set filetype=yaml
augroup END
augroup whitespace
  au Filetype go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
augroup END


set foldmethod=indent
set foldlevelstart=40

nnoremap <C-n> <C-^>

" recursive search with :find, gf...
" I don't do much C, so remove /usr/include from path too
set path=.,,**

if has('nvim')
  set inccommand=split
endif

syntax enable
filetype plugin indent on

set undofile
set formatoptions="jcroql"

set backspace=indent,eol,start
set textwidth=110

" Mappings

" Remap the <Leader> key to ,
let mapleader = ","
" and keep , somewhere else
nnoremap , -

" Open tig in a new shell
command! Gt silent !i3-msg exec "gnome-terminal -x $SHELL -c \"cd $PWD && tig status\"" >/dev/null 2>&1

" paste last yanked text with <Leader>p
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

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

" assume pynvim is installed globally
let g:python3_host_prog = '/usr/bin/python3'


" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" TODO try to make that usable, or remove it
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'Raimondi/delimitMate'
Plug 'mbbill/undotree'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'gioele/vim-autoswap'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/sideways.vim'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'sgur/vim-textobj-parameter'
Plug 'lucapette/vim-textobj-underscore'
Plug 'michaeljsmith/vim-indent-object'
Plug 'gcmt/taboo.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'justinmk/vim-sneak'
Plug 'romainl/Apprentice'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/vim-easy-align'
Plug 'rhysd/devdocs.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
" language specific plugins
" Python
Plug 'bps/vim-textobj-python', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'psf/black'
" Frontend (JS & co)
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
" Infra-as-code
Plug 'chase/vim-ansible-yaml', { 'for': 'ansible' }
Plug 'hashivim/vim-terraform'
" Rust
Plug 'rust-lang/rust.vim'
" Various
Plug 'Glench/Vim-Jinja2-Syntax'
" JS
Plug 'storyn26383/vim-vue'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'mgedmin/python-imports.vim', { 'for': 'python' }

call plug#end()

" yankstack
nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-P> <Plug>yankstack_substitute_newer_paste
let g:yankstack_yank_keys = ['y', 'd', 'Y', 'D']

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

" tagbar
map <C-b> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_autofocus = 1

" Undotree
nnoremap U :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1

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
let g:ycm_rust_src_path = '/home/bfaucon/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"

" delimitMate
let g:delimitMate_expand_cr = 1

" sideways
nnoremap <Leader>( :SidewaysLeft<CR>
nnoremap <Leader>) :SidewaysRight<CR>


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
" mnemonic: outline
nnoremap <Space>o :BTags<CR>
nnoremap <Space>t :Tags<CR>
nnoremap <Space>S :Snippets<CR>
let g:fzf_commits_log_options = '--color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
nnoremap <Leader>gf :call fzf#vim#files(getcwd(), {"options": "-q" . expand('<cword>') })<CR>

" nnoremap :SnippetsEdit :CocCommand snippets.editSnippets
xmap <leader>x  <Plug>(coc-convert-snippet)
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" vim-easy-align
" ga is mapped to :ascii by default in Vim, which I've never used
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" devdocs
" (note that K is already overriden by the coc plugin)
nmap <leader>k <Plug>(devdocs-under-cursor)

" Terraform
au BufNewFile,BufRead *.hcl set filetype=terraform
let g:terraform_fmt_on_save=1
let g:terraform_align=1
au BufWritePre *.hcl TerraformFmt

" Ansible
nnoremap <Leader>a :let @a = system("ansible-vault encrypt_string --vault-id ~/ansible_vault_password " . getline("."))<CR>"ap<CR>

" CtrlSF
let g:ctrlsf_position = 'right'

" Vue
let g:vue_disable_pre_processors=1

" Prettier
" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" Gutentags
let g:gutentags_cache_dir = '~/.local/share/nvim/tags'
"let g:gutentags_ctags_tagfile = ".tags"

" Python imports
nnoremap <leader>i :ImportName<CR>:%!isort -<CR>
nnoremap <leader>I :%!isort -<CR>

" Track current directory, system-wide
" Used by .zshrc (or similar) when a new shell is opened
autocmd FocusGained * call writefile([getcwd()], "/home/benoit/.cwd")
autocmd DirChanged * call writefile([getcwd()], "/home/benoit/.cwd")


" ======================= COC ============================
" Avoid triggering full rebuilds for some language servers
" see https://github.com/neoclide/coc.nvim/issues/649
" set backupdir=~/.local/share/nvim/backup
set nobackup
set nowritebackup
" Give more space for displaying messages. Less useful now that we have tooltips.
" set cmdheight=2

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocFzfList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>x  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocFzfList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>O  :<C-u>CocFzfList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocFzfList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Remap <C-d> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Remap for rename current word
nnoremap <leader>rn <Plug>(coc-rename)
" Run action
nnoremap <leader>ca :<C-u>CocAction<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" go + coc (format on save using golsp)
au BufWritePre *.go :Format

" ======================= COC (end) ============================

" CtrlSF
 nnoremap <C-S-F> :<C-u>CtrlSF<space>
