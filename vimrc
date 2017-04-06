set nocompatible
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
call pathogen#helptags()

" change the mapleader from \ to space
let mapleader=" "

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
set textwidth=80
set colorcolumn=+1
set timeoutlen=1000 ttimeoutlen=0
set wildignore=*.swp,*.bak,*.pyc,*.class,tmp/**,dist/**,node_modules/**
set title                " change the terminal's title"
set visualbell           " don't beep"
set noerrorbells         " don't beep"
set nobackup
set noswapfile

set tags=./tags;

" Save undo histories
set undolevels=1000
set undodir=~/.vim/undo
set undofile

" highlight tabs char
set list
set listchars=tab:>-

set t_Co=256
colorscheme babymate256

" transparent background
hi Normal ctermbg=none
hi NonText ctermbg=none

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

" esc to jk and disable esc
inoremap jk <Esc>
inoremap JK <Esc>A

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" arrow key for resize
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>

" disable key on insert Mode
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <CR> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Bs> <NOP>
inoremap <Del> <NOP>

" yank to the end
nnoremap Y v$y

" paste multiple times
xnoremap p pgvy

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader><Leader> V

" Rails & ember
nnoremap <Leader>ga :CtrlP app/assets<CR>
nnoremap <Leader>gc :CtrlP app/controllers<CR>
nnoremap <Leader>gh :CtrlP app/helpers<CR>
nnoremap <Leader>gm :CtrlP app/models<CR>
nnoremap <Leader>gn :CtrlP app/components<CR>
nnoremap <Leader>gr :CtrlP app/routes<CR>
nnoremap <Leader>gs :CtrlP app/styles<CR>
nnoremap <Leader>gt :CtrlP app/templates<CR>
nnoremap <Leader>gv :CtrlP app/views<CR>

vmap v <Plug>(expand_region_expand)

" Autoformat F3
noremap <F3> :Autoformat<CR><CR>

" find and replace
nnoremap <Leader>fr :OverCommandLine s/<CR>
nnoremap <Leader>fR :OverCommandLine%s/<CR>
xnoremap <Leader>fr :'<,'>OverCommandLine s/<CR>

nnoremap <Esc><Esc> :nohlsearch<CR>

nmap <Leader>n ]m
nmap <Leader>m [m

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)

let g:ag_prg="ag --vimgrep --smart-case --ignore yarn.lock"
let g:ag_working_path_mode='r'
nnoremap \ :Ag<SPACE>

autocmd BufRead,BufNewFile *.es6 setfiletype javascript

autocmd FileType javascript nnoremap <Leader>c ciwconst<Esc>b
autocmd FileType javascript nnoremap <Leader>l ciwlet<Esc>b
autocmd FileType javascript nnoremap <Leader>f :s/: function//g<CR><Esc><Esc>

autocmd FileType ruby nnoremap <Leader>d orequire'pry';binding.pry<esc>:w<cr>
autocmd FileType ruby nnoremap <Leader>W :w<CR> :call ScreenShellSend("load '".@%."';")<CR>
autocmd FileType ruby nnoremap <Leader>b csw'X

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

let g:ctrlp_match_func = {'match':'cpsm#CtrlPMatch'}
let g:ctrlp_tilde_homedir = 1
" let g:ctrlp_match_current_file = 1
let g:ctrlp_mruf_relative = 1
" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore bower_components --ignore node_modules --ignore dist --ignore tmp --ignore yarn.lock -g ""'
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
let g:syntastic_javascript_eslint_exec = 'eslint_d'

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_scss_checkers = ['sass_lint']
let g:syntastic_sass_checkers = ['sass_lint']
let g:syntastic_filetype_map = { 'html.handlebars': 'handlebars' }

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" mustache
let g:mustache_abbreviations = 1

autocmd FileType css command! SortCSS :g#\({\n\)\@<=#.,/}/sort
autocmd FileType scss command! SortSCSS :g#\({\n\)\@<=#.,/\.*[{}]\@=/-1 sort

let g:EditorConfig_core_mode = 'external_command'

let g:SuperTabDefaultCompletionType = '<c-n>'
let g:SuperTabMappingForward = '<s-nul>'
let g:SuperTabMappingBackward = '<s-nul>'

let g:delimitMate_expand_space = 1
imap <silent> <C-J> <Plug>delimitMateCR

let g:endwise_no_mappings = 1
autocmd FileType ruby imap <C-J> <C-J><Plug>DiscretionaryEnd

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
command! MarkdownPreview InstantMarkdownPreview

let g:user_emmet_install_global = 0
autocmd FileType html,hbs,html.handlebars,css,scss EmmetInstall
let g:user_emmet_leader_key='<C-E>'

augroup incsearch-keymap
  autocmd!
  autocmd VimEnter * call s:incsearch_keymap()
augroup END

function! s:incsearch_keymap()
  IncSearchNoreMap <Tab> <Over>(buffer-complete)
  IncSearchNoreMap <S-Tab> <Over>(buffer-complete-prev)
endfunction

function! s:maximizeWindow()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>maximizeWindow()<cr>
