call pathogen#infect()
execute pathogen#helptags()

" fix python error from conda
let s:python_path = system('c:/Python27/python -', 'import sys;sys.stdout.write(",".join(sys.path))')

python <<EOM
import sys
import vim

python_paths = vim.eval('s:python_path').split(',')
#sys.path = [_path for _path in python_paths if 'conda' not in _path.lower()]

sys.path = [_path for _path in sys.path if 'conda' not in _path.lower()]
#for path in python_paths:
#    if not path in sys.path:
#        print path
#        sys.path.insert(0, path)
EOM


" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" source D:\Projects\Fenrir\working_stuff\myvimrc

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" activate filetype plugin
filetype plugin on

" Make external commands work through a pipe instead of a pseudo-tty
" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text
set guioptions-=m
set guioptions-=T

" show relative number, good to move faster
set relativenumber
"set undofile

nnoremap j gj
nnoremap k gk

set wrap
"set textwidth=79
set formatoptions=qrnl
set colorcolumn=85

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey90
  highlight Cursor guibg=Green guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95

endif

" set the initial window size
set lines=50 columns=140
" set tab size
set ts=4

" Ctrl+F5 to open explorer with folder contain current opened file
if has("gui_running")
  if has("win32")
    " Open the folder containing the currently open file. Double <CR> at end
    " is so you don't have to hit return after command. Double quotes are
    " not necessary in the 'explorer.exe %:p:h' section.
    :map <silent> <C-F5> :if expand("%:p:h") != ""<CR>:!start explorer.exe %:p:h<CR>:endif<CR><CR>
  endif
endif

"if has("gui_macvim")
    ":map <silent> <C-F5> :if expand("%:p:h") != ""<CR>:!open %:p:h<CR>:endif<CR><CR>
"endif
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
	let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
  endif
endif


"-------------------------------------------------------------------------------
" taglist.vim : toggle the taglist window
"-------------------------------------------------------------------------------
noremap <silent> <F10>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F10>  <Esc><Esc>:Tlist<CR>

":map <F11>  :sp tags<CR>:%s/^\([^	:]*:\)\=\([^	]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
":map <F12>  :so tags.vim<CR>

" key binding
" Turn on line numbers:
set nonumber
" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set number!<CR>:set foldcolumn=0<CR>

" folding toggle
nnoremap <Space> za

" visualize the tab
command -bang -nargs=? VisualizeTab call VisualizeTabCmd(<bang>0)
function! VisualizeTabCmd(forced)
if exists("g:visualize_tab") && a:forced == 0
:hi Tab NONE
unlet g:visualize_tab
else
:hi Tab gui=underline guifg=red ctermbg=red
let g:visualize_tab = bufnr("$")
endif
endfunction
nnoremap <F3> :VisualizeTab<CR>


map  <silent> <F7>    <Esc>:cp<CR>
map  <silent> <F8>    <Esc>:cn<CR>

nnoremap <C-A> ^
"nnoremap <C-E> $
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

"imap <C-e> <ESC>
imap jj <ESC>

"nmap <C-j> o<ESC>
imap <C-v> <C-o><S-p>

" key mappings
vnoremap S "_dP

" command-line mode key mapping
cmap <C-v> <C-R>+
cnoremap <c-b> <c-left>
cnoremap <c-d> <del>
cnoremap <c-f> <c-right>
cnoremap <c-n> <down>
cnoremap <c-p> <up>
" same shortcut for command line mode with bash
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>


" Key mapping for Select All
vnoremap <C-a> ggVG
map <C-a> ggVG
cmap <C-a> ggVG
imap <C-a> <C-O>ggVG
vmap <C-a> ggVG

"noremap <C-S>		:update<CR>
" Alt-j ==> add blank line
"nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
"nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
"nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
"nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

