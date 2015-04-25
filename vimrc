execute pathogen#infect()

" tab indents and stuff
set sw=4
com! Hardtab set ts=4 noet
com! Softtab set ts=8 sts=4 et
Hardtab

" show line numbers
set nu

" get rid of the not-very-useful GUI toolbar
set go-=T

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
nnoremap gz :!zeal --query "<cword>"&<CR><CR>

" my shift-finger is falling off
nnoremap ; :

" Tomorrow-Night-Bright looks weird with 88 colours.
if has('gui_running') || &t_Co == 256
	colo Tomorrow-Night-Bright

	" highlight current line
	" (lack of colors makes cursorline look weird)
	" commented because redraws take forever when enabled
	"set cursorline
endif

" indent-guides
let g:indent_guides_guide_size = 1
"hi IndentGuidesOdd ctermbg=lightgrey

" airline shiz
if (&encoding == 'utf-8' || &termencoding == 'utf-8') && (has('gui_running') || &term !~# '^linux')
	let g:airline_powerline_fonts = 1
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
