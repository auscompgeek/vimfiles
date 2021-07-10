" Configure plugins that require function calls here
" to ensure they are on 'runtimepath'.

if !has('g:vscode')
	if has('timers')
		call neomake#configure#automake('nrw', 1000)
	else
		call neomake#configure#automake('rw')
	endif
endif
