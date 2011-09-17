" auto sv and ld session 
let g:AutoSessionFile="settings.vim" 
let g:OrigPWD=getcwd() 

"if filereadable(g:AutoSessionFile)
	"echo \"workspace1"
	"if argc() == 0 
		"au VimEnter * call EnterHandler() 
		"au VimLeave * call LeaveHandler() 
	"endif 
"endif

if filereadable(g:AutoSessionFile)
	au VimEnter * call EnterHandler() 
	au VimLeave * call LeaveHandler() 
endif

function! LeaveHandler()
	exec "mks! ".g:OrigPWD."/".g:AutoSessionFile
endfunction

function! EnterHandler()
	exec "source ".g:AutoSessionFile
endfunction
