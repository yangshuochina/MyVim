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
"                          << ����Ϊ���Ĭ������ >>
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
"  < Linux Gvim/Vim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch        "��������
    set incsearch       "������Ҫ����������ʱ��ʵʱƥ��

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

        set mouse=a                    " ���κ�ģʽ���������
        set t_Co=256                   " ���ն�����256ɫ
        set backspace=2                " �����˸������

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif

" =============================================================================
"                          << ����Ϊ�û��Զ������� >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle plugin manger configuration >
" -----------------------------------------------------------------------------
" ���ڸ�����Ĺ���vim����������÷��ο� :h vundle ����
" ��װ����Ϊ���ն�������������
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" ������� windows ��װ�ͱ����Ȱ�װ "git for window"���ɲ�����������
" 
" ��װbundle���
" git clone https://github.com/gmarik/vundle "C:\Program Files\Vim\vimfiles\bundle\vundle" 
" 
" If you want to put vim in C disk root dir, you can use bundle install command below:
"
" gmarik/vundle manage bundle cmd
" git clone https://github.com/gmarik/vundle "C:\Vim\vimfiles\bundle\vundle" 
"
" VundleVim/Vundle.vim manage bundle cmd
"git clone https://github.com/VundleVim/Vundle.vim.git c:/Vim/vimfiles/bundle/vundle
set nocompatible                     " ���� Vi ����ģʽ
filetype off                         " �����ļ��������

if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" ʹ��Vundle������Vundle���������Ҫ�С�
"Bundle 'gmarik/vundle'
Plugin 'VundleVim/Vundle.vim'

" ����ΪҪ��װ����µĲ������ͬ�ֿⶼ�У�������д�淶��ο�������

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

"Plugin 'ervandew/supertab'                 "��ʱ�� snipmate �����ͻ(YCM�߱��������)
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
"Bundle 'vim-javacompleteex'               "���õ� Java ��ȫ���
"Plugin 'artur-shaik/vim-javacomplete2'
"Bundle 'mattn/emmet-vim'
"Bundle 'fholgado/minibufexpl.vim'         "������ Vundle �����һЩ��ͻ
"Bundle 'Shougo/neocomplcache.vim'
"Bundle 'repeat.vim'
"Bundle 'TxtBrowser'
"Plugin 'exvim/ex-minibufexpl'                "exvim���֮һ���޸�BUG
"Plugin 'sukima/xmledit'                 " Linux xml edit
Plugin 'othree/xml.vim'
Plugin 'groovy.vim'
Plugin 'fatih/vim-go'
Bundle 'bronson/vim-trailing-whitespace'

" =============================================================================
"                          << ����Ϊ���ò������ >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < a.vim ������� >
" -----------------------------------------------------------------------------
" �����л�C/C++ͷ�ļ�
" :A     ---�л�ͷ�ļ�����ռ��������
" :AV    ---�л�ͷ�ļ�����ֱ�ָ��
" :AS    ---�л�ͷ�ļ���ˮƽ�ָ��
nnoremap <silent> <F12> :A<CR> 

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
if g:iswindows == 1
    let Tlist_Ctags_Cmd = 'ctags'               " �趨Windowsϵͳctags����λ�ã���Ҫ��ctags����path����
else
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'      " ��Windowsϵͳ�趨ctags����λ��
endif

let Tlist_Show_One_File = 1             " ��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���
let Tlist_Exit_OnlyWindow = 1           " ���taglist���������һ�����ڣ����˳�vim
let Tlist_Use_Right_Window = 1          " ���Ҳര������ʾtaglist���� 
" let Tlist_Auto_Open = 1		" �Զ���Tlist

set tags=tags;				" �Զ��ӵ�ǰĿ¼����tags
set autochdir 				" �Զ����δ��ϲ�Ŀ¼����

" ��ݼ�F9����һ��tags�ļ�
nmap <F9> <Esc>:!ctags -R *<CR> 

" ��ݼ�F8����Tlist
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
"  < MiniBufExplorer ������� >
" -----------------------------------------------------------------------------
" ��������Ͳ���Buffer
" ��Ҫ����ͬʱ�򿪶���ļ��������л�

"let g:miniBufExplMapWindowNavArrows = 1     " ��Ctrl�ӷ�����л����������ҵĴ�����ȥ
"let g:miniBufExplMapWindowNavVim = 1        " ��<C-k,j,h,l>�л����������ҵĴ�����ȥ
let g:miniBufExplMapCTabSwitchBufs = 1       " ������ǿ����������ֻ����Windows�в����ã�
                                             " <C-Tab> ��ǰѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�
                                             " <C-S-Tab> ���ѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�

