" Install vim-plug plugin manager with:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'vim-test/vim-test'
Plug 'itchyny/lightline.vim'
Plug 'diepm/vim-rest-console'
call plug#end()
" end of vim-plug

set nocompatible              " be iMproved, required
filetype off                  " required
"filetype plugin indent on
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set ruler
set hlsearch
set hidden
set listchars=eol:$,tab:>-,trail:.
set backspace=indent,eol,start
set autoread
set signcolumn=yes
set cmdheight=2
set guitablabel=%{exists('t:label')?t:label\ :''}

let g:zip_nomax=1

"colorscheme default
if has("gui_running")
	colorscheme evening
	set guifont=Liberation\ Mono\ 11
	set guioptions -=T
	set guioptions -=m
	set guioptions +=c
    nnoremap <C-S-T> :tabnew<CR>
    nnoremap <C-S-W> :tabclose<CR>
endif

"highlight Pmenu ctermbg=3 guibg=DarkYellow

set undodir=~/.vim/undo
set undofile

let mapleader="\\"

nnoremap <leader>l :set list!<CR>
nnoremap <leader>n :set number!<CR>
nnoremap <silent> <space><space> :call matchadd("IncSearch", expand('<cword>'))<CR>
nnoremap <silent> <Esc>/ :nohl<CR>:call clearmatches()<CR>
nnoremap <S-Up> @:
nnoremap <leader>j :%!python -m json.tool<CR>:set ft=json<CR>
nnoremap <F7> :botright terminal<CR>
nnoremap <silent> cd :exec 'cd ' . coc_project_root<CR>
nnoremap gp `[v`]

" omni completion
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" tab navigation: Alt+1, Alt+2, Alt+3,...
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt

" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

" move line up/down with Alt+up/down
nnoremap <silent> <M-Down> :m .+1<CR>==
nnoremap <silent> <M-Up> :m .-2<CR>==
inoremap <M-Down> <Esc>:m .+1<CR>==gi
inoremap <M-Up> <Esc>:m .-2<CR>==gi
vnoremap <M-Down> :m '>+1<CR>gv=gv
vnoremap <M-Up> :m '<-2<CR>gv=gv

" navigate quickfix list
nnoremap <silent> <M-n> :cnext<CR>
nnoremap <silent> <M-p> :cprev<CR>
nnoremap <silent> <M-f> :cnewer<CR>
nnoremap <silent> <M-b> :colder<CR>

" search with grep
nnoremap <leader>* :grep --include='*<C-R>=expand('%:e')<CR>' -ir "<C-R><C-W>" <C-R>%
vnoremap <leader>* :normal gv"fy<CR>:grep --include='*<C-R>=expand('%:e')<CR>' -ir "<C-R>=getreg("f")<CR>" <C-R>%
nnoremap <space>f :grep --include='*' -ir '' .


" fugitive plugin
nmap gb :GBrowse <cfile><CR>

" ctrlp plugin
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_regexp = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:30'

" vim-rest-console plugin
let g:vrc_horizontal_split=1
let g:vrc_response_default_content_type="application/json"
let g:vrc_auto_format_response_patterns = {
  \ 'json': 'python -m json.tool',
  \ 'xml': 'xmllint --format -',
\}


" Coc plugin
let g:coc_global_extensions = ['coc-explorer', 'coc-json', 'coc-pyright', 'coc-java', 'coc-java-vimspector']

" enable for GUI only
if has("gui_running")
    let g:coc_start_at_startup=1
else
    let g:coc_start_at_startup=0
endif

" Use <TAB> to trigger completion.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
"inoremap <silent><expr> <C-@> coc#refresh()
"inoremap <silent><expr> <C-Space> coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [G <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]G <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>gg <Plug>(coc-diagnostic-info)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" always open in CocList
nmap <silent> <leader>gd :<C-U>call CocActionAsync('jumpDefinition', v:false)<CR>
nmap <silent> <leader>gi :<C-U>call CocActionAsync('jumpImplementation', v:false)<CR>
nmap <silent> <leader>gr :<C-U>call CocActionAsync('jumpReferences', v:false)<CR>
" Java type hierarchy
nmap <silent> <leader>gh :CocCommand java.action.showTypeHierarchy<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nmap <silent> <leader>h  :call CocActionAsync('highlight')<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" statusline
let g:lightline = {
\ 'colorscheme': 'Tomorrow',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'readonly', 'filename', 'modified', 'gitbranch' ] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status',
\   'gitbranch': 'FugitiveHead'
\ },
\ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList --strict --ignore-case diagnostics<cr>
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
" Goto workspace symbol under cursor
nnoremap <silent><nowait> gs  :execute "CocList -I --input=".expand('<cfile>')." symbols"<CR>

