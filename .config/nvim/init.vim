"""" GENERAL """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required
set shell=/bin/bash

set path+=**

let g:python_host_prog = '/usr/bin/python2.7'

if has('nvim')
    let g:python_host_prog = '/usr/bin/python2'
    let g:python3_host_prog = '/usr/bin/python'
endif

" Set tabs and shifts to 2 spaces
set tabstop=2
set smarttab
set shiftwidth=2
set softtabstop=2
set formatoptions-=t
set expandtab

" Enable mouse
set mouse=a
if !has('nvim')
    set encoding=utf-8
    set ttymouse=xterm2
endif

" Persistent Undo
if has('persistent_undo')
    let undodir = "$HOME/.local/share/nvim/undo"   " where to save undo histories
    call system('mkdir ' . undodir)    " create undodir if not existing
    set undofile                       " Save undo's after file closes
    set undodir=$HOME/.local/share/nvim/undo   " where to save undo histories
    set undolevels=100000              " How many undos
    set undoreload=1000000             " number of lines to save for undo
endif


let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

set ttimeout ttimeoutlen=5

set hidden

" set the clipboard to the X clipboard for better interaction
if has('unnamedplus')
    set clipboard=unnamedplus
endif

"""" PLUGINS START """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('$HOME/.local/share/nvim/plugged')

Plug 'drmikehenry/vim-fixkey'

Plug 'tpope/vim-dispatch'
if has('nvim')
    Plug 'radenling/vim-dispatch-neovim'
endif



"""" VISUALS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" AIRLINE
Plug 'bling/vim-airline'
"{
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'kien/rainbow_parentheses.vim'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" RAINBOW_PARENTHESES
"{
    let g:rainbow_active = 1
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""" USEFUL EXTENSIONS """""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" FUGITIVE
Plug 'tpope/vim-fugitive'
"{
    nmap <leader>gd :Gdiff<cr>
    nmap <leader>gs :Gstatus<cr>
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" GITGUTTER
Plug 'airblade/vim-gitgutter'
"{
    let g:gitgutter_map_keys = 0

    nmap <leader>ghs <Plug>(GitGutterStageHunk)
    vmap <leader>ghs <Plug>(GitGutterStageHunk)
    nmap <leader>ghu <Plug>(GitGutterUndoHunk)
    vmap <leader>ghu <Plug>(GitGutterUndoHunk)
    nmap <leader>ghp <Plug>(GitGutterPreviewHunk)
    vmap <leader>ghp <Plug>(GitGutterPreviewHunk)
    nnoremap <leader>gf :GitGutterFold<CR>
    nmap ]h <Plug>(GitGutterNextHunk)
    nmap [h <Plug>(GitGutterPrevHunk)
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" FZF
Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"{
    nnoremap <leader><space> :FZF<CR>
    nnoremap <leader>h :History<CR>
    nnoremap <leader>gc :Commits<CR>
    nnoremap <leader>n :Find 
    nnoremap <leader>s *:Find <C-r>/<BS><BS><C-Left><Del><Del><CR>
    " let $FZF_DEFAULT_COMMAND = 'ag -g "" --ignore=\*.o'
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!.git/*" -g "!*.o" --no-ignore-parent'
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow -g "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""" COMPLETION / LANGUAGE FEATURES """"""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" COC
Plug 'neoclide/coc.nvim', {'do': 'npm install --frozen-lockfile'}
"{
    " Extensions which are installed when missing on server start
    let g:coc_global_extensions = [
        \ 'coc-calc',
        \ 'coc-css',
        \ 'coc-emmet',
        \ 'coc-highlight',
        \ 'coc-html',
        \ 'coc-java',
        \ 'coc-omnisharp',
        \ 'coc-json',
        \ 'coc-lists',
        \ 'coc-marketplace',
        \ 'coc-pairs',
        \ 'coc-python',
        \ 'coc-rust-analyzer',
        \ 'coc-sh',
        \ 'coc-snippets',
        \ 'coc-svelte',
        \ 'coc-tslint-plugin',
        \ 'coc-tsserver',
        \ 'coc-vetur',
        \ 'coc-yaml',
    \]

    " Better display for messages
    set cmdheight=2

    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300

    " don't give |ins-completion-menu| messages.
    set shortmess+=c

    " always show signcolumns
    set signcolumn=yes

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
    inoremap <silent><expr> <C-space> coc#refresh()

    " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` for navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> <leader>tt <Plug>(coc-definition)
    nmap <silent> <leader>td <Plug>(coc-type-definition)
    nmap <silent> <leader>ti <Plug>(coc-implementation)
    nmap <silent> <leader>tr <Plug>(coc-references)

    " Use K for show documentation in preview window
    nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if &filetype == 'vim'
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)
    " Fix autofix problem of current line
    nmap <leader>cf  <Plug>(coc-fix-current)

    nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>
    nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
    nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
    nnoremap <silent> <leader>cn  :<C-u>CocNext<cr>
    nnoremap <silent> <leader>cp  :<C-u>CocPrev<cr>

    " Remap for format selected region
    " use vim-autoformat for this still (probably change in the future)
    " vmap <leader>f  <Plug>(coc-format-selected)
    " nmap <leader>f  <Plug>(coc-format-selected)

    " mapping for coc-snippets

    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)

    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'

    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'

    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" ALE
" Plug 'w0rp/ale'   TODO probably not needed anymore since coc.nvim
"{
"    " \   'javascript': ['standard'],
"    let g:ale_linters = {
"            \   'cpp': [],
"            \   'cs': ['OmniSharp'],
"            \}
"    " let g:ale_javascript_eslint_options = '-c /usr/lib/node_modules/eslint-config-standard/eslintrc.json'
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" AUTOFORMAT
" TODO probably to be replaced by coc.nvim format
Plug 'Chiel92/vim-autoformat'
"{
    let g:formatters_glsl = ['clangformat']
    autocmd FileType vim let b:autoformat_autoindent=0
    vmap <leader>f :Autoformat<CR>
    nmap <leader>f :Autoformat<CR>
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" EASYTAGS
Plug 'xolox/vim-easytags', { 'for': ['html', 'vue.html.javascript.css', 'vue'] }
"{
    let g:easytags_async = 1
    let g:easytags_file = '$HOME/.local/share/nvim/tags'
    let g:easytags_updatetime_min = 2000
    let g:easytags_always_enabled = 1
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'honza/vim-snippets'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" LATEX
Plug 'vim-latex/vim-latex'
"{
    let Tex_FoldedSections = ""
    let Tex_FoldedEnvironments = ""
    let Tex_FoldedMisc = ""
    let g:Tex_SmartKeyBS = 0
    let g:Tex_SmartKeyQuote = 0
    let g:Tex_SmartKeyDot = 0
    let g:tex_conceal = ""
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'mattn/emmet-vim', { 'for': ['html', 'vue.html.javascript.css', 'vue', 'css', 'scss', 'javascript'] }



