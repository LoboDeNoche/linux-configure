" PLUGINS
call plug#begin()

" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-pyclang'

let g:ncm2_pyclang#library_path = '/usr/lib/libclang.so.9'
" Autocomplete DONE

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Startup menu
Plug 'mhinz/vim-startify'

" FZF!
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Status Bar
Plug 'itchyny/lightline.vim'
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': ''
  \}

" Powerline buffers
Plug 'mengelbrecht/lightline-bufferline'

let g:lightline.tabline = {'left': [ ['tabs'] ],'right': [ ['close'] ]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" noremap <1><C-\><C-n>:1gt<cr>

" Comments
" gcc for comment/uncomment one line
" gc in Visual Mode for text
Plug 'tpope/vim-commentary'

" Trailing symbols
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,space:•,extends:⟩,precedes:⟨
nnoremap <F3> :set list!<CR>
nnoremap <F4> :ToggleWhitespace<CR>

" C++ highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" GIT
Plug 'tpope/vim-fugitive'

" File manager
Plug 'preservim/nerdtree'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F2> :NERDTreeToggle<CR>

" Icons for Files
" Need to install this https://aur.archlinux.org/packages/nerd-fonts-source-code-pro/
Plug 'ryanoasis/vim-devicons'

" Spell Checking
" Need to install cppcheck and other https://github.com/neomake/neomake/wiki/Makers
Plug 'neomake/neomake'

" Rename files
Plug 'danro/rename.vim'

" More colors!
Plug 'victorze/foo'
Plug 'jdsimcoe/panic.vim'
Plug 'thejian/Mogao'
Plug 'sjl/badwolf'
Plug 'gkapfham/vim-vitamin-onec'
Plug 'dracula/vim'

call plug#end()

call neomake#configure#automake('nrwi', 500)

" CSCOPE

" set the runtime path to include cscope and initialize
" set rtp+=~/.vim/cscope.vim
" cscope !
" let $CSCOPE_DB = '~/Documents/CSCOPE/cscope.out'
" source ~/.vim/cscope.vim

source ~/.config/nvim/cscope.vim


" add some numbers and highlighting!
set number
syntax enable

" Highlighting
set termguicolors
set background=dark
colorscheme vitaminonec

" save 500 last commands
set history=500

" Turn off swap files
set noswapfile
set nobackup

" Turn on highlight on search
set hlsearch

" Work with terminal
let g:term_buf = 0
let g:term_win = 0

function! Term_toggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        startinsert!
	let g:term_win = win_getid()
    endif
endfunction
autocmd TermOpen * set nonumber

nnoremap <F5> :call Term_toggle(20)<cr>
tnoremap <F5><C-\><C-n>:call Term_toggle(20)<cr>