" Project-Update
nmap <leader>pu :CocCommand java.projectConfiguration.update<CR>
" Project-Compile
nmap <leader>pc :CocCommand java.project.build<CR>
" Project-Import
nmap <leader>pi :CocCommand java.project.import.command<CR>
" Diagnostics list no-quit
nmap <leader>ld :CocList --strict --ignore-case --no-quit diagnostics<CR>
" Location list no-quit
nmap <leader>ll :CocList --normal --no-quit location<CR>
" Show-Incoming calls (tree view)
nmap <silent> <leader>si :call CocAction('showIncomingCalls')<CR>
" Show-Outgoing calls (tree view)
nmap <silent> <leader>so :call CocAction('showOutgoingCalls')<CR>
" Organize imports
nmap <silent> <leader>oi :CocCommand editor.action.organizeImport<CR>


" coc-explorer
nnoremap <silent> <leader><F2> :CocCommand explorer<CR>
nnoremap <silent> <leader>gs :call CocActionAsync('runCommand', 'explorer.doAction', 'closest', ['reveal:path:'.@+])<CR>

nnoremap <S-F7> :botright call term_start("bash", {"term_finish":"close","cwd":g:coc_project_root})<CR>


" Vimspector plugin
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-java-debug' ]
let g:vimspector_enable_mappings = 'HUMAN'
" VimspectorPause causes debugger freeze when use remote debug. Disable shortcut
silent! unmap <F6>

" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

nmap <Leader><F11> <Plug>VimspectorUpFrame
nmap <Leader><F12> <Plug>VimspectorDownFrame
nmap <Leader><F3> :VimspectorReset<CR>
nmap <Leader>B <Plug>VimspectorBreakpoints

" Java Remote debug
command! -nargs=0 JavaStartDebugAdapter :call _JavaStartDebugAdapter()
function! _SetJavaDAPPortCallback(err, port)
    if !empty(a:port)
        let $DAPPort = a:port
        let @" = $DAPPort
        echo 'started java debug adapter on port ' . a:port
    endif
endfunction
function _JavaStartDebugAdapter()
    call CocActionAsync('runCommand', 'vscode.java.startDebugSession', function('_SetJavaDAPPortCallback'))
endfunction

command! -nargs=0 DebugJavaRemoteApp :call _JavaDebugRemoteApp()
function! _JavaDebugRemoteApp()
    let cfg = { 'configuration': 'Java Attach' }
    if !empty($DAPPort) | let cfg.DAPPort = $DAPPort | endif
    call vimspector#LaunchWithSettings(cfg)
endfunction

" vim-test plugin
let test#strategy = "vimterminal"
"let test#java#runner = 'gradletest'
let g:test#runner_commands = ['GradleTest', 'MavenTest']
" Test Test
nmap <leader>tt :TestNearest
" Test File
nmap <leader>tf :TestFile
" Test Suite
nmap <leader>ts :TestSuite
" Test Last
nmap <leader>tl :TestLast

function! VimspectorJavaStrategy(cmd)
    if g:test#java#runner == 'gradletest' | let dbg_cmd = a:cmd . ' --debug-jvm' | endif
    if g:test#java#runner == 'maventest' | let dbg_cmd = a:cmd . ' -Dmaven.surefire.debug' | endif
    if exists("dbg_cmd")
        let cfg = { 'configuration': 'Java Run and Attach', 'DebuggeeCommand': dbg_cmd }
        if !empty($DAPPort) | let cfg.DAPPort = $DAPPort | endif
        call vimspector#LaunchWithSettings(cfg)
    endif
endfunction
let g:test#custom_strategies = {'vimspector-java': function('VimspectorJavaStrategy')}

