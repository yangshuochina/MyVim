" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set backspace=2                " 设置退格键可用

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif

" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 如果想在 windows 安装就必需先安装 "git for window"，可查阅网上资料
" 
" 安装bundle命令：
" git clone https://github.com/gmarik/vundle "C:\Program Files\Vim\vimfiles\bundle\vundle" 

set nocompatible                     " 禁用 Vi 兼容模式
filetype off                         " 禁用文件类型侦测

if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" 使用Vundle来管理Vundle，这个必须要有。
Bundle 'gmarik/vundle'

" 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
Bundle 'a.vim'
Bundle 'Align'
Bundle 'Mark--Karkat'
Bundle 'jiangmiao/auto-pairs'
Bundle 'OmniCppComplete'
Bundle 'scrooloose/syntastic'
Bundle 'taglist.vim'
Bundle 'vim-scripts/winmanager'
"Bundle 'Shougo/neocomplete.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Lokaltog/vim-powerline'
Bundle 'yonchu/accelerated-smooth-scroll'

"Bundle 'bufexplorer.zip'
"Bundle 'ccvext.vim'
"Bundle 'Yggdroot/indentLine'
"Bundle 'Shougo/neocomplete'
"Bundle 'scrooloose/nerdcommenter'
"Bundle 'scrooloose/nerdtree'
"Bundle 'Lokaltog/vim-powerline'
"Bundle 'msanders/snipmate.vim'
"Bundle 'wesleyche/SrcExpl'
"Bundle 'std_c.zip'
"Bundle 'tpope/vim-surround'
"Bundle 'majutsushi/tagbar'
"Bundle 'ZoomWin'
"Bundle 'tpope/vim-markdown'
"Plugin 'shawncplus/phpcomplete.vim'
"Bundle 'ctrlpvim/ctrlp.vim'
"Bundle 'cSyntaxAfter'
"Bundle 'javacomplete'
"Bundle 'vim-javacompleteex'               "更好的 Java 补全插件
"Bundle 'mattn/emmet-vim'
"Bundle 'fholgado/minibufexpl.vim'         "好像与 Vundle 插件有一些冲突
"Bundle 'Shougo/neocomplcache.vim'
"Bundle 'repeat.vim'
"Bundle 'ervandew/supertab'                "有时与 snipmate 插件冲突
"Bundle 'TxtBrowser'
"Plugin 'exvim/ex-minibufexpl'                "exvim插件之一。修复BUG


" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
filetype on                                           " 启用文件类型侦测
filetype plugin on                                    " 针对不同的文件类型加载对应的插件
filetype plugin indent on                             " 启用缩进
set smartindent                                       " 启用智能对齐方式
set expandtab                                         " 将Tab键转换为空格
set tabstop=4                                         " 设置Tab键的宽度
set shiftwidth=4                                      " 换行时自动缩进4个空格
set smarttab                                          " 指定按一次backspace就删除shiftwidth宽度的空格

" 基于缩进或语法进行代码折叠
set foldenable                                        " 启用折叠
set foldmethod=indent                                 " indent 折叠方式
"set foldmethod=syntax                                " syntax 折叠方式
"set foldmethod=marker                                " marker 折叠方式

set nofoldenable            " 启动 vim 时关闭折叠代码

" 用空格键来开关折叠
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase                              "搜索模式里忽略大小写
set smartcase                               "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
"set noincsearch                            "在输入要搜索的文字时，取消实时匹配

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
"------------------------------自定义操作-----------------------------------------------
" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
"
" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            " 显示行号
set laststatus=2                                      " 启用状态栏信息
set cmdheight=2                                       " 设置命令行的高度为2，默认为1
set cursorline                                        " 突出显示当前行

set ruler                                             " 显示标尺
set showcmd                                           " 输入的命令显示出来，看的清楚些
set scrolloff=3                                       " 光标移动到buffer的顶部和底部时保持3行距离 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  

" 设置字体类型和字体大小
"set guifont=YaHei_Consolas_Hybrid:h10               " 设置字体:字号（字体名称空格用下划线代替）
"set guifont=DejaVu_Sans_Mono:h14
set guifont=Consolas:h11 " :cANSI
"set guifont=Inconsolata:h12
"set guifont=Courier_New:h10

set nowrap                                            " 设置不自动换行
set shortmess=atI                                     " 去掉欢迎界面
" set gcr=a:block-blinkon0                            " 禁止光标闪烁

" 设置 gVim 窗口初始位置及大小
if g:isGUI
    au GUIEnter * simalt ~x                           " 窗口启动时自动最大化
    winpos 100 10                                     " 指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                          " 指定窗口大小，lines为高度，columns为宽度
endif

" 设置代码配色方案
if g:isGUI
    "colorscheme Tomorrow-Night-Eighties               "Gvim配色方案
    "colorscheme molikai
    colorscheme desert
    "colorscheme solarized
    "colorscheme darkblue
    "color ron
else
    colorscheme Tomorrow-Night-Eighties               "终端配色方案
endif

" 设置背景颜色
set background=dark

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
	    call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
	    call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: ") 
		call append(line(".")+2, "	> Mail: ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
	"新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G



" =============================================================================
"                          << 以下为常用插件配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < a.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口
nnoremap <silent> <F12> :A<CR> 



""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
"if MySys() == "windows"                " 设定windows系统中ctags程序的位置
    let Tlist_Ctags_Cmd = 'ctags'
"elseif MySys() == "linux"              " 设定windows系统中ctags程序的位置
 "   let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"endif
let Tlist_Show_One_File = 1             " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1           " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1          " 在右侧窗口中显示taglist窗口 
" let Tlist_Auto_Open = 1		" 自动打开Tlist

set tags=tags;				" 自动从当前目录查找tags
set autochdir 				" 自动依次从上层目录查找

" 快捷键F9生成一个tags文件
nmap <F9> <Esc>:!ctags -R *<CR> 

" 快捷键F8代开Tlist
nmap <F8> <Esc>:Tlist <CR>

""""""""""""""""""""""""""""""
" winManager
""""""""""""""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer' "|TagList'
"nmap wm :WMToggle<CR>
nmap <F7> <Esc>:WMToggle<CR>

" -----------------------------------------------------------------------------
"  < MiniBufExplorer 插件配置 >
" -----------------------------------------------------------------------------
" 快速浏览和操作Buffer
" 主要用于同时打开多个文件并相与切换

"let g:miniBufExplMapWindowNavArrows = 1     " 用Ctrl加方向键切换到上下左右的窗口中去
"let g:miniBufExplMapWindowNavVim = 1        " 用<C-k,j,h,l>切换到上下左右的窗口中去
let g:miniBufExplMapCTabSwitchBufs = 1       " 功能增强（不过好像只有在Windows中才有用）
                                             " <C-Tab> 向前循环切换到每个buffer上,并在但前窗口打开
                                             " <C-S-Tab> 向后循环切换到每个buffer上,并在当前窗口打开

" 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" -----------------------------------------------------------------------------
"  < neocomplete 插件配置 >
" -----------------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 1


" -----------------------------------------------------------------------------
"  < syntastic 插件配置 >
" -----------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0 
let g:syntastic_check_on_wq = 0

" -----------------------------------------------------------------------------
"  < YouCompleteMe 插件配置 >
" -----------------------------------------------------------------------------
" 以下文件格式上屏蔽 YCM
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'gitcommit' : 1,
      \}

" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" -----------------------------------------------------------------------------
"  < PowerLine 插件配置 >
" -----------------------------------------------------------------------------
"let g:Powerline_symbols = 'fancy'
