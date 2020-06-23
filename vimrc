set nocompatible
syntax enable
filetype plugin indent on
set modelines=0

" vim-plug
call plug#begin('~/.vim/plugged')

" ack-vim for fuzzy search
Plug 'mileszs/ack.vim'

" CtrlP to fuzzy file open
Plug 'kien/ctrlp.vim'

" Nerd Tree
Plug 'preservim/nerdtree'

" One-Monokai color scheme
Plug 'fratajczak/one-monokai-vim'

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'

" Icons!
Plug 'ryanoasis/vim-devicons'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git interaction
Plug 'tpope/vim-fugitive'

" Status line
Plug 'vim-airline/vim-airline'

call plug#end()


"" Whitespace 
set tabstop=2 
set shiftwidth=2
set softtabstop=2
set expandtab

"" Tell Vim to not act like an idiot
set encoding=utf-8
set showmode
set hidden
set wildmode=list:longest
set ttyfast
set nobackup
set nowritebackup

"" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set ignorecase
set smartcase
set gdefault
set showmatch
nnoremap <leader><space> :noh<c
nnoremap <tab> %
vnoremap <tab> %

"" Silver Searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_working_path_mode = 'ra'
endif

"" Long Lines
set textwidth=120
set formatoptions=qrnl
set nowrap

nnoremap j gj
nnoremap k gk

inoremap jj <ESC>

"" Moving Around
nnoremap H ^
nnoremap L $
nnoremap J G
nnoremap K gg

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>ev :vsplit ~/.vim/vimrc<cr>
nnoremap <leader>sv :source ~/.vim/vimrc<cr>

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

inoremap (; ()<esc>i
inoremap {; {  }<esc>hi
inoremap [; []<esc>i

inoremap (: (<CR>)<C-c>O<tab>
inoremap {: {<CR>}<C-c>O<tab>
inoremap [: [<CR>]<C-c>O<tab>




"" Syntax and Languages
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

let g:javascript_plugin_jsdoc = 1
autocmd FileType javascript set formatprg=prettier\ --stdin
let g:tern#command = ['tern']
let g:tern_map_keys=1

"" Close Tags
let g:closetag_filenames = '*.html,*.jsx,*.js'

"" Colors
let g:impact_transbg=1
set termguicolors
colorscheme one-monokai

"" Fonts
set guifont=FiraCode\ NF\ 12
set number

"" NERDTree
nnoremap \nt :NERDTree<cr>

"" Fuzzy Finding
set rtp+=~/.fzf


"" Ale
let g:ale_linters = {
\ 'javascript': ['eslint'],
\}

let g:ale_fixers = {
 \ 'javascript': ['eslint', 'prettier']
 \ }
 
"let g:ale_sign_error = '💩'
"let g:ale_sign_warning = '⚠️'
"let g:ale_statusline_format = '💩 %d', '⚠️ %d', '']

" let g:ale_sign_error = '💣'
" let g:ale_sign_warning = '🚩'
" let g:ale_statusline_format = ['💣 %d', '🚩 %d', '']
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
