" use zc and zo to close and open foldings
" use za to toggle

" {{{ General
set nocompatible
filetype plugin indent on
syntax on

set history=200

nnoremap <space>, <nop>
let mapleader=' '

set autoread
au FocusGained,BufEnter * checktime

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" remove trailing whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e

set showmode showcmd
set number relativenumber
set ruler
set scrolloff=3
set cmdheight=2
set updatetime=300
set wildmode=longest,list

set laststatus=2

" Marker based folding in vim files
autocmd FileType vim setlocal foldmethod=marker

set novisualbell
set encoding=utf-8
set hidden

set nobackup
set nowritebackup

set wrap
"set textwidth=79
set autoindent smartindent
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
set list listchars=tab:▸\ ,trail:.,
set linebreak

set termguicolors

set pastetoggle=<F9>

set hlsearch incsearch ignorecase smartcase
set showmatch matchtime=2

set backspace=2  "indent,eol,start
set matchpairs+=<:>
runtime macros/matchit.vim

"set mouse-=a

noremap Y y$

nmap <C-s> :w<cr>
imap <C-s> <ESC>:w<cr>a

" remember the cursor position of this file when it was last closed
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
" http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
autocmd BufEnter * syntax sync maxlines=500

"map key * and # to search the text that have been visualized.
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

map <F4> :call <SID>ToggleLineNumber()<CR>

function! s:ToggleLineNumber()
  set number!
  set relativenumber!
endfunction

imap <F2> <C-R>=strftime("%Y-%m-%d")<CR>
imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>

for s:i in range(1, 9)
  " <Leader>[1-9] move to window [1-9]
  execute 'nnoremap <Leader>'.s:i ' :'.s:i.'wincmd w<CR>'

  " <Leader><leader>[1-9] move to tab [1-9]
  execute 'nnoremap <Leader><Leader>'.s:i s:i.'gt'

  " <Leader>b[1-9] move to buffer [1-9]
  execute 'nnoremap <Leader>b'.s:i ':b'.s:i.'<CR>'
endfor
unlet s:i

" let q quit the help buffer
autocmd FileType help noremap <buffer> q :q<cr>

set guifont=SauceCodePro\ Nerd\ Font\ Mono

" }}}

" {{{ Plug install
call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'markonm/traces.vim'

Plug 'mhinz/vim-startify'
Plug 'junegunn/seoul256.vim'
"Plug 'liuchengxu/eleline.vim'
Plug 'liuchengxu/space-vim-theme'

Plug 'dominikduda/vim_current_word'

Plug 'voldikss/vim-floaterm'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'kdheepak/lazygit.nvim'

Plug 'liuchengxu/vim-which-key' ", { 'on': ['WhichKey', 'WhichKey!'] }

"Plug 'Yohannfra/Vim-Goto-Header'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'preservim/tagbar'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'liuchengxu/vista.vim'

Plug 'itchyny/lightline.vim'

call plug#end()
" }}}

" {{{ theme settings
" colo seoul256
colo space_vim_theme
" }}}

" {{{ startify settings
let g:startify_bookmarks = [
      \ { 'b': '~/.bashrc' },
      \ { 'v': '~/.config/nvim/init.vim' },
      \ ]
let g:startify_lists = [
      \ { 'header': ['   Bookmarks'],      'type': 'bookmarks' },
      \ { 'header': ['   MRU'],            'type': 'files' },
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
      \ ]
nmap <leader>s :Startify<cr>
" }}}

" {{{ floaterm settings
let g:floaterm_keymap_toggle = '<C-t>'
let g:floaterm_opener = 'vsplit'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

tnoremap <Esc><Esc> <C-\><C-n>

nnoremap <leader>tt :FloatermToggle<cr>
nnoremap <leader>tf :FloatermNew fff<cr>
nnoremap <leader>tn :FloatermNew nnn<cr>
nnoremap <leader>tg :FloatermNew gitui<cr>
nnoremap <leader>tp :FloatermNew python<cr>
nnoremap <leader>tr :FloatermNew irb<cr>
" }}}

" {{{ fzf settings
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fl :BLines<cr>
nnoremap <leader>fm :Marks<cr>
nnoremap <leader>fw :Windows<cr>
nnoremap <leader>fr :History<cr>
nnoremap <leader>fc :Commands<cr>
nnoremap <leader>fk :Maps<cr>
nnoremap <leader>ft :Helptags<cr>
nnoremap <leader>fh :Filetypes<cr>
nnoremap <M-x> :Commands<cr>

" search the selected text or the word under cursor with rg
if has('nvim')
  tnoremap <silent> <expr> <M-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif
vmap <silent> <leader>fs "hy:Rg<cr><M-r>h
nmap <silent> <leader>fs :Rg<cr>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
"　}}}

" {{{ lazygit settings
nnoremap <silent> <leader>gg :LazyGit<CR>
" }}}

" {{{ vim-which-key settings
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
set timeoutlen=500
let g:which_key_map = {}
let g:which_key_map.f = { 'name' : '+fzf' }
let g:which_key_map.g = { 'name' : '+git' }
let g:which_key_map.t = { 'name' : '+floaterm' }

" }}}

"" {{{ IDE setting ctags
"nnoremap <F12> :GotoHeader <CR>
"imap <F12> <Esc>:GotoHeader <CR>
"nnoremap gh :GotoHeaderSwitch <CR>
"let g:goto_header_associate_cpp_h = 1
"set tags=./tags,tags;
"nnoremap <leader>] :ltag <c-r>=expand("<cword>")<cr><bar>lwindow<CR> "open a window where we can search for all candidate tags
"nnoremap <leader>o :only<CR>  " close other windows
"
"let g:airline_statusline_ontop=0
"let g:airline#extensions#tagbar#flags = 'f'
"
"nnoremap <F5> :wa <bar> :set makeprg=cd\ build\ &&\ ../../klee-scripts/buildklee.sh\ &&\ cmake\ --build\ . <bar> :compiler gcc <bar> :make <CR>
"
"set cinoptions+=l1
"" }}}

" {{{ IDE setting lsp
lua require('lsp-comp')
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }

" }}}
