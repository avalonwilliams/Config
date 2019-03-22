let completion_fmts = ["vim", "zsh", "c", "h", "cpp", "python"] 

call plug#begin('~/.vim/plugged')
  " File highlighters
  Plug 'sheerun/vim-polyglot'

  " Color scheme
  Plug 'dracula/vim'

  " Airline
  if $TERM != "linux"
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'ryanoasis/vim-devicons'
  endif
  
  " Nerd Tree
  Plug 'scrooloose/nerdtree'

  " Vim completions
  Plug 'Shougo/neco-vim', { 'for': 'vim' }

  " Allows editing GPG encrypted files
  Plug 'jamessan/vim-gnupg'

  " Allows changing surrounding items
  Plug 'tpope/vim-surround'

  " Allows commenting items
  Plug 'tpope/vim-commentary'

  " Automatically configures tab width
  Plug 'tpope/vim-sleuth'

  " Git wrapper
  Plug 'tpope/vim-fugitive'

  " License
  Plug 'antoyo/vim-licenses'

  " HTML close tag
  Plug 'alvan/vim-closetag'

  " FZF support
  Plug 'junegunn/fzf.vim'

  " Ranger
  Plug 'francoiscabrol/ranger.vim'

  " Distraction free note taking
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
call plug#end()

set hidden

filetype plugin indent on
syntax enable

" Disable completion preview window
set completeopt-=preview

" Use spaces 
set expandtab

" Tab width
set softtabstop=4
set shiftwidth=4

" Nice settings
set hlsearch
set wildmenu

" Use real tabs for certain files
autocmd Filetype c    setlocal noexpandtab shiftwidth=8 tabstop=8
autocmd Filetype cpp  setlocal noexpandtab shiftwidth=8 tabstop=8
autocmd FileType make setlocal noexpandtab shiftwidth=4 tabstop=4

" Custom 'small' tab width for various file types
autocmd FileType json setlocal shiftwidth=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType xml  setlocal shiftwidth=2 softtabstop=2
autocmd FileType vim  setlocal shiftwidth=2 softtabstop=2
autocmd FileType zsh  setlocal shiftwidth=2 softtabstop=2
autocmd FileType sh   setlocal shiftwidth=2 softtabstop=2
autocmd FileType svg  setlocal shiftwidth=2 softtabstop=2
autocmd FileType css  setlocal shiftwidth=2 softtabstop=2
autocmd FileType scss setlocal shiftwidth=2 softtabstop=2
autocmd FileType lua  setlocal shiftwidth=2 softtabstop=2

" Spell checking on document files
autocmd FileType tex       setlocal spell
autocmd FileType markdown  setlocal spell linebreak wrap
autocmd FileType gitcommit setlocal spell

if $TERM == "st-256color" || $TERM == "tmux-256color"
    set t_8f=[38;2;%lu;%lu;%lum        " set foreground color
    set t_8b=[48;2;%lu;%lu;%lum        " set background color
    " Pretty colors :)
    colorscheme dracula
    set t_Co=256                         " Enable 256 colors
    set termguicolors                    " Enable GUI colors for the terminal to get truecolor
else
    colorscheme dracula
endif

" Numbers
set number
set relativenumber

command! Confsrc source ~/.vimrc
command! Conf e ~/.vimrc

" Toggle distraction free editing mode
function! Distraction_free()
  :Goyo
  :Limelight!! 0.8
endfunction

command! Dist call Distraction_free()

" status bar
set laststatus=1

" Language Server Keybindings
nnoremap <C-Space> :call LanguageClient_contextMenu()<CR>
nnoremap <F17> :call LanguageClient_contextMenu()<CR>
nnoremap gh :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap gr :call LanguageClient#textDocument_references()<CR>
nnoremap gs :call LanguageClient#textDocument_rename()<CR>

" Make keybindings
nnoremap mb :make<CR>
nnoremap mc :make clean<CR>
nnoremap mr :make run<CR>
nnoremap md :make debug<CR>

" Vim split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Nerd tree settings
map <C-n> :NERDTreeToggle<CR>

" split seperators using box drawing characters
if $TERM != "linux"
  set fillchars=vert:\│
endif

" Truecolor support
if $TERM != "linux"
  set termguicolors
endif

" mouse
if has('mouse')
  set mouse=a
endif

" cursor shape
if $TERM != "linux"
  let &t_SI = "\<Esc>[5 q"
  let &t_EI = "\<Esc>[1 q"
  let &t_SR = "\<Esc>[3 q"
endif

if exists($TMUX)
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
endif

if $TERM == "xterm-kitty"
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
endif


" Airline
let g:airline_powerline_fonts = 1
