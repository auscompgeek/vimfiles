" Taken from https://github.com/ConradIrwin/vim-bracketed-paste.
" Prefers native Neovim and Vim 8 support.

" Code from:
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
" and then https://github.com/aaronjensen/vimfiles/blob/59a7019b1f2d08c70c28a41ef4e2612470ea0549/plugin/terminaltweaks.vim
" to fix the escape time problem with insert mode.
"
" Docs on bracketed paste mode:
" http://www.xfree86.org/current/ctlseqs.html
" Docs on mapping fast escape codes in vim
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim

" Neovim and Vim 8.0.0210 have bracketed paste support.
if has('nvim') || v:version >= 801 || (v:version == 800 && has('patch210'))
	finish
endif

let &t_ti .= "\<Esc>[?2004h"
let &t_te .= "\<Esc>[?2004l"

function! XTermPasteBegin()
	set paste pastetoggle=<f29>
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
imap <expr> <f28> XTermPasteBegin()
cmap <f28> <nop>
cmap <f29> <nop>
