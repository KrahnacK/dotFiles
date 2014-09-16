" Vim syntax file
" Language:     Corey Log
" Maintainer:   blepers
" Last Change:  
" URL:          
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif


"syn keyword	cTodo		31m  00m
syn match   cTodo   "\[31m" 
syn match   cTodo   "\[00m"
syn cluster	cCommentGroup	contains=cTodo


syn region	cString	start="\[31m" skip=+\\\\\|\\"+ end="\[00m" contains=@cCommentGroup keepend
hi def link cString String
hi link cTodo		Ignore

let b:current_syntax = "wdiff"

