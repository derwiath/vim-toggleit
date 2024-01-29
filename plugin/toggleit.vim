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

" ToggleItAdjustWindowHeight
function! s:ToggleItAdjustWindowHeightCmd(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

command! -nargs=+ ToggleItAdjustWindowHeight call <SID>ToggleItAdjustWindowHeightCmd(<f-args>)

"ToggleItMinWindowWidth
function! s:ToggleItMinWindowWidthCmd(min_width)
  let l:min_width = a:min_width + 5 * <SID>ToggleItNumberVisible()
  if winwidth(0) < l:min_width
    execute 'vertical resize ' . l:min_width
  endif
endfun

command! -nargs=1 ToggleItMinWindowWidth call <SID>ToggleItMinWindowWidthCmd(<args>)

" ToggleItQuickfixCmd
function! s:ToggleItQuickfixCmd()
  if !exists('g:vim_toggleit_quickfix_bufnr')
    let l:prev_window = winnr()
    botright copen
    call <SID>ToggleItAdjustWindowHeightCmd(g:vim_toggleit_quickfix_min_height, g:vim_toggleit_quickfix_max_height)
    execute l:prev_window . 'wincmd w'
  else
    cclose
  endif
endfun

command! -nargs=0 ToggleItQuickfix call <SID>ToggleItQuickfixCmd()

augroup ToggleItQuickfix
 autocmd!
 autocmd BufWinEnter quickfix let g:vim_toggleit_quickfix_bufnr = bufnr("$")
 autocmd BufWinLeave * if exists("g:vim_toggleit_quickfix_bufnr") && expand("<abuf>") == g:vim_toggleit_quickfix_bufnr | unlet! g:vim_toggleit_quickfix_bufnr | endif
augroup END

" ToggleItFullScreenCmd
function! s:ToggleItFullScreenCmd()
  if exists("g:neovide")
    let g:neovide_fullscreen = !g:neovide_fullscreen
  else
    if !exists('g:vim_toggleit_fullscreen')
      let g:vim_toggleit_fullscreen=0
    endif
    let g:vim_toggleit_fullscreen=!g:vim_toggleit_fullscreen
    call GuiWindowFullScreen(g:vim_toggleit_fullscreen)
  endif
endfun

command! -nargs=0 ToggleItFullScreen call <SID>ToggleItFullScreenCmd()