nnoremap <silent><C-CR> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-S-CR> :set paste<CR>m`O<Esc>``:set nopaste<CR>


" grep key binding
"map <C-F4> :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') | cope
"map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
"map <F5> :execute "vimgrep /" . <C-r>=expand("<cword>") . "/j **" <Bar> cw<CR>


" indent section
set noexpandtab
"set autoindent smartindent
set smarttab
set backspace=eol,start,indent
filetype plugin indent on
" end of indent section

" don't want to backup files
set nobackup
set bs=2 " Backspace
set ru "ruler
set shiftwidth=4

set ignorecase
set tags=./tags,tags;
"tags for projects

" ctags usage 
" c  classes
" d  macro definitions
" e  enumerators (values inside an enumeration)
" f  function definitions
" g  enumeration names
" l  local variables [off]
" m  class, struct, and union members
" n  namespaces
" p  function prototypes [off]
" s  structure names
" t  typedefs
" u  union names
" v  variable definitions
" x  external and forward variable declarations [off]

" .\ctags.exe --recurse -f d:\mytagfile --exclude="bin" --extra=+fq
" --fields=+ianmzS --c#-kinds=cimnp d:\myproduct
set tags+=/Users/xpec/Perforce/SOG/D2/tags
"if has("gui_running")
	"if has("win32")
		"set tags+=C:/dev/SOG/D2/tags
	"elseif has("unix")
		"let s:uname = system("uname")
		"if s:uname == "Darwin\n"
			"set tags+=/Users/xpec/Perforce/SOG/D2/tags
		"endif
	"endif
"endif



" map ,co to add comment box
map ,co O#<Esc>100A=<Esc>100\|D<CR>i#<CR><Esc>i##<Esc>100a=<Esc>100\|D<Esc>kA

" change to directory to current opened file
:autocmd BufEnter * lcd %:p:h


" Python section
" *** syntax on will mess up the easy motion plug-in
"autocmd BufRead,BufNewFile *.py syntax on
" ***
autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
""show tab with underline
autocmd BufRead *.py syntax match Tab /\t/
""Execute file being edited with <Shift> + e:
"autocmd BufRead *.py map <buffer> <S-e> :w<CR>:!"C:\Program Files\Autodesk\Maya2012\bin\mayapy" % <CR>
autocmd BufRead *.py map <buffer> <S-e> :w<CR>:!"C:\Python26\python" % <CR>

au FileType python setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
im :<CR> :<CR><TAB>
autocmd BufWritePre *.py normal m`:s/\s\+$//e ``
" end of Python section

set clipboard+=unnamed
set go+=a

augroup Tabs
   "new tab
   nmap    ,tn    :tabnew<cr>
   "open new tab and edit
   nmap    ,te    :tabedit
   "close current tab and edit
   nmap    ,to    :tabclose<cr>
   "new tab to explore current directory
   nmap    ,tx    :tabedit .<cr>
   "jump to the first tab
   nmap    ,tf    :tabfirst<cr>
   "jump to the last tab
   nmap    ,tl    :tablast<cr>
   "open help in tab
   nmap    ,th    :tab help<cr>
   "go to next tab
   nmap    <c-tab> 		:tabnext<cr>
   "go to previous tab
   nmap    <c-s-tab>    :tabprev<cr>
augroup END


" QUICKFIX WINDOW
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
if exists("g:qfix_win") && a:forced == 0
cclose
unlet g:qfix_win
else
copen 10
let g:qfix_win = bufnr("$")
endif
endfunction
nnoremap <leader>q :QFix<CR>
nnoremap <leader>e :Errors<CR>

" fuzzy find sectioon
  let g:fuf_modesDisable = []
  let g:fuf_mrufile_maxItem = 400
  let g:fuf_mrucmd_maxItem = 400

  nnoremap <silent> ,sj     :FufBuffer<CR>
  nnoremap <silent> ,sk     :FufFileWithCurrentBufferDir<CR>
  nnoremap <silent> ,sK     :FufFileWithFullCwd<CR>
  nnoremap <silent> ,s<C-k> :FufFile<CR>
  nnoremap <silent> ,sl     :FufCoverageFileChange<CR>
  nnoremap <silent> ,sL     :FufCoverageFileChange<CR>
  nnoremap <silent> ,s<C-l> :FufCoverageFileRegister<CR>
  nnoremap <silent> ,sd     :FufDirWithCurrentBufferDir<CR>
  nnoremap <silent> ,sD     :FufDirWithFullCwd<CR>
  nnoremap <silent> ,s<C-d> :FufDir<CR>
  nnoremap <silent> ,sn     :FufMruFile<CR>
  nnoremap <silent> ,sN     :FufMruFileInCwd<CR>
  "nnoremap <silent> ,sm     :FufMruCmd<CR>
  nnoremap <silent> ,su     :FufBookmarkFile<CR>
  nnoremap <silent> ,s<C-u> :FufBookmarkFileAdd<CR>
  vnoremap <silent> ,s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
  nnoremap <silent> ,si     :FufBookmarkDir<CR>
  nnoremap <silent> ,s<C-i> :FufBookmarkDirAdd<CR>
  nnoremap <silent> ,st     :FufTag<CR>
  nnoremap <silent> ,sT     :FufTag!<CR>
  nnoremap <silent> ,s<C-]> :FufTagWithCursorWord!<CR>
  nnoremap <silent> ,s,     :FufBufferTag<CR>
  nnoremap <silent> ,s<     :FufBufferTag!<CR>
  vnoremap <silent> ,s,     :FufBufferTagWithSelectedText!<CR>
  vnoremap <silent> ,s<     :FufBufferTagWithSelectedText<CR>
  nnoremap <silent> ,s}     :FufBufferTagWithCursorWord!<CR>
  nnoremap <silent> ,s.     :FufBufferTagAll<CR>
  nnoremap <silent> ,s>     :FufBufferTagAll!<CR>
  vnoremap <silent> ,s.     :FufBufferTagAllWithSelectedText!<CR>
  vnoremap <silent> ,s>     :FufBufferTagAllWithSelectedText<CR>
  nnoremap <silent> ,s]     :FufBufferTagAllWithCursorWord!<CR>
  nnoremap <silent> ,sg     :FufTaggedFile<CR>
  nnoremap <silent> ,sG     :FufTaggedFile!<CR>
  nnoremap <silent> ,so     :FufJumpList<CR>
  nnoremap <silent> ,sp     :FufChangeList<CR>
  nnoremap <silent> ,sq     :FufQuickfix<CR>
  nnoremap <silent> ,sy     :FufLine<CR>
  nnoremap <silent> ,sh     :FufHelp<CR>
  nnoremap <silent> ,se     :FufEditDataFile<CR>
  nnoremap <silent> ,sr     :FufRenewCache<CR>
