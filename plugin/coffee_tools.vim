if exists('g:loaded_coffee_tools') || &cp
  finish
endif

let g:loaded_coffee_tools = '0.0.1' " version number
let s:keepcpo             = &cpo
set cpo&vim

if !exists('g:coffee_tools_split_command')
  let g:coffee_tools_split_command = 'split'
endif

if !exists('g:coffee_tools_autojump')
  let g:coffee_tools_autojump = 0
endif

command! CoffeePreviewOpen   call coffee_tools#OpenPreview()
command! CoffeePreviewClose  call coffee_tools#ClosePreview()
command! CoffeePreviewToggle call coffee_tools#TogglePreview()
