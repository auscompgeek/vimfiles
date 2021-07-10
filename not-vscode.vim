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

" write files even faster
nnoremap <Leader>w :w<CR>
" fly between buffers
nnoremap <Leader>b :ls<CR>:b<Space>

augroup vimrc
	autocmd FileType html,css EmmetInstall
augroup END

if !has('packages')
	finish
endif

" tagbar
nnoremap <F8> :TagbarToggle<CR>
packadd! tagbar

packadd! vim-gitgutter
packadd! vim-airline
