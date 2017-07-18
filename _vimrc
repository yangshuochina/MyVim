" =============================================================================
"        << Detect OS is Windows or Linux, and open vim in cmd or GUI? >>
" =============================================================================
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

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
"  < Vundle plugin manger configuration >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 如果想在 windows 安装就必需先安装 "git for window"，可查阅网上资料
" 
" 安装bundle命令：
" git clone https://github.com/gmarik/vundle "C:\Program Files\Vim\vimfiles\bundle\vundle" 
" 
" If you want to put vim in C disk root dir, you can use bundle install command below:
"
" gmarik/vundle manage bundle cmd
" git clone https://github.com/gmarik/vundle "C:\Vim\vimfiles\bundle\vundle" 
"
" VundleVim/Vundle.vim manage bundle cmd
"git clone https://github.com/VundleVim/Vundle.vim.git c:/Vim/vimfiles/bundle/vundle
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
"Bundle 'gmarik/vundle'
Plugin 'VundleVim/Vundle.vim'

" 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）

" ----------------
"       GIT
" ----------------
"Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'

Bundle 'a.vim'

" Align code
Bundle 'junegunn/vim-easy-align'
Bundle 'Align'


Bundle 'NLKNguyen/copy-cut-paste.vim'
Bundle 'kien/ctrlp.vim'
"Bundle 'Mark--Karkat'
Bundle 'jiangmiao/auto-pairs'
"Bundle 'OmniCppComplete'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'taglist.vim'
Bundle 'vim-scripts/winmanager'
"Bundle 'Shougo/neocomplete.vim'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'yonchu/accelerated-smooth-scroll'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'altercation/vim-colors-solarized'
Bundle 'klen/python-mode'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'godlygeek/tabular'
Plugin 'flazz/vim-colorschemes'
" Plugin 'jeaye/color_coded'
Bundle 'Valloric/YouCompleteMe'

"Plugin 'ervandew/supertab'                 "有时与 snipmate 插件冲突(YCM具备这个功能)
"Plugin 'garbas/vim-snipmate'               " forked from msanders/snipmate.vim
"Bundle 'vim-scripts/vim-addon-mw-utils'
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'

"Bundle 'bufexplorer.zip'
"Bundle 'ccvext.vim'
"Bundle 'Yggdroot/indentLine'
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
"Plugin 'artur-shaik/vim-javacomplete2'
"Bundle 'mattn/emmet-vim'
"Bundle 'fholgado/minibufexpl.vim'         "好像与 Vundle 插件有一些冲突
"Bundle 'Shougo/neocomplcache.vim'
"Bundle 'repeat.vim'
"Bundle 'TxtBrowser'
"Plugin 'exvim/ex-minibufexpl'                "exvim插件之一。修复BUG
"Plugin 'sukima/xmledit'                 " Linux xml edit
Plugin 'othree/xml.vim'
Plugin 'groovy.vim'
Plugin 'fatih/vim-go'
Bundle 'bronson/vim-trailing-whitespace'

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
if g:iswindows == 1
    let Tlist_Ctags_Cmd = 'ctags'               " 设定Windows系统ctags程序位置，需要将ctags加入path变量
else
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'      " 非Windows系统设定ctags程序位置
endif

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
" copy_cut_paste.vim
""""""""""""""""""""""""""""""
let g:copy_cut_paste_no_mappings = 1
" Use your keymap
nmap QC <Plug>CCP_CopyLine
vmap QC <Plug>CCP_CopyText

nmap QX <Plug>CCP_CutLine
vmap QX <Plug>CCP_CutText

nmap QV <Plug>CCP_PasteText

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
let g:neocomplete#enable_at_startup = 0


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
if (g:iswindows)
    let g:syntastic_cpp_include_dirs = ['C:\\cygwin\\usr\\include']
else
    let g:syntastic_cpp_include_dirs = ['/usr/include/']
endif

let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
"let g:syntastic_error_symbol = '?'
"let g:syntastic_warning_symbol = '?'
"whether to show balloons
let g:syntastic_enable_balloons = 1

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
    \ 'txt' : 1,
    \ 'ini' : 1,
    \ 'dat' : 1,
    \}

" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" 补全功能在注释中同样有效  
let g:ycm_complete_in_comments=1 

" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示 
let g:ycm_confirm_extra_conf=0      

" 开启 YCM 基于标签引擎 
let g:ycm_collect_identifiers_from_tags_files=1  

" 引入 C++ 标准库tags，这个没有也没关系，
" 只要.ycm_extra_conf.py文件中指定了正确的标准库路径  
set tags+=/data/misc/software/misc./vim/stdcpp.tags  

" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键  
inoremap <leader>; <C-x><C-o>  

" 补全内容不以分割子窗口形式出现，只显示补全列表  
set completeopt-=preview  

" 从第一个键入字符就开始罗列匹配项  
let g:ycm_min_num_of_chars_for_completion=1  

" 禁止缓存匹配项，每次都重新生成匹配项  
let g:ycm_cache_omnifunc=0  

" 语法关键字补全              
let g:ycm_seed_identifiers_with_syntax=1  

" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;  
let g:ycm_key_invoke_completion = '<M-;>'  

" 设置转到定义处的快捷键为ALT + G，这个功能非常赞  
nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>  

" -----------------------------------------------------------------------------
"  < PowerLine 插件配置 >
" -----------------------------------------------------------------------------
"let g:Powerline_symbols = 'fancy'

" -----------------------------------------------------------------------------
"  < vim-indent-guides 插件配置 >
" -----------------------------------------------------------------------------
" 随vim自启动
let g:indent_guides_enable_on_vim_startup=1

" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2

" 色块宽度
let g:indent_guides_guide_size=1

" 快捷键i开/关缩进可视化
:nmap<silent> <Leader>i <Plug>IndentGuidesToggle

" -----------------------------------------------------------------------------
"  < NerdTree 插件配置 >
" -----------------------------------------------------------------------------
map <F2> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------
"  < vim-nerdtree-tabs 插件配置 >
" -----------------------------------------------------------------------------
let g:nerdtree_tabs_open_on_console_startup=0       "设置打开vim的时候默认打开目录树
"map <leader>n <plug>NERDTreeTabsToggle <CR>         "设置打开目录树的快捷键
let g:nerdtree_tabs_open_on_gui_startup = 0
" -----------------------------------------------------------------------------

"  < snipmate 插件配置 >
" -----------------------------------------------------------------------------
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>

" -----------------------------------------------------------------------------
"  < Python-mode 插件配置 >
" -----------------------------------------------------------------------------
" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" -----------------------------------------------------------------------------
"  < tabular 插件配置 >
" -----------------------------------------------------------------------------
":let g:tabular_loaded = 1

" -----------------------------------------------------------------------------
" vim-scripts/vim-javacompleteex
" -----------------------------------------------------------------------------
"let g:JavaCompleteEx_JavaHome   # $JAVA_HOME
"let g:JavaCompleteEx_ClassPath  # $CLASSPATH

"set omnifunc=javacomplete_ex#Complete

autocmd FileType java setlocal omnifunc=javacomplete#Complete

nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
nmap <leader>jii <Plug>(JavaComplete-Imports-Add)

imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
imap <C-j>ii <Plug>(JavaComplete-Imports-Add)

nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)

imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)

nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)

imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)

vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)

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
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

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

" Use PowerLine plugin, so ignore following settings.
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  

" 设置字体类型和字体大小

if g:iswindows
    "set guifont=YaHei_Consolas_Hybrid:h10               " 设置字体:字号（字体名称空格用下划线代替）
    "set guifont=DejaVu_Sans_Mono:h11
    "set guifont=Consolas:h11 " :cANSI
    "set guifont=Inconsolata:h12
    "set guifont=Monospace:h10
    "set guifont=Consolas:h12:b
    set guifont=Courier_New:h11 ":b
    "set guifont=Source_Code_Pro:h12:b
endif

if g:islinux
    set gfn=Source\ Code\ Pro\ 10,Bitstream\ Vera\ Sans\ Mono\ 10
    "set guifontwide=WenQuanYi\ Zen\ Hei\ 10
endif


set nowrap                                            " 设置不自动换行
set shortmess=atI                                     " 去掉欢迎界面
" set gcr=a:block-blinkon0                            " 禁止光标闪烁

" 设置 gVim 窗口初始位置及大小
if g:isGUI
    "au GUIEnter * simalt ~x                           " 窗口启动时自动最大化
    winpos 160 90                                     " 指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                          " 指定窗口大小，lines为高度，columns为宽度
endif

"================================================================
" 设置代码配色方案
"================================================================
let g:solarized_termcolors=56
let g:solarized_italic=0
if g:isGUI
    "Gvim配色方案
   " set background=light
    set background=dark

    "colorscheme Tomorrow-Night-Eighties
    "colorscheme molikai
    "colorscheme desert
    "colorscheme solarized
    "colorscheme blue
    "colorscheme darkblue
    "color ron
    "color evening
    color biogoo
else
    "终端配色方案
    "set background=light
    set background=dark

    colorscheme solarized
    "colorscheme Tomorrow-Night-Eighties
endif


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
set noundofile
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




" -----------------------------------------------------------------------------
"  < PC_LINT 配置 >
" -----------------------------------------------------------------------------
"set efm=%f\ \ %l\ \ %c\ \ %m 

" map f4 to run lint
"map <f4> :call LintProject()<cr>

"use windows default shell
"set shell=cmd.exe

"function! LintProject()
"    new "open a new buffer
"    exec 'silent r! lint-nt c:\lint\vim\std.lnt *.c -b'

    "remove blank line at the top of the file
"    exe "normal ggdd"       
"    caddb "add content of the buffer to the quickfix window
"    close "close the buffer
"    copen "open quickfix window
"endfunction

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
    if (g:iswindows)
        if &filetype == 'c'
	        "exec "!g++ % -o %<"
		    "exec "!time ./%<"
	    	exec "!g++ % -o %<"
	    	exec "! %<"
    	elseif &filetype == 'cpp'
		    exec "!g++ % -o %<"
	    	exec "!time ./%<"
    	elseif &filetype == 'java' 
	    	exec "!javac %" 
	    	exec "!time java %<"
    	elseif &filetype == 'sh'
	    	:!time bash %
    	elseif &filetype == 'python'
	    	exec "!time python2.7 %"
        elseif &filetype == 'html'
           exec "!firefox % &"
        elseif &filetype == 'go'
"           exec "!go build %<"
            exec "!time go run %"
        elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
	    endif
    else
        if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
    	elseif &filetype == 'cpp'
		    exec "!g++ % -o %<"
	    	exec "!time ./%<"
    	elseif &filetype == 'java' 
	    	exec "!javac %" 
	    	exec "!time java %<"
    	elseif &filetype == 'sh'
	    	:!time bash %
    	elseif &filetype == 'python'
	    	exec "!time python2.7 %"
        elseif &filetype == 'html'
           exec "!firefox % &"
        elseif &filetype == 'go'
"           exec "!go build %<"
            exec "!time go run %"
        elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
        endif
    endif
endfunc


"  C,C++的调试
map <c-F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc
