call pathogen#infect()

" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" source D:\Projects\Fenrir\working_stuff\myvimrc

let &t_Co=256

" activate filetype plugin 
filetype plugin on

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text
set guioptions-=m
set guioptions-=T
"set nowrap
"set laststatus=2


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

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

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

" color menu setting
"hi Pmenu        guifg=#00ffff guibg=#000000            ctermbg=0 ctermfg=6
"hi PmenuSel     guifg=#ffff00 guibg=#000000 		   cterm=bold ctermfg=3
"hi PmenuSbar    guibg=#204d40                          ctermbg=6
"hi PmenuThumb   guifg=#38ff56                          ctermfg=3

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
"
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>

"vnoremap ( s()<Esc>P
"vnoremap [ s[]<Esc>P
"vnoremap { s{}<Esc>P
"
"-------------------------------------------------------------------------------
" NerdTree keymapping
"-------------------------------------------------------------------------------
nmap ,,e  :NERDTreeToggle<CR>
"-------------------------------------------------------------------------------
" end of NerdTree
"-------------------------------------------------------------------------------


"
"-------------------------------------------------------------------------------
" Project keymapping
"-------------------------------------------------------------------------------
nmap <silent> ,,p <Plug>ToggleProject
autocmd BufAdd .vimprojects silent! %foldopen!

if getcwd() != $HOME
	if filereadable(getcwd(). '/.vimprojects')
		Project .vimprojects
	endif
endif

" project settings
let g:proj_flags="imstc"
let g:proj_run1="!git status"
"-------------------------------------------------------------------------------
" end of Project
"-------------------------------------------------------------------------------




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

"map <tab> <ESC>:bn<CR>
"map <s-tab> <ESC>:bp<CR>
imap <C-e> <ESC>
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
nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
"nnoremap <A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
"nnoremap <A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" grep key binding 
"map <C-F4> :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%') | cope
"map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
"map <F5> :execute "vimgrep /" . <C-r>=expand("<cword>") . "/j **" <Bar> cw<CR>


" indent section 
set noexpandtab
set autoindent smartindent
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
set tags=./tags,tags,C:/Spyro/Game/tags;
set tags+=C:/Spyro/Game/tags;
set tags+=C:/Spyro/tl/tags;
set tags+=C:/Spyro/tools/tags;
set tags+=C:/Spyro/LuxEngine/tags;

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

" Lua Tection
let g:Lua_AuthorName      = 'Benny Yang'
let g:Lua_AuthorRef       = ''
let g:Lua_Email           = 'Benny_Yang@xpec.com.tw'
let g:Lua_Company         = 'XPEC'
" End of Lua section


" buffer sel by pattern {{{
" ====================================
function! BufSel(pattern)
  let buf_count = bufnr("$")
  let cur_bufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while cur_bufnr <= buf_count
if(bufexists(cur_bufnr))
      let currbufname = bufname(cur_bufnr)
      if(match(currbufname, a:pattern) > -1)
        echo cur_bufnr . ": ". bufname(cur_bufnr)
        let nummatches += 1
        let firstmatchingbufnr = cur_bufnr
      endif
    endif
    let cur_bufnr = cur_bufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

function! BufSelInput()
  let pattern = input( "pattern: " )
call BufSel( pattern )
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")
nmap <leader>bf :call BufSelInput()<CR>
" ====================================
" }}}

" fuzzy find sectioon
"<<<<<<<<<<<<
  let g:fuf_modesDisable = []
  let g:fuf_mrufile_maxItem = 400
  let g:fuf_mrucmd_maxItem = 400

  nnoremap <silent> sj     :FufBuffer<CR>
  nnoremap <silent> sk     :FufFileWithCurrentBufferDir<CR>
  nnoremap <silent> sK     :FufFileWithFullCwd<CR>
  nnoremap <silent> s<C-k> :FufFile<CR>
  nnoremap <silent> sl     :FufCoverageFileChange<CR>
  nnoremap <silent> sL     :FufCoverageFileChange<CR>
  nnoremap <silent> s<C-l> :FufCoverageFileRegister<CR>
  nnoremap <silent> sd     :FufDirWithCurrentBufferDir<CR>
  nnoremap <silent> sD     :FufDirWithFullCwd<CR>
  nnoremap <silent> s<C-d> :FufDir<CR>
  nnoremap <silent> sn     :FufMruFile<CR>
  nnoremap <silent> sN     :FufMruFileInCwd<CR>
  nnoremap <silent> sm     :FufMruCmd<CR>
  nnoremap <silent> su     :FufBookmarkFile<CR>
  nnoremap <silent> s<C-u> :FufBookmarkFileAdd<CR>
  vnoremap <silent> s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
  nnoremap <silent> si     :FufBookmarkDir<CR>
  nnoremap <silent> s<C-i> :FufBookmarkDirAdd<CR>
  nnoremap <silent> st     :FufTag<CR>
  nnoremap <silent> sT     :FufTag!<CR>
  nnoremap <silent> s<C-]> :FufTagWithCursorWord!<CR>
  nnoremap <silent> s,     :FufBufferTag<CR>
  nnoremap <silent> s<     :FufBufferTag!<CR>
  vnoremap <silent> s,     :FufBufferTagWithSelectedText!<CR>
  vnoremap <silent> s<     :FufBufferTagWithSelectedText<CR>
  nnoremap <silent> s}     :FufBufferTagWithCursorWord!<CR>
  nnoremap <silent> s.     :FufBufferTagAll<CR>
  nnoremap <silent> s>     :FufBufferTagAll!<CR>
  vnoremap <silent> s.     :FufBufferTagAllWithSelectedText!<CR>
  vnoremap <silent> s>     :FufBufferTagAllWithSelectedText<CR>
  nnoremap <silent> s]     :FufBufferTagAllWithCursorWord!<CR>
  nnoremap <silent> sg     :FufTaggedFile<CR>
  nnoremap <silent> sG     :FufTaggedFile!<CR>
  nnoremap <silent> so     :FufJumpList<CR>
  nnoremap <silent> sp     :FufChangeList<CR>
  nnoremap <silent> sq     :FufQuickfix<CR>
  nnoremap <silent> sy     :FufLine<CR>
  nnoremap <silent> sh     :FufHelp<CR>
  nnoremap <silent> se     :FufEditDataFile<CR>
  nnoremap <silent> sr     :FufRenewCache<CR>
 "<<<<<<<<
