if exists("g:loaded_coffee_tools") || &cp
  finish
endif

let g:loaded_coffee_tools = '0.3.0' " version number
let s:keepcpo          = &cpo
set cpo&vim

if !exists('g:coffee_tools_split_command')
  let g:coffee_tools_split_command = 'split'
endif

if !exists('g:coffee_tools_autojump')
  let g:coffee_tools_autojump = 0
endif

command! CoffeePreviewOpen   call coffee_tools#CoffeePreviewOpen()
command! CoffeePreviewClose  call coffee_tools#CoffeePreviewClose()
command! CoffeePreviewToggle call coffee_tools#CoffeePreviewToggle()