" end of fuzzy find

" vimya - vim for maya
let g:vimyaPort=12345
nnoremap ,sm :py sendBufferToMaya ()<cr>
vnoremap ,sm :py sendBufferToMaya ()<cr>
nnoremap ,sb :py sendBufferToMaya (True)<cr>
vnoremap ,sb :py sendBufferToMaya (True)<cr>

" taglist mel support
let tlist_mel_settings='mel;f:function'

" same shortcut for command line mode with bash
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" ,/ turn off search highlighting
nmap \\ :nohl<CR>:lclose<CR>

" path for find command
set path+=.,"C:\Program Files\Autodesk\Maya2012\include",,

augroup filetypedetect
au! BufRead,BufNewFile *.ms setf maxscript
au! BufRead,BufNewFile *.mcr setf maxscript
augroup END

"language english
hi link EasyMotionTarget PmenuSel
hi link EasyMotionShade  Pmenu

" perforce key mapping
nnoremap ,pa :!p4 add % <CR>
nnoremap ,pe :!p4 edit % <CR>
nnoremap ,pd :!p4 diff % <CR>
nnoremap ,pt :!p4 filelog -l % <CR>

" easy motion leader key modification
let g:EasyMotion_leader_key = ','

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Solarized Colorscheme
if has('gui')
	set background=dark
	let g:solarized_termtrans=1
	let g:solarized_termcolors=256
	let g:solarized_contrast="high"
	let g:solarized_visibility="high"
	let g:solarized_italic=0
	colorscheme solarized
else
	set background=dark
	let g:solarized_termtrans=1
	let g:solarized_termcolors=256
	let g:solarized_contrast="high"
	let g:solarized_visibility="high"
	let g:solarized_italic=0
	colorscheme solarized
endif

colorscheme codedark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickly edit vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" disable vim's default backup mechnism
set nobackup
set noswapfile

" mouse click as *
:noremap <2-C-LeftMouse> *
:noremap <C-f> *<S-n>

" no error bell and flash bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" grep.vim config
:let Grep_Path = 'C:\Benny_Data\util\bin\grep.exe'
:let Fgrep_Path = 'C:\Benny_Data\util\bin\fgrep.exe'
:let Egrep_Path = 'C:\Benny_Data\util\bin\egrep.exe'
:let Grep_Find_Path = 'C:\Benny_Data\util\bin\find.exe'
:let Grep_Xargs_Path = 'C:\Benny_Data\util\bin\xargs.exe'

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  "set fileencodings=ucs-bom,utf-8,latin1
  "set fileencodings=utf-8,big5,gbk,latin1
  set fileencodings=utf-8,big5,gbk,latin1,euc-jp,iso-2022-jp,cp932,sjis
endif

" Ack section
nnoremap <silent> <Leader>g :Ack<CR>

" some handy key mapping
" remove all empty char at end of each lines
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" auto completion for c# files
"au FileType cs set omnifunc=syntaxcomplete#Complete

" get rid of C-X,C-O
"function! SuperCleverTab()
    "if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        "return "\<Tab>"
    "else
        "if &omnifunc != ''
            "return "\<C-X>\<C-O>"
        "elseif &dictionary != ''
            "return "\<C-K>"
        "else
            "return "\<C-N>"
        "endif
    "endif
"endfunction

