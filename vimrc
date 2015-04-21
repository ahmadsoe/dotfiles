set nocompatible
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
call pathogen#helptags()

" change the mapleader from \ to
let mapleader=" "

" esc to jj
imap jj <Esc>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

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
set nowrap        " don't wrap lines"
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set number        " always show line numbers"
set relativenumber
set showmatch     " set show matching parenthesis"
set ignorecase    " ignore case when searching"
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch      " highlight search terms"
set incsearch     " show search matches as you type"
set splitright
set showcmd
set guioptions-=T " hide toolbar on gVim

set timeoutlen=1000 ttimeoutlen=0

set wildignore=*.swp,*.bak,*.pyc,*.class,tmp/**,dist/**,node_modules/**
set title                " change the terminal's title"
set visualbell           " don't beep"
set noerrorbells         " don't beep"

set nobackup
set noswapfile

" Save undo histories
set undolevels=1000
set undodir=~/.vim/undo
set undofile

" highlight tabs char
set list
set listchars=tab:>-

nnoremap ; :

" arrow key for resize
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>

" yank to the end
nnoremap Y y$

" save file with sudo
cmap w!! %!sudo tee > /dev/null %

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

set t_Co=256
colorscheme babymate256

set laststatus=2
let g:airline_theme = 'ubaryd'
let g:airline_section_y = ''
let g:airline_section_x = ''
let g:airline#extensions#hunks#enabled = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:ctrlp_match_func = {'match':'matcher#cmatch'}
" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore bower_components --ignore node_modules --ignore dist --ignore tmp -g ""'
  let g:ctrlp_use_caching = 0
endif

" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

let g:syntastic_filetype_map = { 'html.handlebars': 'handlebars' }

" mustache
let g:mustache_abbreviations = 1

" Gist config
let g:gist_detect_filetype = 1
let g:gist_post_private = 1

let g:SuperTabDefaultCompletionType = "<c-n>"

" Autoformat F3
noremap <F3> :Autoformat<CR><CR>

nnoremap <Esc><Esc> :nohlsearch<CR>

" find and replace
nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>

function! VisualFindAndReplace()
    :OverCommandLine%s/
    :w
endfunction

function! VisualFindAndReplaceWithSelection() range
    :'<,'>OverCommandLine s/
    :w
endfunction

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
command MarkdownPreview InstantMarkdownPreview

let g:user_emmet_install_global = 0
autocmd FileType html,hbs,html.handlebars,css,scss EmmetInstall
let g:user_emmet_leader_key='<C-E>'
