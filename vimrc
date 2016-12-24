execute pathogen#infect()

" tab indents and stuff
com! -bar -count=4 HardTab set ts=<count> sts=0 sw=<count> noet
com! -bar -count=4 SoftTab set ts=8 sts=<count> sw=<count> et
HardTab

nnoremap <expr> cot ToggleTab()
nnoremap [ot :SoftTab<CR>
nnoremap ]ot :HardTab<CR>

func ToggleTab()
	if &et
		HardTab
	else
		SoftTab
	endif
endfunc

" show line numbers
set nu

" get rid of the not-very-useful GUI toolbar
set go-=T
" and the scrollbar as well
set go-=r
" and the other one
set go-=L

" nicer font for my gvim
if has('win32')
	set guifont=Consolas
else
	set guifont=Monospace\ 9
endif

" trying to scroll a lightyear shouldn't take a year
if has('mouse')
	set mouse=a
endif

" swapfiles are annoying
set noswf

" look up word under the cursor in Zeal
nnoremap gz :!zeal "<cword>"&<CR><CR>

" pressing shift is hard
noremap <CR> :
noremap <Space> :

" Tomorrow-Night-Bright looks weird with 88 colours.
if has('gui_running') || &t_Co == 256
	colo Tomorrow-Night-Bright
endif

" enable true colour support if we're 99% sure our terminal supports it
if !has('gui_running') && ($COLORTERM == 'truecolor' ? $TERM !~ '^screen|^dvtm' : $TERM == 'xterm-termite' || $TERM =~ '^konsole')
	" vim only sets these if we're in an xterm
	if !has('nvim') && &term !~# '^xterm'
		let &t_8f = "\<Esc>[38;2;%ld;%ld;%ldm"
		let &t_8b = "\<Esc>[48;2;%ld;%ld;%ldm"
	endif
	if has('termguicolors')  " vim 7.4.1799
		set termguicolors
	elseif has('termtruecolor')  " vim 7.4.1770
		set guicolors
	elseif has('nvim')  " neovim pre-PR4690
		let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	endif
endif

" set cursor shape
if $TERM =~ '\v^xterm|^rxvt-unicode|^konsole'
	if has('nvim')
		let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
	elseif has('cursorshape')
		if $TERM =~ '^konsole' || $TERM_PROGRAM == 'iTerm.app'
			let &t_SI = "\<Esc>]50;CursorShape=1\x7"
			if exists('+t_SR')
				let &t_SR = "\<Esc>]50;CursorShape=2\x7"
			endif
			let &t_EI = "\<Esc>]50;CursorShape=0\x7"
		else
			let &t_SI = "\<Esc>[5 q"
			if exists('+t_SR')
				let &t_SR = "\<Esc>[3 q"
			endif
			let &t_EI = "\<Esc>[0 q"
		endif
	endif
endif

" apparently terminals are small?
set colorcolumn=80,132

" ignore case by default when searching, except when I use uppercase
set ignorecase smartcase

" tell me what command I'm typing
set showcmd

" airline shiz
if (&encoding == 'utf-8' || &termencoding == 'utf-8') && (has('gui_running') || $TERM !~# '^linux\|^putty')
	let g:airline_powerline_fonts = 1
else
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = '|'
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = '|'
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
set noshowmode

" supertab
let g:SuperTabDefaultCompletionType = "context"

" delimitMate
au FileType python let b:delimitMate_nesting_quotes = ['"']
au FileType markdown let b:delimitMate_nesting_quotes = ['`']

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files = ['\M.pyi$']
nnoremap <F3> :Errors<CR>
nnoremap <F4> :SyntasticToggleMode<CR>

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" tagbar
nnoremap <F8> :TagbarToggle<CR>

" emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" jedi
let g:jedi#show_call_signatures = 2

"let g:python_space_error_highlight = 1

" source a local vimrc, if any
runtime! vimrc.local
