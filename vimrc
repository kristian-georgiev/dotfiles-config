" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible
filetype off

" Turn on syntax highlighting.
syntax on

filetype plugin indent on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" Hard line-wrapping
set textwidth=80
set wrapmargin=0
set formatoptions+=t
set linebreak

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch
set hlsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

nnoremap <SPACE> <Nop>
let mapleader=" "

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

" Remap split navigation
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>h :wincmd h<CR>

" fzf
nnoremap <C-p> :GFiles<Cr>

" Map easy split resizing
map - <C-W>-
map + <C-W>+
cnoreabbrev rs resize
cnoreabbrev vrs vertical resize

nmap j gj
nmap k gk


syntax enable
filetype plugin indent on
filetype plugin on

set tabstop=4           
set expandtab           
set shiftwidth=4        
set softtabstop=4       

set autoindent          
set smartindent        

set splitright
set splitbelow

" saving and loading sessions
" from https://dockyard.com/blog/2018/06/01/simple-vim-session-management-part-1
set wildmenu
set wildmode=full
let g:session_dir = '~/vim-sessions'
exec 'nnoremap <Leader>ss :Obsession ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
" pause session
nnoremap <Leader>sp :Obsession<CR>

if !exists("*MyTabLine")
    " Our custom TabLine function
    function MyTabLine()
      let s = ''
      for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
          let s .= '%#TabLineSel#'
        else
          let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
      endfor

      " after the last tab fill with TabLineFill and reset tab page nr
      let s .= '%#TabLineFill#%T'

        let s .= '%=' " Right-align after this

        if exists('g:this_obsession')
            let s .= '%#diffadd#' " Use the "DiffAdd" color if in a session
        endif

        " add vim-obsession status if available
        if exists(':Obsession')
            let s .= "%{ObsessionStatus()}"
            if exists('v:this_session') && v:this_session != ''
                let s:obsession_string = v:this_session
                let s:obsession_parts = split(s:obsession_string, '/')
                let s:obsession_filename = s:obsession_parts[-1]
                let s .= ' ' . s:obsession_filename . ' '
                let s .= '%*' " Restore default color
            endif
        endif

      return s
    endfunction

    " Required for MyTabLine()
    function MyTabLabel(n)
      let buflist = tabpagebuflist(a:n)
      let winnr = tabpagewinnr(a:n)
      return bufname(buflist[winnr - 1])
    endfunction
endif


set encoding=UTF-8

" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" make SuperTab nicer
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 1

call plug#begin('~/.vim/plugged')
Plug 'cocopon/iceberg.vim'  " color theme
Plug 'itchyny/lightline.vim'  " status line
Plug 'preservim/nerdcommenter'  " only use <leader> c <leader> for toggling comments
Plug 'scrooloose/nerdtree'  " file tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "  file tree colors
Plug 'Xuyuanp/nerdtree-git-plugin'  " git status in file tree
Plug 'tpope/vim-fugitive'  " git integration
Plug 'junegunn/gv.vim'  " :GV opens commit browser, look at diffs upon Enter
Plug 'tpope/vim-obsession'  " automatically tracks session with :Obsess
Plug 'ervandew/supertab'  " start autocomplete with tab
Plug 'airblade/vim-gitgutter'  " shows git status of lines in 'gutter' (margin)
Plug 'yggdroot/indentline'  " makes vertical lines that indicate indent levels
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " fuzzy search
Plug 'junegunn/fzf.vim'  " fuzzy search
call plug#end()

colorscheme iceberg
set background=dark
"set background=light

" undotree mappings
nnoremap <F5> :UndotreeToggle<CR>


" gitgutter
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghn <Plug>(GitGutterNextHunk)
nmap ghN <Plug>(GitGutterPrevHunk)

cnoreabbrev gs G status
cnoreabbrev gc G commit
cnoreabbrev gl GV
cnoreabbrev gd G diff
cnoreabbrev gds G diff --staged
cnoreabbrev gdf Gdiffsplit

cnoreabbrev W w
cnoreabbrev Wq wq

nnoremap <Leader>m :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" Folding
set foldmethod=indent
set foldnestmax=2
" Start unfolded
set foldlevel=99
nnoremap <space> za
vnoremap <space> zf


" because Windows Terminal is silly
" https://github.com/microsoft/terminal/issues/4335#issuecomment-753397798
if &term =~ '^xterm'
	" Cursor in terminal:
	" Link: https://vim.fandom.com/wiki/Configuring_the_cursor
	" 0 -> blinking block not working in wsl
	" 1 -> blinking block
	" 2 -> solid block
	" 3 -> blinking underscore
	" 4 -> solid underscore
	" Recent versions of xterm (282 or above) also support
	" 5 -> blinking vertical bar
	" 6 -> solid vertical bar

	" normal mode
	let &t_EI .= "\e[1 q" 	
	" insert mode
	let &t_SI .= "\e[5 q"	

	augroup windows_term
		autocmd!
		autocmd VimEnter * silent !echo -ne "\e[1 q" 
		autocmd VimLeave * silent !echo -ne "\e[5 q" 
	augroup END
endif

" lightline settings
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'powerlineish',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
augroup NERD
    au!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd VimEnter * wincmd p
    autocmd VimEnter * call lightline#update()
augroup END

set complete-=i