" integration tests (gradle)
command! -nargs=* TestSuiteInt   :TestSuite   -x test integrationTest <args>
command! -nargs=* TestFileInt    :TestFile    -x test integrationTest <args>
command! -nargs=* TestNearestInt :TestNearest -x test integrationTest <args>

" debug java test with Vimspector
command! -nargs=* DebugJavaUnitTest :TestNearest -strategy=vimspector-java <args>


" misc stuff

" switch coc project root, set java#runner for vim-test plugin
function! SetProjectRootAndJavaRunner(file)
	if exists("g:WorkspaceFolders")
		for f in g:WorkspaceFolders
			if match(a:file, f . '/', 0) == 0
                let g:coc_project_root = f
                let g:test#project_root = f
                if !empty(glob(f . '/build.gradle'))
                    let g:test#java#runner = 'gradletest'
                else
                    let g:test#java#runner = 'maventest'
                endif
                return
            endif
		endfor
	endif
endfunction
augroup misc
    autocmd!
    autocmd BufEnter * :call SetProjectRootAndJavaRunner(expand('%:p'))
augroup END

function! CopyFullFilePath()
    if @% =~ '^jdt\:\/\/'
        let p = split(substitute(@%, '%5C', '', "g"), '?=\|=/')
        if index(p, 1) | let @+ = substitute(substitute(p[1], '^.*//', '/', ""), '%60.*', '', "") | return | endif
    endif
    let @+ = @%
endfunction
nnoremap <silent> <leader>c :call CopyFullFilePath()<CR>

function! CopyJavaQualifiedClassName()
    let doc = CocAction('getHover')
    if get(doc, 0, '') != ''
        let res = substitute(substitute(doc[0],'(.*','',''),'.\{-} ','','')
        let @+ = res
        echo res
    endif
endfunction
nnoremap <silent> <leader>qc :call CopyJavaQualifiedClassName()<CR>

function! _JavaGradleDependencies(module, ...)
    let cfg = get(a:, 1, "compileClasspath")
    let bufname = ":".a:module.":".cfg.":dependencies"
    execute "silent! bd! ".bufname
    call term_start(["./gradlew", "-q", a:module.":dependencies", "--configuration", cfg],{"cwd":g:coc_project_root, "term_name":bufname})
endfunction
" args: [module] | [module configuration]. Default configuration 'compileClasspath'
command! -nargs=+ JavaGradleDependencies :call _JavaGradleDependencies(<f-args>)

function! _JavaGradleDependencyInsight(module, dependency, ...)
    let cfg = get(a:, 2, "compileClasspath")
    let bufname = ":".a:module.":".cfg.":".a:dependency.":dependencyInsight"
    execute "silent! bd! ".bufname
    call term_start(["./gradlew", "-q", a:module.":dependencyInsight", "--configuration", cfg, "--dependency", a:dependency],{"cwd":g:coc_project_root, "term_name":bufname})
endfunction
" args: [module dependency] | [module dependency configuration]. Default configuration 'compileClasspath'
command! -nargs=+ JavaGradleDependencyInsight :call _JavaGradleDependencyInsight(<f-args>)

function VrcHandleResponse()
    if match(getline("."), '^##.*<<.\+') == -1 | return | endif
    let cmd = map(split(getline("."), '##\|<<'), {k,v -> trim(v, ' ', 1)})
    let output = getbufline(bufnr(get(g:, 'vrc_output_buffer_name', get(b:, 'vrc_output_buffer_name', '__REST_response__'))), 1, "$")
    if len(output)
        let repl = system(cmd[1], output)
        if len(cmd[0])
            call setline(1, map(getline(1, '$'), {k,v -> substitute(v, '^'.cmd[0].'.*', cmd[0].trim(repl), '')}))
        else
            call setqflist([], line('.') == a:firstline ? 'r' : 'a',
            \    {'items': map(split(repl, '\n'), {k,v -> {'text':v, 'lnum':line('.')}})})
            let currWin = winnr()
            copen | execute currWin . 'wincmd w'
        endif
    endif
endfunction
autocmd FileType rest nnoremap <buffer> <C-h> :call VrcHandleResponse()<CR>
autocmd FileType rest inoremap <buffer> <C-h> :call VrcHandleResponse()<CR>
autocmd FileType rest vnoremap <buffer> <C-h> :call VrcHandleResponse()<CR>
