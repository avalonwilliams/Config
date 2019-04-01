let completion_fmts = ["vim", "zsh", "c", "h", "cpp", "python"] 

call plug#begin('~/.vim/plugged')
  " File highlighters
  Plug 'sheerun/vim-polyglot'

  " Color scheme
  Plug 'dracula/vim'

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

  " Ranger
  Plug 'francoiscabrol/ranger.vim'

  " Distraction free note taking
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  " Info pager
  Plug 'alx741/vinfo'
call plug#end()

set hidden

filetype plugin indent on
syntax enable

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

if $TERM == "st-256color"
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
    let &t_SR = "\<Esc>[3 q"
    set t_8f=[38;2;%lu;%lu;%lum        " set foreground color
    set t_8b=[48;2;%lu;%lu;%lum        " set background color
    " Pretty colors :)
    colorscheme dracula
    set t_Co=256                         " Enable 256 colors
    set termguicolors                    " Enable GUI colors for the terminal to get truecolor
else
    colorscheme elflord
endif


" Vim split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