" end of fuzzy find 

" vimya - vim for maya
let vimyaPort=12345
nnoremap <leader>sm :py sendBufferToMaya ()<cr>
vnoremap <leader>sm :py sendBufferToMaya ()<cr>
nnoremap <leader>sb :py sendBufferToMaya (True)<cr>
vnoremap <leader>sb :py sendBufferToMaya (True)<cr>
"

" taglist mel support
let tlist_mel_settings='mel;f:function'

" same shortcut for command line mode with bash
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" ,/ turn off search highlighting
nmap \\ :nohl<CR>

" path for find command
set path+=.,"C:\Program Files\Autodesk\Maya2012\include",,

" if running on Windows, set cscope database
"if has("gui_running")
  "if has("win32")
	":cs add c:\Progra~1\Autodesk\Maya2012\cscope.out c:\Progra~1\Autodesk\Maya2012
  "endif
"endif

" for xptemplate plug-in
set nocompatible
filetype plugin  on 
filetype plugin indent on 

" cpp setup for fswitch"
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '../inc'
nmap <silent> <Leader>of :FSHere<cr>
""Switch to the file and load it into the window on the right 
nmap <silent> <Leader>ol :FSRight<cr>
""Switch to the file and load it into a new window split on the right
nmap <silent> <Leader>oL :FSSplitRight<cr>
""Switch to the file and load it into the window on the left
nmap <silent> <Leader>oh :FSLeft<cr>
""Switch to the file and load it into a new window split on the left
nmap <silent> <Leader>oH :FSSplitLeft<cr>
""Switch to the file and load it into the window above 
nmap <silent> <Leader>ok :FSAbove<cr>
""Switch to the file and load it into a new window split above
nmap <silent> <Leader>oK :FSSplitAbove<cr>
""Switch to the file and load it into the window below 
nmap <silent> <Leader>oj :FSBelow<cr>
""Switch to the file and load it into a new window split below 
nmap <silent> <Leader>oJ :FSSplitBelow<cr>

"augroup filetypedetect
"autocmd BufRead,BufNewFile *.ms setf lua
"autocmd BufRead,BufNewFile *.mcr setf maxscript
"autocmd BufRead,BufNewFile *.mse setf maxscript
"augroup END

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
":noremap <2-C-LeftMouse> <C-]>

" no error bell and flash bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" grep.vim config
:let Grep_Path = 'D:\util\bin\grep.exe'
:let Fgrep_Path = 'D:\util\bin\fgrep.exe'
:let Egrep_Path = 'd:\util\bin\egrep.exe'
:let Grep_Find_Path = 'd:\util\bin\find.exe'
:let Grep_Xargs_Path = 'd:\util\bin\xargs.exe'

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  "set fileencodings=ucs-bom,utf-8,latin1
  set fileencodings=utf-8,big5,gbk,latin1
endif
" Python section
" *** syntax on will mess up the easy motion plug-in
"autocmd BufRead,BufNewFile *.py syntax on
" ***
autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead,BufNewFile *.py,*.pyw setf python
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


" Haskell section
augroup HSK
        au Bufenter *.hs compiler ghc
        autocmd FileType haskell setlocal formatoptions+=t
        autocmd FileType haskell let b:ghc_staticoptions = '-Wall -Werror'
augroup END

" You may already have the following two on, please check
syntax on
filetype plugin on

" This assumes that ghc is in your path, if it is not, or you
" wish to use a specific version of ghc, then please change
" the ghc below to a full path to the correct one
" au BufEnter *.hs compiler ghc

" For this section both of these should be set to your
" browser and ghc of choice, I used the following
" two vim lines to get those paths:
" :r!which google-chrome
" :r!whigh ghc
"let g:haddock_browser = "C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe"
"let g:ghc = "C:/Program Files (x86)/Haskell Platform/2012.2.0.0/bin/ghc"
"let g:haddock_docdir = "C:\\Program Files (x86)\\Haskell Platform\\2012.2.0.0\\doc\\html"
"let g:ghc_version = substitute(system("C:\\Program Files (x86)\\Haskell Platform\\2012.2.0.0\\bin\\ghc.exe  --numeric-version"),'\n','','')

set clipboard=unnamed