"inoremap <Tab> <C-R>=SuperCleverTab()<cr>
map <C-F6> :ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" resize horzontal split window
nmap <S-Up> <C-W>-<C-W>-
nmap <S-Down> <C-W>+<C-W>+

" resize vertical split window
nmap <S-Left> <C-W>><C-W>>
nmap <S-Right> <C-W><<C-W><


" for vim-easy-align
vnoremap <silent> <Enter> :EasyAlign<cr>

" for Japense encoding
nmap <F5> :e ++enc=sjis<cr>

" ack mapping
nnoremap <leader>v V`]

" reselect the text that was just pasted 
nnoremap <leader>a :Ack


" status bar fix
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#000000  guibg=#F4905C
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe


set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1  
set fileencoding=utf-8  
set encoding=utf-8  

set termencoding=utf-8
language messages zh_TW.utf-8
"set gfn=Monaco:h10:cANSI  
"set gfw=NSimsun:h12
"set guifont=Courier\ New\:h12  
"set guifontwide=NSimsun\:h12 

set guifont=Consolas:h10:cANSI:qDRAFT



nnoremap <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ 'g')<CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ 'g')<CR>

hi pythonSelf  ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold

"" syntastic {
"let g:syntastic_python_checkers=['pyflakes']
"let g:syntastic_javascript_checkers=['jsl', 'jshint']
"let g:syntastic_html_checkers=['tidy', 'jshint']
"let g:syntastic_error_symbol='✹'
"let g:syntastic_warning_symbol='✴'
"let g:syntastic_aggregate_errors=1

"nnoremap <Leader>ts :SyntasticToggleMode<CR>
"" }
 "ale {

let g:ale_enabled = 1
let g:ale_linters = {
			\ 'sh' : ['shellcheck'],
			\ 'vim' : ['vint'],
			\ 'html' : ['tidy'],
			\ 'python' : ['flake8'],
			\ 'markdown' : ['mdl'],
			\ 'javascript' : ['eslint'],
			\}

let g:ale_fixers = ['yapf', 'remove_trailing_lines', 'trim_whitespace']

let g:ale_set_highlights = 1
" If emoji not loaded, use default sign
try
  let g:ale_sign_error = emoji#for('boom')
  let g:ale_sign_warning = emoji#for('small_orange_diamond')
catch
  " Use same sign and distinguish error and warning via different colors.
  let g:ale_sign_error = '•'
  let g:ale_sign_warning = '•'
endtry

"let g:ale_sign_error = '✘'
"let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"hi ale_error   cterm=None ctermfg=red ctermbg=NONE
"hi ale_warning cterm=None ctermfg=yellow ctermbg=NONE


let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

" For a more fancy ale statusline
function! ALEGetError()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
	return ''
  else
	let l:e_w = split(l:res)
	if len(l:e_w) == 2 || match(l:e_w, 'E') > -1
	  return ' •' . matchstr(l:e_w[0], '\d\+') .' '
	endif
  endif
endfunction

function! ALEGetWarning()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
	return ''
  else
	let l:e_w = split(l:res)
	if len(l:e_w) == 2
	  return ' •' . matchstr(l:e_w[1], '\d\+')
	elseif match(l:e_w, 'W') > -1
	  return ' •' . matchstr(l:e_w[0], '\d\+')
	endif
  endif
endfunction

"if g:spacevim_gui
  "let g:ale_echo_msg_error_str = 'Error'
  "let g:ale_echo_msg_warning_str = 'Warning'
"else
  let g:ale_echo_msg_error_str = '✹ Error'
  let g:ale_echo_msg_warning_str = '⚠ Warning'
"endif

nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)
"nmap <Leader>en <Plug>(ale_next)
"nmap <Leader>ep <Plug>(ale_previous)
nnoremap <Leader>ts :ALEToggle<CR>
" }

" python-mode {
  let g:pymode_lint_checkers = ['pyflakes']
  let g:pymode_trim_whitespaces = 0
  let g:pymode_options = 0
  let g:pymode_rope = 0

  let g:pymode_indent = 1
  let g:pymode_folding = 0
  let g:pymode_options_colorcolumn = 1
  let g:pymode_breakpoint_bind = '<leader>br'

  "if spacevim#LayerLoaded('syntax-checking')
    "let g:pymode_lint = 0
  "endif
 "}

" switch snippet and complete key
let g:UltiSnipsExpandTrigger="<C-Space>"

let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" jedi-vim section (jedi is used to do the python auto-completion)
let g:jedi#completions_enabled = 1
let g:jedi#force_py_version = '2.7'
autocmd FileType python setlocal omnifunc=jedi#completions 
"let g:jedi#completions_command = <C-.>

autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

" My keybinding note
" \ev: edit .vimrc
" \sv: source .vimrc
