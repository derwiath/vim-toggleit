if exists("g:vim_toggleit_loaded")
	finish
endif
let g:vim_toggleit_loaded = 1

" Default values for settings
if !exists('g:vim_toggleit_quickfix_min_height')
  let g:vim_toggleit_quickfix_min_height=3
endif
if !exists('g:vim_toggleit_quickfix_max_height')
  let g:vim_toggleit_quickfix_max_height=30
endif

" ToggleItNumberCmd
function! s:ToggleItNumberCmd()
  let &number=!&number
endfun

command! -nargs=0 ToggleItNumber call <SID>ToggleItNumberCmd()
