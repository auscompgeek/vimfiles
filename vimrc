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
elseif has('mac')
	set guifont=Menlo
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

" select the text I just pasted
nnoremap gp `[v`]

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

" title for fidgetingbits/knausj_talon - filename is expected after the last )
let &titlestring = (has('nvim') ? 'N' : '') . 'VIM'
	\ .' MODE:%{mode()}'
	\ .'%( %M%{&ro && &ma ?"=":""}%)'
	\ .' (%{&buflisted && &buftype == "" ? expand("%:p:~:h") : &buftype})'
	\ .'%a %t'

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

" emmet
let g:user_emmet_install_global = 0

"let g:python_space_error_highlight = 1

let g:echodoc#enable_at_startup = 1

if !exists('g:vscode')
	source <sfile>:h/not-vscode.vim
endif

" source a local vimrc, if any
runtime local.vim