"""" SYNTAX HIGHLIGHTING """""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'JesseKPhillips/d.vim', { 'for': ['d'] }
Plug 'mesonbuild/meson', { 'rtp': 'data/syntax-highlighting/vim/'  }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" PANDOC-MARKDOWN
Plug 'vim-pandoc/vim-pandoc'
"{
    let g:pandoc#keyboard#display_motions = 0
    let g:pandoc#modules#disabled = ["folding"]
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
Plug 'tikhomirov/vim-glsl'
Plug 'petRUShka/vim-opencl', { 'for': 'opencl' }
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
Plug 'cespare/vim-toml', { 'for': 'toml'}
Plug 'dag/vim-fish', { 'for': 'fish'}
Plug 'JulesWang/css.vim', { 'for': ['vue.html.javascript.css', 'vue', 'css', 'scss'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['vue.html.javascript.css', 'vue', 'css', 'scss'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'vue.html.javascript.css', 'vue'] }
Plug 'posva/vim-vue', { 'for': ['vue.html.javascript.css', 'vue'] }
Plug 'burner/vim-svelte', { 'for': ['svelte'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'vue'] }
Plug 'othree/html5.vim', { 'for': ['htmldjango', 'html', 'vue.html.javascript.css', 'vue'] }
Plug 'tomlion/vim-solidity'
Plug 'peterhoeg/vim-qml'
Plug 'jparise/vim-graphql'
Plug 'vim-scripts/ShaderHighLight'
Plug 'ron-rs/ron.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" JSON
Plug 'elzr/vim-json', { 'for': 'json' }
"{
    set conceallevel=0
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'godlygeek/tabular', { 'for': 'markdown' }

Plug 'dhruvasagar/vim-table-mode'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" TABLE MODE
"{
    map <leader>\ :TableModeToggle<CR>
    " let g:table_mode_header_fillchar = "="
    let g:table_mode_tableize_map = '<leader>tmt'
    let g:table_mode_corner_corner = "+"
"}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#end()
"""" PLUGINS END """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on    " required



"""" KEYMAPPINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>w :w<cr>
nmap <leader>z :wq<cr>
nmap <leader>q :q<cr>
nmap <leader>x :bd<cr>

map Y y$

" polyfill for <A>
let c = 'a'
if !has('nvim')
    while c <= 'z'
        exec "set <A-".c.">=\e".c
        exec "imap \e".c." <A-".c.">"
        let c = nr2char(1+char2nr(c))
    endw
endif


nnoremap <A-l> :bn<CR>
nnoremap <A-h> :bp<CR>
inoremap <A-l> <Esc>:bn<CR>
inoremap <A-h> <Esc>:bp<CR>
" tnoremap <A-l> <Esc>:bn<CR>
" tnoremap <A-h> <Esc>:bp<CR>
" tnoremap <A-l> <C-\><C-n>:bn<CR>
" tnoremap <A-h> <C-\><C-n>:bp<CR>

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" delete without yanking into the default register but instead into the register x
nnoremap x "xx
vnoremap x "xx
nnoremap X "xX
vnoremap X "xX
" nnoremap d "dd
" vnoremap d "dd
" replace currently selected text with default register
" without yanking it into the default register, but instead of the register p
vnoremap p "pdP
vnoremap P "pdP

" quick switch between last buffer and current buffer
nnoremap <BS> :b#<CR>

" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>

noremap <F2> :call ToggleColemak()<CR>

" Search for selected text, forwards or backwards. (* and # work with selection as well)
vnoremap <silent> * :<C-U>
    \let old_reg = getreg('"')<Bar>let old_regtype = getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
    \let old_reg = getreg('"')<Bar>let old_regtype = getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>


" calculate expressions probably done by coc-calc
" vmap <leader>c :!xargs echo 'scale=5; ' \| BC_LINE_LENGTH=0 bc -l \| sed '/\./ s/\.\{0,1\}0\{1,\}$//'<cr><cr>

" color and optical enhancements
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
set termguicolors
set noshowmode
set background=dark
colorscheme gruvbox
syntax on
set fillchars+=vert:│

" some extensions which are not recognized by default
autocmd BufNewFile,BufRead *.html5   set syntax=php
autocmd BufNewFile,BufRead *.glsl   set syntax=glsl
autocmd BufNewFile,BufRead *.toml   set syntax=toml
autocmd BufNewFile,BufRead *.fish   set syntax=fish
autocmd BufNewFile,BufRead *.svelte   set syntax=svelte

set laststatus=2
set textwidth=120
set relativenumber
set number

" indentation
let g:indent_guides_enable_on_vim_startup = 1
set wildmenu
set showcmd
set hlsearch
set ruler

set autoread

set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let &t_ut = ''


" Remapping for Colemak
" ----------------------

" This remaps the movemet keys j and k (In Colemak, J (= Qwerty Y) is placed
" above K (= Qwerty N), which I find confusing in Vim since j moves down and k
" up. I think the remappings below result in a more logical and easier to
" reach layout, keeping in mind that space and backspace (= Qwerty Caps-Lock)
" can be used instead of Colemak J (= Qwerty Y). I use the join-lines command
" much more than the help command, and have therefore swapped J and K since I
" find Colemak K (Qwerty N) much easier to reach than Colemak J (Qwerty Y).

" The first five mappings are basically all one needs to remember.

let s:colemakEnabled = 0

function! ToggleColemak()
    if s:colemakEnabled
        let s:colemakEnabled = 0
        unmap K
        unmap J

        unmap h
        unmap j
        unmap k

        unmap gh
        unmap gj
        unmap gk

        noremap zh
        "zK does not exist
        unmap zj
        unmap zJ
        unmap zk
        "zJ does not exist
        unmap z<Space>
        unmap z<S-Space>
        unmap z<BS>
        unmap z<S-BS>

        unmap <A-j>
        noremap <A-h> :bp<CR>
        inoremap <A-h> <Esc>:bp<CR>
        " tnoremap <A-h> <C-\><C-n>:bp<CR>

        unmap <C-w>h
        unmap <C-w>H
        unmap <C-w>j
        unmap <C-w>J
        unmap <C-w>k
        unmap <C-w>K
        unmap <C-w><Space>
        unmap <C-w><S-Space>
        unmap <C-w><S-BS>
        else
        let s:colemakEnabled = 1
        noremap K J
        noremap J K

        noremap h k
        noremap j h
        noremap k j

        noremap gh gk
        noremap gj gh
        noremap gk gj

        noremap zh zk
        "zK does not exist
        noremap zj zh
        noremap zJ zH
        noremap zk zj
        "zJ does not exist
        noremap z<Space> zl
        noremap z<S-Space> zL
        noremap z<BS> zh
        noremap z<S-BS> zH


        unmap <A-h>
        noremap <A-j> :bp<CR>
        inoremap <A-j> <Esc>:bp<CR>
        " tnoremap <A-j> <C-\><C-n>:bp<CR>

        noremap <C-w>h <C-w>k
        noremap <C-w>H <C-w>K
        noremap <C-w>j <C-w>h
        noremap <C-w>J <C-w>H
        noremap <C-w>k <C-w>j
        noremap <C-w>K <C-w>J
        noremap <C-w><Space> <C-w>l
        noremap <C-w><S-Space> <C-w>L
        noremap <C-w><S-BS> <C-w>H
    endif
endfunction

call ToggleColemak()
