""""""""""""""""""""""""""""""""""""""
" Version: 1.0.1
""""""""""""""""""""""""""""""""""""""
" 2011-11-30 10:22
""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" source
""""""""""""""""""""""""""""""""""""""
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set runtimepath+=~/.vim/vimgdb_runtime
set runtimepath+=~/.vim/extra

"judge the system 
function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

"set the menu & the message to English
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim 

""""""""""""""""""""""""""""""""""""""
" Basic 常规
""""""""""""""""""""""""""""""""""""""
"编码
"set encoding=utf-8
"set fileencoding=cp936
set fileencodings=ucs-bom,utf-8,gb18030,gb2312,gbk,cp936
"文件类型识别
filetype plugin indent on
"设置shell
"set shell=bash
"关闭兼容模式
set nocompatible
"外部修改时自动读取
set autoread
"设置历史
set history=400
"设置mapleader
let mapleader=","
let g:mapleader=","
let g:C_MapLeader=","
"switch case对齐
set cino=:0g0t0(sus
set textwidth=0
set wrapmargin=0
"auto trailing whitespace
autocmd BufWritePre *.c :%s/\s\+$//e
autocmd BufWritePre *.h :%s/\s\+$//e
autocmd BufWritePre Kconfig :%s/\s\+$//e
autocmd BufWritePre Makefile :%s/\s\+$//e
"设置窗口大小
"set lines=40
"set columns=80

"set gvim
if has("gui_running")
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    "set showtabline=0 " 隐藏Tab栏
endif

""""""""""""""""""""""""""""""""""""""
" Style 界面
""""""""""""""""""""""""""""""""""""""
"显示行号
set number
"显示光标位置
set ruler
"增强命令行补全
set wildmenu
"设置命令行高度
set cmdheight=2
"set statusline
"set statusline=%<[%n][%f]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ [POS=%04l,%04v][%p%%]
"set laststatus=2
"减少刷新和重画

set lz
"设置退格键
set backspace=eol,start,indent
"设置跨行键
set whichwrap+=<,>,h,l
"搜索时忽略大小写
set ignorecase
"搜索时高亮关键字
set hlsearch
"Immediate search
set incsearch
"设置magic
set magic
"关闭提示音
set noerrorbells
set novisualbell
"set vb t_vb=
"autocmd GUIEnter * set vb t_vb= 
autocmd VimEnter * set vb t_vb= 
"自动匹配括号
set showmatch
set mat=2
"语法高亮
syntax enable
"设置颜色主题
set t_Co=256
set background=dark
"source ~/.vim/plugin/CSApprox.vim  
colorscheme desert 

""""""""""""""""""""""""""""""""""""""
" Text 文本
""""""""""""""""""""""""""""""""""""""
"设置Tab键
"set expandtab
"set smarttab
set tabstop=4
set shiftwidth=4
"自动缩进与智能缩进
set autoindent
set smartindent
"换行不截断单词
set linebreak
"C风格缩进
set cindent
"set fold
autocmd FileType c,cpp  setl fdm=syntax | setl fen 

"set guifont=terminus\ 10
if MySys() == 'linux'
	set guifont=MONACO\ 10
	set guifontwide=youyuan\ 10
elseif MySys() == 'windows'
	set guifont=MONACO:h10
	"set guifontwide=YouYuan:h24:cGB2312
	"set gfw=Yahei_Mono:h15:cGB2312
endif 

"自动补全
set completeopt=longest,menuone

""""""""""""""""""""""""""""""""""""""
" From vi/vim enhanced
""""""""""""""""""""""""""""""""""""""
" tform
function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

"Fast edit vimrc
if MySys() == 'linux'
    "Fast reloading of the .vimrc
    map <silent> <leader>sv :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ev :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrs
    map <silent> <leader>sv :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ev :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif

" For windows version
"if MySys() == 'windows'
"    source $VIMRUNTIME/mswin.vim
"    behave mswin
"endif 

""""""""""""""""""""""""""""""""""""""
" Edit 编辑
""""""""""""""""""""""""""""""""""""""
set noswapfile
""把undo历史保存到文件里，这样undo不会因为vim的关闭而丢失
set undofile
""每次编辑文件都会在指定文件夹里留个备份
set backup
if MySys() == 'linux'
	set undodir=~/.tmp/undo
	set backupdir=~/.tmp/backup
elseif MySys() == 'windows'
	set undodir=~/_tmp/undo
	set backupdir=~/_tmp/backup
endif

"Insert time
"map <F3> <ESC>Go<C-R>=strftime("%c")<CR><ESC>
"autocmd BufWritePre .vimrc execute '<ESC>Go<C-R>=strftime("%c")<CR><ESC>'
"autocmd BufWritePre .vimrc execute '/\" *The end/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
"autocmd BufWritePre .vimrc execute "normal Gkc$\" \<C-R>=\strftime(\"%Y-%m-%d %H:%M\")\<CR>\<ESC>"
autocmd BufWritePre *vimrc execute "normal ggjjjc$\" \<C-R>=\strftime(\"%Y-%m-%d %H:%M\")\<CR>\<ESC>"

"进行版权声明的设置
"添加或更新头
"map <F4> :call TitleDet()<cr>'s
command! Author call TitleDet()
"map <leader>md :call TitleDet()<cr>'s 	"Modify Time

function! AddTitle()
    call append(0 ,"//=============================================================================")
    call append(1 ,"// Project: ")
    call append(2 ,"// Module: ".expand("%:t"))
    call append(3 ,"// Version: V1.0 ")
    call append(4 ,"// Author: Alan ")
    call append(5 ,"// Email: lanquan.yang@163.com")
    call append(6 ,"// Last modified: ".strftime("%Y-%m-%d %H:%M"))
    call append(7 ,"// Description: ")
    call append(8 ,"//=============================================================================")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf
"更新最近修改时间和文件名
function! UpdateTitle()
    normal m'
    execute '/\// *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/\// *Module:/s@:.*$@\=":\t\t".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function! TitleDet()
    let n=1
    "默认为添加
    while n < 10
        let line = getline(n)
        if line =~ '^\//\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

""""""""""""""""""""""""""""""""""""""
" Others
""""""""""""""""""""""""""""""""""""""
""下面的三行开启鼠标支持，gvim下右键可以弹出菜单，方便复制粘贴等
set mouse=a
set mousemodel=popup

"定义FormartSrc()
function! FormartSrc()
	exec "w"
	if &filetype == 'c'
		exec "!astyle --pad-oper --pad-paren-out --indent=tab --suffix=none %"
		exec "e! %"
	endif
endfunc

""""""""""""""""""""""""""""""""""""""
" Shortcut 快捷键
""""""""""""""""""""""""""""""""""""""
"map <F3> :call FormartSrc()<CR>
command! Astyle call FormartSrc()

" insert mode shortcut
"inoremap <C-h> <Left>
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-l> <Right>
"inoremap <C-d> <DELETE>

nmap <silent> <leader>q :q<cr> 
nmap <silent> <leader>w :w<cr> 
nmap <silent> <leader>p :set paste<cr> 
nmap <silent> <leader>bn :bn<cr> 
nmap <silent> <leader>bd :bd<cr> 

nmap <silent> <leader>fe :NERDTreeToggle<cr> 
nmap <silent> <leader>tl :TlistToggle<cr> 

""""""""""""--New--"""""""""""""""""""

""""""""""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""""""""""
"let g:netrw_winsize = 30
"nmap <silent> <leader>fe :Sexplore!<cr>

""""""""""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber 

""""""""""""""""""""""""""""""""""""""
" MiniBufferExplorer
""""""""""""""""""""""""""""""""""""""
"let g:miniBufExplorerMoreThanOne=0

""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""
"NERD Tree 设置名称
let g:NERDTree_title="[NERD Tree]" 
"NERD Tree size 
let NERDTreeWinSize = 22
"NERD Tree 配置
function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction

""""""""""""""""""""""""""""""""""""""
" winManager setting
""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "NERDTree,BufExplorer|TagList"
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
"let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
"nmap <silent> <leader>wm :WMToggle<cr> 
nmap <silent> <leader>wm :if IsWinManagerVisible() <BAR> WMToggle<CR> <BAR> else <BAR> WMToggle<CR>:q<CR> endif <CR><CR>

""""""""""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"映射LookupFile为,lk
"nmap <silent> <leader>lk :LUTags<cr>
nmap <silent> <leader>lt :LUTags<cr>
"映射LUBufs为,ll
"nmap <silent> <leader>ll :LUBufs<cr>
nmap <silent> <leader>lb :LUBufs<cr>
"映射LUWalk为,lw
"nmap <silent> <leader>lw :LUWalk<cr>
nmap <silent> <leader>lw :LUWalk<cr>

" lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    " Show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc' 

""""""""""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""""""""""
autocmd FileType c,cpp  map <buffer> <leader><space> :w<cr>:make<cr>
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr> 

""""""""""""""""""""""""""""""""""""""
" showmarks setting
""""""""""""""""""""""""""""""""""""""
" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1 
" Set hilight 
if has('gui_running')
	hi default ShowMarksHLl ctermfg=darkblue ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
	hi default ShowMarksHLu ctermfg=darkblue ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
	hi default ShowMarksHLo ctermfg=darkblue ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
	hi default ShowMarksHLm ctermfg=darkblue ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
else 
	hi default ShowMarksHLl ctermfg=yellow ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
	hi default ShowMarksHLu ctermfg=yellow ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
	hi default ShowMarksHLo ctermfg=yellow ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
	hi default ShowMarksHLm ctermfg=yellow ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
	" Yellow
	"hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
	"hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
endif 

""""""""""""""""""""""""""""""""""""""
" markbrowser setting
""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>mk :MarksBrowser<cr> 

""""""""""""""""""""""""""""""""""""""
" vimgdb setting
""""""""""""""""""""""""""""""""""""""
let g:vimgdb_debug_file = "" 
run macros/gdb_mappings.vim 

""""""""""""""""""""""""""""""""""""""
" stardict 
""""""""""""""""""""""""""""""""""""""
if MySys() == 'linux'
	if has('gui_running')
		function! Mybln()
			let expl=system('sdcv -n ' .
						\ v:beval_text .
						\ '|fmt -cstw 40')
			return expl
		endfunction

		set bexpr=Mybln()
		set beval
	else
		function! Mydict()
			let expl=system('sdcv -n ' .
						\ expand("<cword>"))
			windo if
						\ expand("%")=="diCt-tmp" |
						\ q!|endif
			25vsp diCt-tmp
			setlocal buftype=nofile bufhidden=hide noswapfile
			1s/^/\=expl/
			1
		endfunction
		nmap T :call Mydict()<CR>
	endif 
endif 

""""""""""""""""""""""""""""""""""""""
" FuzzyFinder 
""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>fb :FufBuffer<CR>
nmap <silent> <leader>ff :FufFile<CR>
nmap <silent> <leader>fd :FufDir<CR>
" F4和shift+F4调用FuzzyFinder命令行菜单"
function! GetAllCommands()
redir => commands
silent command
redir END
return map((split(commands, "\n")[3:]),
   \      '":" . matchstr(v:val, ''^....\zs\S*'')')
endfunction

" 自定义命令行
let g:fuf_com_list=[':FufBuffer',':FufFile',':FufCoverageFile',':FufDir',
		 \':FufMruFile',':FufMruCmd',':FufBookmarkFile',
		 \':FufBookmarkDir',':FufTag',':FufBufferTag',
		 \':FufTaggedFile',':FufJumpList',':FufChangeList',
		 \':FufQuickfix',':FufLine',':FufHelp',
		 \":FufFile \<C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]\<CR>",
		 \":FufDir \<C-r>=expand('%:p:~')[:-1-len(expand('%:p:~:t'))]\<CR>",
		 \]      
"nnoremap <silent> <S-F4> :call fuf#givencmd#launch('', 0, '选择命令>', GetAllCommands())<CR>
"nnoremap <silent> <F4> :call fuf#givencmd#launch('', 0, '选择命令>', g:fuf_com_list)<CR>
nnoremap <silent> <leader>Fz :call fuf#givencmd#launch('', 0, '选择命令>', GetAllCommands())<CR>
nnoremap <silent> <leader>fz :call fuf#givencmd#launch('', 0, '选择命令>', g:fuf_com_list)<CR>

""""""""""""""""""""""""""""""""""""""
" Snipmate
""""""""""""""""""""""""""""""""""""""
let g:SuperTabMappingForward="<tab>" 
let g:SuperTabMappingBackward="<s-tab>"

""""""""""""""""""""""""""""""""""""""
" AhthorInfo
""""""""""""""""""""""""""""""""""""""
 let g:vimrc_author='Alan' 
 let g:vimrc_email='lanquan.yang@163.com' 
 let g:vimrc_homepage='http://www.google.com' 
  
 nmap <F4> :AuthorInfoDetect<cr> 

""""""""""""""""""""""""""""""""""""""
" Neocomplcache
""""""""""""""""""""""""""""""""""""""
"" Disable AutoComplPop. 
let g:acp_enableAtStartup = 0 
"" Use neocomplcache. 
"let g:neocomplcache_enable_at_startup = 1 
"" Use smartcase. 
"let g:neocomplcache_enable_smart_case = 1 
"" Use camel case completion. 
"let g:neocomplcache_enable_camel_case_completion = 1 
"" Use underbar completion. 
"let g:neocomplcache_enable_underbar_completion = 1 
"" Set minimum syntax keyword length. 
"let g:neocomplcache_min_syntax_length = 3 
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*' 
"
"" Define dictionary. 
"let g:neocomplcache_dictionary_filetype_lists = { 
"    \ 'default' : '', 
"    \ 'vimshell' : $HOME.'/.vimshell_hist', 
"    \ 'scheme' : $HOME.'/.gosh_completions' 
"    \ } 
"
"" Define keyword. 
"if !exists('g:neocomplcache_keyword_patterns') 
"    let g:neocomplcache_keyword_patterns = {} 
"endif 
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*' 
"
"" Plugin key-mappings. 
"imap <C-k>     <Plug>(neocomplcache_snippets_expand) 
"smap <C-k>     <Plug>(neocomplcache_snippets_expand) 
"inoremap <expr><C-g>     neocomplcache#undo_completion() 
"inoremap <expr><C-l>     neocomplcache#complete_common_string() 
"
"" SuperTab like snippets behavior. 
""imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>" 
"
"" Recommended key-mappings. 
"" <CR>: close popup and save indent. 
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" 
"" <TAB>: completion. 
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" 
"" <C-h>, <BS>: close popup and delete backword char. 
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>" 
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>" 
"inoremap <expr><C-y>  neocomplcache#close_popup() 
"inoremap <expr><C-e>  neocomplcache#cancel_popup() 
"
"" AutoComplPop like behavior. 
""let g:neocomplcache_enable_auto_select = 1 
"
"" Shell like behavior(not recommended). 
""set completeopt+=longest 
""let g:neocomplcache_enable_auto_select = 1 
""let g:neocomplcache_disable_auto_complete = 1 
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>" 
""inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" 
"
"" Enable omni completion. 
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS 
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags 
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS 
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete 
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 
"
"" Enable heavy omni completion. 
"if !exists('g:neocomplcache_omni_patterns') 
"let g:neocomplcache_omni_patterns = {} 
"endif 
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::' 
""autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete 
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

""""""""""""""""""""""""""""""""""""""
" Code_complete
""""""""""""""""""""""""""""""""""""""
let g:completekey = "<c-j>"

""""""""""""""""""""""""""""""""""""""
" The end 
""""""""""""""""""""""""""""""""""""""
