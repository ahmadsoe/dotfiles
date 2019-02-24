call plug#begin('~/.vim/plugged')

  Plug 'mhartington/oceanic-next'
  Plug 'itchyny/lightline.vim'

  Plug 'sheerun/vim-polyglot'
  Plug 'Raimondi/delimitMate'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'Chiel92/vim-autoformat'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'joukevandermaas/vim-ember-hbs'
  Plug 'Galooshi/vim-import-js'

  Plug 'lambdalisue/suda.vim'
  Plug 'mileszs/ack.vim'
  " Plug 'brooth/far.vim'

  Plug 'mileszs/ack.vim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rails'
  Plug 'unifieddialog/vim-rspec-focus'

  Plug 'unblevable/quick-scope'
  Plug 'tmhedberg/matchit'
  Plug 'vim-scripts/ruby-matchit'

  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-unimpaired'
  Plug 'osyo-manga/vim-over'
  Plug 'bkad/CamelCaseMotion'
  Plug 'kana/vim-textobj-line'
  Plug 'kana/vim-textobj-user'
  Plug 'rhysd/vim-textobj-ruby'
  Plug 'wellle/targets.vim'
  Plug 'terryma/vim-expand-region'
  Plug 'haya14busa/incsearch.vim'
  Plug 'matze/vim-move'

  Plug 'majutsushi/tagbar'
  Plug 'farmergreg/vim-lastplace'
  Plug 'ervandew/screen'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-eunuch'
  Plug 'csexton/trailertrash.vim'

  Plug 'scrooloose/nerdtree'
  Plug '/usr/share/fzf'
  Plug 'junegunn/fzf.vim'

  Plug 'w0rp/ale'
  Plug 'maximbaz/lightline-ale'
  Plug 'slashmili/alchemist.vim'

  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'

  Plug 'editorconfig/editorconfig-vim'
  Plug 'mhinz/vim-mix-format'

  Plug 'ludovicchabant/vim-gutentags'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  Plug 'suan/vim-instant-markdown'
  Plug 'xolox/vim-misc'
  Plug 'lifepillar/vim-cheat40'

  " Always load the vim-devicons as the very last one.
  Plug 'ryanoasis/vim-devicons'
call plug#end()

set nocompatible
set hidden
syntax on
filetype plugin indent on

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set cindent
set nowrap
set backspace=indent,eol,start
set number
set relativenumber
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch
set splitright
set splitbelow
set showcmd
set guioptions-=T
set textwidth=80
set colorcolumn=+1
set title
set visualbell
set noerrorbells
set nobackup
set noswapfile
set timeoutlen=1000 ttimeoutlen=0
set wildignore=*.swp,*.bak,*.pyc,*.class,tmp/**,dist/**,node_modules/**
set tags=./tags;
set undolevels=1000
set undodir=~/.vim/undo//
set undofile
set clipboard=unnamedplus
set updatetime=750

" highlight tabs char
set list
set listchars=tab:>-

set t_Co=256
set guifont=DroidSansMono\ Nerd\ Font\ 11

" Theme
set termguicolors
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

set laststatus=2

let g:mapleader=' '

nnoremap s <Nop>
nnoremap Q <Nop>

imap <C-J> <CR>

nmap j gj
nmap k gk

nnoremap <BS> <C-^>

nnoremap ; :
vnoremap ; :

" arrow key for resize
map <Left> :vertical resize +3<CR>
map <Right> :vertical resize -3<CR>
map <Up> :resize +3<CR>
map <Down> :resize -3<CR>

" disable key on insert Mode
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <CR> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Del> <NOP>

" yank to the end
nnoremap Y v$y

" paste multiple times
xnoremap p pgvy

nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader><Leader> :Files<CR>
nnoremap <Leader>o :echo "use [leader][leader]"<CR>
nnoremap <Leader>i :Buffers<CR>

vmap v <Plug>(expand_region_expand)

nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)

let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)

augroup incsearch-keymap
  autocmd!
  autocmd VimEnter * call s:incsearch_keymap()
augroup END

function! s:incsearch_keymap()
  IncSearchNoreMap <Tab> <Over>(buffer-complete)
  IncSearchNoreMap <S-Tab> <Over>(buffer-complete-prev)
endfunction

" find and replace
nnoremap <Leader>fr :OverCommandLine s/<CR>
nnoremap <Leader>fR :OverCommandLine%s/<CR>
xnoremap <Leader>fr :'<,'>OverCommandLine s/<CR>

map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e

nmap ]g :GitGutterNextHunk<CR>
nmap [g :GitGutterPrevHunk<CR>
augroup VimDiff
  autocmd!
  autocmd VimEnter,FilterWritePre * if &diff | GitGutterDisable | endif
augroup END

" ALE
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_linter_aliases = {'html': []} " TODO
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_echo_msg_format = '%linter%: %s '

nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

let g:lightline#ale#indicator_checking = '...'

let g:lightline = {
      \ 'colorscheme': 'oceanicnext',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']],
      \   'right': [['lineinfo'], ['filetype', 'percent'], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \ }
    \ }

augroup VimDiff
  autocmd!
  autocmd VimEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END

let g:ackprg = 'rg --vimgrep --no-heading'

autocmd BufNewFile,BufReadPost *.example set filetype=sh
autocmd FileType ruby nnoremap <Leader>f :ToggleFocusTag<CR>
autocmd FileType ruby nnoremap <Leader>d orequire'pry';binding.pry<esc>:w<cr>
autocmd FileType ruby nnoremap <Leader>W :w<CR> :call ScreenShellSend("load '".@%."';")<CR>

let g:fzf_layout = { 'down': '~40%' }
let g:fzf_nvim_statusline = 0

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd -t f' : printf('fd -t f | proximity-sort %s', expand('%'))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

fun! s:SwitchProject(work_dir)
  execute 'Explore' a:work_dir
  execute 'cd' a:work_dir
endfun

command! -nargs=0 Projects
      \ call fzf#run(fzf#wrap('projects', {
      \   'source': 'find ~/Code -maxdepth 2 -name .git -printf "%h\n"',
      \   'sink': function('s:SwitchProject'),
      \   'options': '-m --prompt "Projects> "',
      \}, <bang>0))

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

let g:deoplete#enable_at_startup = 1
let g:gutentags_file_list_command = 'rg --files'

let g:alchemist_tag_disable = 1

nnoremap sj :SplitjoinSplit<CR>
nnoremap sk :SplitjoinJoin<CR>

let g:splitjoin_handlebars_closing_bracket_on_same_line = 1

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" mustache
let g:mustache_abbreviations = 1

command! SudoWrite write suda://%

autocmd FileType javascript silent! nnoremap <buffer> <unique> <silent> <Leader>r :ImportJSWord<CR>
autocmd FileType css command! SortCSS :g#\({\n\)\@<=#.,/}/sort
autocmd FileType scss command! SortSCSS :g#\({\n\)\@<=#.,/\.*[{}]\@=/-1 sort

let g:EditorConfig_core_mode = 'external_command'

let NERDTreeHijackNetrw = 0

let g:delimitMate_expand_space = 1

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
command! MarkdownPreview InstantMarkdownPreview

call expand_region#custom_text_objects({
      \ 'ia' :0,
      \ 'aa' :0,
      \ })

call expand_region#custom_text_objects('ruby', {
      \ 'ir' :0,
      \ 'ar' :0,
      \ 'im' :0,
      \ 'am' :0,
      \ })

function! s:maximizeWindow()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>maximizeWindow()<cr>

let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'html.handlebars': 1,
    \ 'xml' : 1
    \}
