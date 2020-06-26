" Load basic config
silent! so $HOME/.vim/basic.vim

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | PlugInstall | so $HOME/.vimrc
endif

call plug#begin('$HOME/.vim/plugged')
Plug 'vim-scripts/Modeliner', {'tag': '0.3.0'}
Plug 'ervandew/supertab', {'tag': '2.1'}
Plug 'preservim/nerdtree', {'tag': '6.9.0'}
  Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tomasr/molokai'
Plug 'aperezdc/vim-template'
Plug 'vim-airline/vim-airline', {'tag': 'v0.11'}
Plug 'godlygeek/tabular', {'tag': '1.0.0'}
Plug 'tpope/vim-fugitive', {'tag': 'v3.2'}
Plug 'mhinz/vim-signify', {'tag': 'legacy'}

Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'darfink/vim-plist'
Plug 'hail2u/vim-css3-syntax', {'tag': 'v1.7.0'}
Plug 'plasticboy/vim-markdown'
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'hdima/python-syntax', {'tag': 'r3.5.0'}
Plug 'fatih/vim-go', {'tag': 'v1.23'}
call plug#end()

" colorscheme
try
    set t_Co=256
    colorscheme molokai
    let g:molokai_original = 1
catch
    colorscheme default
endtry

" airline
if !empty(glob('~/.vim/plugged/vim-airline'))
    "nnoremap <tab>          :bnext<CR>
    "nnoremap <S-tab>        :bprevious<CR>
    nnoremap <leader>,      :bfirst<CR>
    nnoremap <leader>.      :blast<CR>
    nnoremap <leader>1      :b1<CR>
    nnoremap <leader>2      :b2<CR>
    nnoremap <leader>3      :b3<CR>
    nnoremap <leader>4      :b4<CR>
    nnoremap <leader>5      :b5<CR>
    nnoremap <leader>6      :b6<CR>
    nnoremap <leader>7      :b7<CR>
    nnoremap <leader>8      :b8<CR>
    nnoremap <leader>9      :b9<CR>
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    if !has('gui')
        let g:airline_symbols.branch = '⎇'
    endif
endif


" CSS3-Syntax
if !empty(glob('~/.vim/plugged/vim-css3-syntax'))
    augroup VimCSS3Syntax
        autocmd!
        autocmd FileType css setlocal iskeyword+=-
    augroup END
endif

" NERDTree
if !empty(glob('~/.vim/plugged/nerdtree'))
    nnoremap <C-n> :NERDTreeToggle<cr>
    let NERDTreeIgnore = [ '.pyc', '.pyo', '.DS_Store', '.localized' ]
    let NERDTreeHighlightCursorline = 1
    let NERDTreeShowBookmarks = 1
    let NERDTreeShowFiles = 1
    let NERDTreeShowHidden = 1
    " close vim if the only window left open is a NERDTree
    autocmd BufEnter * if (winnr("$") == 1
                \ && exists("b:NERDTree")
                \ && b:NERDTree.isTabTree()) | q | endif
    autocmd BufEnter * if bufname('#') =~# "^NERD_tree_"
                \ && winnr('$') > 1 | b# | endif
    " open a NERDTree when vim starts up if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " avoid crashes while the cursor is on the NERDTree window
    let g:plug_window = 'noautocmd vertical topleft new'
endif

" Signify
if !empty(glob('~/.vim/plugged/vim-signify'))
    let g:signify_vcs_list = [ 'git', 'hg', 'svn' ]
endif

" Supertab
if !empty(glob('~/.vim/plugged/supertab'))
    let g:SuperTabDefaultCompletionType = "<c-n>"
endif

" Markdown
if !empty(glob('~/.vim/plugged/vim-markdown'))
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_no_default_key_mappings = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_frontmatter = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_json_frontmatter = 1
endif

" Python syntax highligh
if !empty(glob('~/.vim/plugged/python-syntax'))
    let g:python_highlight_all = 1
endif

" VIM JSON
if !empty(glob('~/.vim/plugged/vim-json'))
    let g:vim_json_syntax_conceal = 0
endif

" Golang
if !empty(glob('~/.vim/plugged/vim-go'))
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_interfaces = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 1
    let g:go_fmt_autosave = 0
endif

" Other config
silent! so $HOME/.vim/vimrc.mine

" vim: set et fenc=utf-8 ff=unix sts=4 sw=4 ts=4 :