" �ڲ�ʹ�� MiniBufExplorer ���ʱҲ����<C-k,j,h,l>�л����������ҵĴ�����ȥ
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" -----------------------------------------------------------------------------
"  < neocomplete ������� >
" -----------------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 0


" -----------------------------------------------------------------------------
"  < syntastic ������� >
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
"  < YouCompleteMe ������� >
" -----------------------------------------------------------------------------
" �����ļ���ʽ������ YCM
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

" ��ȫ������ע����ͬ����Ч  
let g:ycm_complete_in_comments=1 

" ���� vim ���� .ycm_extra_conf.py �ļ���������ʾ 
let g:ycm_confirm_extra_conf=0      

" ���� YCM ���ڱ�ǩ���� 
let g:ycm_collect_identifiers_from_tags_files=1  

" ���� C++ ��׼��tags�����û��Ҳû��ϵ��
" ֻҪ.ycm_extra_conf.py�ļ���ָ������ȷ�ı�׼��·��  
set tags+=/data/misc/software/misc./vim/stdcpp.tags  

" YCM ���� OmniCppComplete ��ȫ���棬�������ݼ�  
inoremap <leader>; <C-x><C-o>  

" ��ȫ���ݲ��Էָ��Ӵ�����ʽ���֣�ֻ��ʾ��ȫ�б�  
set completeopt-=preview  

" �ӵ�һ�������ַ��Ϳ�ʼ����ƥ����  
let g:ycm_min_num_of_chars_for_completion=1  

" ��ֹ����ƥ���ÿ�ζ���������ƥ����  
let g:ycm_cache_omnifunc=0  

" �﷨�ؼ��ֲ�ȫ              
let g:ycm_seed_identifiers_with_syntax=1  

" �޸Ķ�C�����Ĳ�ȫ��ݼ���Ĭ����CTRL + space���޸�ΪALT + ;  
let g:ycm_key_invoke_completion = '<M-;>'  

" ����ת�����崦�Ŀ�ݼ�ΪALT + G��������ܷǳ���  
nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>  

" -----------------------------------------------------------------------------
"  < PowerLine ������� >
" -----------------------------------------------------------------------------
"let g:Powerline_symbols = 'fancy'

" -----------------------------------------------------------------------------
"  < vim-indent-guides ������� >
" -----------------------------------------------------------------------------
" ��vim������
let g:indent_guides_enable_on_vim_startup=1

" �ӵڶ��㿪ʼ���ӻ���ʾ����
let g:indent_guides_start_level=2

" ɫ����
let g:indent_guides_guide_size=1

" ��ݼ�i��/���������ӻ�
:nmap<silent> <Leader>i <Plug>IndentGuidesToggle

" -----------------------------------------------------------------------------
"  < NerdTree ������� >
" -----------------------------------------------------------------------------
map <F2> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------
"  < vim-nerdtree-tabs ������� >
" -----------------------------------------------------------------------------
let g:nerdtree_tabs_open_on_console_startup=0       "���ô�vim��ʱ��Ĭ�ϴ�Ŀ¼��
"map <leader>n <plug>NERDTreeTabsToggle <CR>         "���ô�Ŀ¼���Ŀ�ݼ�
let g:nerdtree_tabs_open_on_gui_startup = 0
" -----------------------------------------------------------------------------

"  < snipmate ������� >
" -----------------------------------------------------------------------------
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>

" -----------------------------------------------------------------------------
"  < Python-mode ������� >
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
"  < tabular ������� >
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
"  < �������� >
" -----------------------------------------------------------------------------
" ע��ʹ��utf-8��ʽ����������Դ�롢�ļ�·�����������ģ����򱨴�
set encoding=utf-8                                    "����gvim�ڲ�����
set fileencoding=utf-8                                "���õ�ǰ�ļ�����
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "����֧�ִ򿪵��ļ��ı���

" �ļ���ʽ��Ĭ�� ffs=dos,unix
set fileformat=unix                                   "�������ļ���<EOL>��ʽ
set fileformats=unix,dos,mac                          "�����ļ���<EOL>��ʽ����

if (g:iswindows && g:isGUI)
    "����˵�����
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "���consle�������
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < ��д�ļ�ʱ������ >
" -----------------------------------------------------------------------------
filetype on                                           " �����ļ��������
filetype plugin on                                    " ��Բ�ͬ���ļ����ͼ��ض�Ӧ�Ĳ��
filetype plugin indent on                             " ��������
set smartindent                                       " �������ܶ��뷽ʽ
set expandtab                                         " ��Tab��ת��Ϊ�ո�
set tabstop=4                                         " ����Tab���Ŀ��
set shiftwidth=4                                      " ����ʱ�Զ�����4���ո�
set smarttab                                          " ָ����һ��backspace��ɾ��shiftwidth��ȵĿո�

" �����������﷨���д����۵�
set foldenable                                        " �����۵�
set foldmethod=indent                                 " indent �۵���ʽ
"set foldmethod=syntax                                " syntax �۵���ʽ
"set foldmethod=marker                                " marker �۵���ʽ

set nofoldenable            " ���� vim ʱ�ر��۵�����

" �ÿո���������۵�
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" ���ļ����ⲿ���޸ģ��Զ����¸��ļ�
set autoread

" ����ģʽ������ cS �����β�ո�
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" ����ģʽ������ cM �����β ^M ����
nmap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase                              "����ģʽ����Դ�Сд
set smartcase                               "�������ģʽ������д�ַ�����ʹ�� 'ignorecase' ѡ�ֻ������������ģʽ���Ҵ� 'ignorecase' ѡ��ʱ�Ż�ʹ��
"set noincsearch                            "������Ҫ����������ʱ��ȡ��ʵʱƥ��

" Ctrl + K ����ģʽ�¹�������ƶ�
imap <c-k> <Up>

" Ctrl + J ����ģʽ�¹�������ƶ�
imap <c-j> <Down>

" Ctrl + H ����ģʽ�¹�������ƶ�
imap <c-h> <Left>

" Ctrl + L ����ģʽ�¹�������ƶ�
imap <c-l> <Right>

" ����ÿ�г���80�е��ַ���ʾ��������������»��ߣ��������þ�ע�͵�
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

"------------------------------�Զ������-----------------------------------------------
" �滻����������˵����
" confirm���Ƿ��滻ǰ��һȷ��
" wholeword���Ƿ�����ƥ��
" replace�����滻�ַ���
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
" ��ȷ�ϡ�������
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" ��ȷ�ϡ�����
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" ȷ�ϡ�������
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" ȷ�ϡ�����
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
"
" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set number                                            " ��ʾ�к�
set laststatus=2                                      " ����״̬����Ϣ
set cmdheight=2                                       " ���������еĸ߶�Ϊ2��Ĭ��Ϊ1
set cursorline                                        " ͻ����ʾ��ǰ��

set ruler                                             " ��ʾ���
set showcmd                                           " �����������ʾ�������������Щ
set scrolloff=3                                       " ����ƶ���buffer�Ķ����͵ײ�ʱ����3�о��� 

" Use PowerLine plugin, so ignore following settings.
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "״̬����ʾ������  

" �����������ͺ������С

if g:iswindows
    "set guifont=YaHei_Consolas_Hybrid:h10               " ��������:�ֺţ��������ƿո����»��ߴ��棩
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


set nowrap                                            " ���ò��Զ�����
set shortmess=atI                                     " ȥ����ӭ����
" set gcr=a:block-blinkon0                            " ��ֹ�����˸

" ���� gVim ���ڳ�ʼλ�ü���С
if g:isGUI
    "au GUIEnter * simalt ~x                           " ��������ʱ�Զ����
    winpos 160 90                                     " ָ�����ڳ��ֵ�λ�ã�����ԭ������Ļ���Ͻ�
    set lines=38 columns=120                          " ָ�����ڴ�С��linesΪ�߶ȣ�columnsΪ���
endif

"================================================================
" ���ô�����ɫ����
"================================================================
let g:solarized_termcolors=56
let g:solarized_italic=0
if g:isGUI
    "Gvim��ɫ����
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
    "�ն���ɫ����
    "set background=light
    set background=dark

    colorscheme solarized
    "colorscheme Tomorrow-Night-Eighties
endif


" ��ʾ/���ز˵������������������������� Ctrl + F11 �л�
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

"��������
set langmenu=zh_CN.UTF-8
set helplang=cn

" -----------------------------------------------------------------------------
"  < �������� >
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
"""""���ļ�����
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"�½�.c,.h,.sh,.java�ļ����Զ������ļ�ͷ 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""���庯��SetTitle���Զ������ļ�ͷ 
func SetTitle() 
	"����ļ�����Ϊ.sh�ļ� 
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
	"�½��ļ����Զ���λ���ļ�ĩβ
endfunc 
autocmd BufNewFile * normal G




" -----------------------------------------------------------------------------
"  < PC_LINT ���� >
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

"C��C++ ��F5��������
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


"  C,C++�ĵ���
map <c-F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc
