" jsnuggle's vimrc

" =====
" INIT
" =====

autocmd!
filetype off
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

set nocompatible                   " vi compat? nah.

" * Security
set modelines=0                    " prevents known security exploit
set encoding=utf-8"

" * Leader
let mapleader = ","

au BufWritePost vimrc so ~/.vimrc " automatically reload vimrc when it's saved
au BufWinLeave * silent! mkview   " make vim save view state (cursor, etc)
au BufWinEnter * silent! loadview " make vim load view state (cursor, etc)


" ===========
" LOOK & FEEL
" ===========

" Line Numbers
set number

" Colors
colorscheme candycode
set background=dark
set t_Co=256

" Ruler
set ruler                          " add a useful ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids

" Formatting
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set tags=tags;/

" Status line
set showmode                       " display the current mode in the status line
set showcmd                        " show partially-typed commands in the status line
set laststatus=2                   " always show status line


" ===============
" FUNCTIONALTY
" ===============

syntax on                          " syntax highlighting is nifty! let's turn it on!
set hidden
set history=1000                   " keeps a thousand lines of history
set magic                          " allows pattern matching with special characters
set backspace=2                    " make backspace work like normal
set visualbell                     " visual bell instead of annoying beeping
if has("mouse")
    set mouse=a                        " enable full mouse support in the console
end
set virtualedit=onemore            " end of the line? what's that?
set pastetoggle=<leader>p

" * Search & Replace
set ignorecase                     " make searches case-insensitive
set smartcase                      " unless they contain upper-case letters ;)
set incsearch                      " show the `best match so far' as search strings are typed
set gdefault                       " assume the /g flag on :s substitutions
set hlsearch                       " highlight search items

set splitright                     " split new windows on the right of the current one
set splitbelow                     " split new windows below the current one
set fillchars=diff:⣿,vert:│

set wrap linebreak textwidth=0     " set vim to soft wrap lines
set formatoptions=qrn1
set autoindent
set shiftround

set wildmenu                       " enables a menu at the bottom of the vim/gvim window
set wildmode=longest,list          " complete on tab to longest match, present match list on second tab
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files"
set wildignore+=*.class                          " Java byte code
set wildchar=<TAB>                 " have command-line completion <Tab>

set ttyfast                        " enable support for higher speed terminal connections
set showmatch                      " show brace matching
set matchtime=3                    " for 3 milliseconds
set scrolloff=4

set whichwrap=h,l,~,[,]            " have the h and l cursor keys wrap between
                                   " lines (like <Space> and <BkSpc> do by default),
                                   " and ~ convert case over line breaks;
                                   " also have the cursor keys wrap in insert mode

" Undo
if version >= 703
    set undofile
    silent execute '!mkdir -p $HOME/.vim/tmp/undo'
    set undodir=~/.vim/tmp/undo// " undofiles
    set undoreload=10000
endif

set undolevels=1000

" goodbye help key:
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" goodbye folidng:
set foldlevel=999
au BufRead * normal zR

" ===============
" Key Remaps
" ===============

" remap the command key
nnoremap ; :

"
nmap <C-H> :tabprev<CR>
nmap <C-L> :tabnext<CR>

" Search: use sane regexes
nnoremap / /\v
vnoremap / /\v

" Remap the <Esc> key -- why reach so far?
:imap jj <Esc>

" reselect visual block after indent change
vnoremap < <gv
vnoremap > >gv

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" open ctag declarations in split by default
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" =============
" LEADER MACROS
" =============

" unhighilight search items with ,<space>
nnoremap <leader><space> :noh<cr>

" NERDTree
nnoremap <leader>n :NERDTreeTabsToggle<CR>

" DelimitMate (toggle on off)
nnoremap <leader>dd :DelimitMateSwitch<CR>

" MRU
nnoremap <leader>bb :BuffergatorToggle<CR>
nnoremap <leader>bt :BuffergatorTabsToggle<CR>

" Fugitive
let g:fugitive_github_domains = ['github.etsycorp.com']
nnoremap <leader>b :Gblame<CR>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gb :Gbrowse<CR>
vnoremap <leader>gb :Gbrowse<CR>

" Yankring
nnoremap <silent> <leader>y :YRShow<cr>
let g:yankring_replace_n_pkey = ',y'

" Gundo
nnoremap <leader>g :GundoToggle<CR>

" Ack
map <leader>a :Ack<space>

" airline
let g:airline_theme='dark'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

" Vim Librarian
let g:librarian_filename = '~/.vim/tmp/vim_librarian'
nnoremap <leader>ka :VLBookmark<space>
nnoremap <leader>kd :VLDelBookmark<space>
nnoremap <leader>ke :execute "split" g:librarian_filename<cr>
nnoremap <leader>kf :VLQFOpenBookmarksFor<space>
nnoremap <leader>kl :VLQFOpenBookmarks<cr>
nnoremap <leader>ko :VLOpenBookmarks<space>

" toggle invisible characters
nnoremap <leader>l :set list!<cr>

" edit vim config
nmap <leader>vv :tabedit $MYVIMRC<CR>
nmap <leader>gg :tabedit $MYGVIMRC<CR>

" flip syntax on and off
nnoremap <leader>s :syntax off<CR>:syntax on<CR>

" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" cycle to the next window
nnoremap <leader> <C-W>w

" Directories / Setup

" Backups, undo, views, YankRing and Markdown previews
set backup                        " enable backups
silent execute '!mkdir -p $HOME/.vim/tmp/backup'
set backupdir=$HOME/.vim/tmp/backup// " backups

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"
silent execute '!mkdir -p $HOME/.vim/tmp/swap'
set directory=$HOME/.vim/tmp/swap//   " swap files
silent execute '!mkdir -p $HOME/.vim/tmp/views'
set viewdir=$HOME/.vim/tmp/views//    " view files
silent execute '!mkdir -p $HOME/.vim/tmp/yankring'
let g:yankring_history_dir = '$HOME/.vim/tmp/yankring'

" ===============
" PLUGIN SETTINGS
" ===============

" Syntastic options
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_php_checkers=['php','phpcs']

" Command-T options
let g:CommandTMaxHeight=10
let g:CommandTMaxFiles=50000
set wildignore+=htdocs/images,docs/images,tests/js-test-driver/output,test/js-test-driver/tmp*,tmp

" NERDTree
let g:NERDTreeHijackNetrw=1 " User instead of Netrw when doing an edit /foobar
let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                    \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                    \ '.*\.o$', 'db.db', 'tags.bak']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2

" disable warnings from NERDCommenter:
let g:NERDShutUp = 1

" Buffergator
let g:buffergator_suppress_keymaps=1

" * Text Formatting

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:\ *,ex:*/
set comments+=fb:\ *
" treat lines starting with a quote mark as comments (for 'Vim' files)
set comments+=b:\"


" * Text Formatting -- Specific File Formats

" recognize anything at all with a .txt extension as being human-language text
augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

" in human-language files, automatically format everything at 72 chars:
autocmd FileType mail,human,markdown set formatoptions+=t textwidth=78

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro

" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

" filetype-specific tab expansion:
autocmd FileType java setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType scala setlocal shiftwidth=2 softtabstop=2 tabstop=2

" show git diff in window split when committing
" broken if autochdir is enabled
" autocmd FileType gitcommit DiffGitCached | wincmd p

" recognize smarty files, add dictionary completion
au BufRead,BufNewFile *.tpl set filetype=smarty
au Filetype smarty exec('set dictionary=$HOME/.vim/syntax/smarty.vim')
au Filetype smarty set complete+=k

" ** PHP Specific
" highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
autocmd FileType php let php_sql_query = 1
" does exactly that. highlights html inside of php strings
autocmd FileType php let php_htmlInStrings = 1
" discourages use of short tags.
autocmd FileType php let php_noShortTags = 1
" highlight functions from the base library
autocmd FileType php let php_baselib = 1


" OmniCompletion for std lib functions and so forth (C-X, C-o)
set omnifunc=syntaxcomplete#Complete

" =============
" FUNCTIONS
" =============

" Beautifuy Code:
" Strips whitespace and formats code on file save
" Currently applies to PHP only
function! <SID>BeautifyCode()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:

    " remove trailing whitespace on save
    %s/\s\+$//e

    " appease the almighty php staging code sniffer
    %s/\(if\|foreach\)(/\1 (/e
    %s/\()\){/\1 {/e
    %s/}\(catch\|else\)/} \1/e
    %s/\(else\|try\){/\1 {/e

    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd FileType php autocmd BufWritePre <buffer> silent! :call <SID>BeautifyCode()
" autocmd FileType javascript autocmd BufWritePre <buffer> silent! :call <SID>BeautifyCode()

" NERDTreeQuit:
" close the NERDTree window if there are no other open buffers
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()


" QFixToggle:
" toggle quickfix window
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
nmap <silent> \ :QFix<CR>

" MkNonExDir
" if you're editing a file in the buffer that's in a folder that doesn't exist yet
" this will create the folder on save
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" ====
" ETSY
" ====

" match Etsy coding standards
let g:syntastic_php_phpcs_args="--report=csv --standard=".expand($HOME)."/development/Etsyweb/tests/standards/stable-ruleset.xml"

let g:syntastic_css_csslint_args = "--format=compact --warnings=important,outline-none,display-property-grouping,duplicate-background-images,compatible-vendor-prefixes,known-properties --ignore=adjoining-classes,box-sizing,box-model,qualified-headings,ids,overqualified-elements,import --quiet"

let g:syntastic_javascript_jshint_args = "--config=/home/".expand($USER)."/development/Etsyweb/bin/jenkins/.jshintrc"

autocmd BufWritePost /usr/etsy/deployinator/* :silent !touch /usr/etsy/deployinator/tmp/restart.txt
