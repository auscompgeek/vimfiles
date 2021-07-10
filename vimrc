if !has('packages')
	execute pathogen#infect()
endif

" tab indents and stuff
command! -bar -count=4 HardTab set tabstop=<count> softtabstop=0 shiftwidth=0 noexpandtab
command! -bar -count=4 SoftTab set tabstop=8 softtabstop=<count> shiftwidth=<count> expandtab
HardTab

nnoremap <expr> yot ToggleTab()
nnoremap [ot :SoftTab<CR>
nnoremap ]ot :HardTab<CR>

function! ToggleTab()
	if &expandtab
		HardTab
	else
		SoftTab
	endif
endfunction

augroup vimrc
	autocmd!
augroup END

" show line numbers
set number

" get rid of the not-very-useful GUI toolbar
" not that I really use gvim...
set guioptions-=T
" and the scrollbars as well
set guioptions-=r guioptions-=L

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

" look up word under the cursor in Zeal
nnoremap gz :!zeal "<cword>"&<CR><CR>

" pressing shift is hard
noremap <Space> :

" retain visual state on shifts
vnoremap < <gv
vnoremap > >gv

" write files even faster
nnoremap <Leader>w :w<CR>
" fly between buffers
nnoremap <Leader>b :ls<CR>:b<Space>

" select the text I just pasted
nnoremap gp `[v`]

" Tomorrow-Night-Bright looks weird with 88 colours.
if has('gui_running') || &t_Co == 256
	colorscheme Tomorrow-Night-Bright
endif

" enable true colour support if we're 99% sure our terminal supports it
if !has('gui_running') && has('termguicolors') && (&t_Co == 16777216 || $COLORTERM == 'truecolor' ? $TERM !~ '^screen\|^dvtm' : $TERM == 'xterm-termite' || $TERM == 'xterm-kitty' || $TERM =~ '\v^(konsole|iterm2|vte|gnome)|-direct$')
	" vim only sets these if we're in an xterm
	if !has('nvim') && &term !~# '^xterm'
		let &t_8f = "\<Esc>[38;2;%ld;%ld;%ldm"
		let &t_8b = "\<Esc>[48;2;%ld;%ld;%ldm"
	endif
	set termguicolors

	" and use the vim-hybrid colour scheme
	let g:hybrid_custom_term_colors = 1
	set bg=dark
	colorscheme hybrid
endif

" set cursor shape
if has('cursorshape') && !has('nvim')
	if $TERM =~ '\v^(rxvt-unicode|gnome|vte|tmux|alacritty)' || ($TERM =~ '^xterm' && $TERM_PROGRAM != 'iTerm.app')
		let &t_SI = "\<Esc>[5 q"
		if exists('+t_SR')
			let &t_SR = "\<Esc>[3 q"
		endif
		let &t_EI = "\<Esc>[0 q"
	elseif $TERM =~ '^konsole\|^iterm2' || ($TERM_PROGRAM == 'iTerm.app' && $TERM =~ '^xterm')
		let &t_SI = "\<Esc>]50;CursorShape=1\x7"
		if exists('+t_SR')
			let &t_SR = "\<Esc>]50;CursorShape=2\x7"
		endif
		let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	endif
endif

" fix vim in tmux with xterm-keys on
if !has('nvim') && &term =~ '^tmux'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif

" apparently terminals are small?
set colorcolumn=80,132

" ignore case by default when searching, except when I use uppercase
set ignorecase smartcase

" tell me what command I'm typing
set showcmd

" make command mode tab complete nicer
set wildmode=longest,full

" my systems never crash
if exists('$XDG_RUNTIME_DIR')
	set directory^=$XDG_RUNTIME_DIR//
endif

" title for knausj_talon - filename is expected after the last )
let &titlestring = (has('nvim') ? 'N' : '') . 'VIM MODE:%{mode()}%( %M%{&ro && &ma ?"=":""}%) (%{expand("%:p:~:h")})%a %t'

" airline shiz
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_exclude_preview = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#hunks#non_zero_only = 1
set noshowmode

" supertab
let g:SuperTabDefaultCompletionType = "context"

" delimitMate
augroup vimrc
	autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
	autocmd FileType markdown let b:delimitMate_nesting_quotes = ['`']
	autocmd FileType lisp let b:delimitMate_quotes = '"'
augroup END

" neomake
let g:neomake_css_enabled_makers = ['stylelint']
if executable('flake8')
	" use only flake8 if it's installed
	let g:neomake_python_enabled_makers = ['flake8']
endif

nnoremap <F3> :lwindow<CR>
nnoremap <F4> :NeomakeToggle<CR>

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" tagbar
nnoremap <F8> :TagbarToggle<CR>

" emmet
let g:user_emmet_install_global = 0
augroup vimrc
	autocmd FileType html,css EmmetInstall
augroup END

" jedi
let g:jedi#show_call_signatures = 2
let g:jedi#popup_on_dot = 0

"let g:python_space_error_highlight = 1

let g:echodoc#enable_at_startup = 1

" source a local vimrc, if any
runtime! vimrc.local
