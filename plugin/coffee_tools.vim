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

if !exists('g:coffee_tools_default_mappings')
  let g:coffee_tools_default_mappings = 0
endif

if !exists('g:coffee_tools_invasive_mappings')
  let g:coffee_tools_invasive_mappings = 0
endif

if !exists('g:coffee_tools_function_text_object')
  let g:coffee_tools_function_text_object = 1
endif

if !exists('g:coffee_tools_syntax_extensions')
  let g:coffee_tools_syntax_extensions = 1
endif

command! CoffeePreviewOpen   call coffee_tools#OpenPreview()
command! CoffeePreviewClose  call coffee_tools#ClosePreview()
command! CoffeePreviewToggle call coffee_tools#TogglePreview()

nnoremap <Plug>CoffeeToolsDeleteAndDedent   :     call coffee_tools#DeleteAndDedent(0)<cr>
xnoremap <Plug>CoffeeToolsDeleteAndDedent   :<c-u>call coffee_tools#DeleteAndDedent(1)<cr>
xnoremap <Plug>CoffeeToolsOpenLineAndIndent :<c-u>call coffee_tools#OpenLineAndIndent()<cr>

nnoremap <Plug>CoffeeToolsPasteBelow :call coffee_tools#Paste('p', v:register)<cr>
nnoremap <Plug>CoffeeToolsPasteAbove :call coffee_tools#Paste('P', v:register)<cr>

nnoremap <Plug>CoffeeToolsToggleFunctionArrow :call coffee_tools#ToggleFunctionArrow()<cr>

if g:coffee_tools_invasive_mappings
  autocmd FileType coffee nmap <buffer> dd <Plug>CoffeeToolsDeleteAndDedent
  autocmd FileType coffee xmap <buffer> d  <Plug>CoffeeToolsDeleteAndDedent
  autocmd FileType coffee nmap <buffer> p  <Plug>CoffeeToolsPasteBelow
  autocmd FileType coffee nmap <buffer> P  <Plug>CoffeeToolsPasteAbove
  autocmd FileType coffee nmap <buffer> -  <Plug>CoffeeToolsToggleFunctionArrow
endif

if g:coffee_tools_default_mappings
  autocmd FileType coffee nmap <buffer> <localleader>dd <Plug>CoffeeToolsDeleteAndDedent
  autocmd FileType coffee xmap <buffer> <localleader>d  <Plug>CoffeeToolsDeleteAndDedent
  autocmd FileType coffee nmap <buffer> <localleader>p  <Plug>CoffeeToolsPasteBelow
  autocmd FileType coffee nmap <buffer> <localleader>P  <Plug>CoffeeToolsPasteAbove
  autocmd FileType coffee nmap <buffer> <localleader>-  <Plug>CoffeeToolsToggleFunctionArrow
endif

if g:coffee_tools_function_text_object
  onoremap <buffer> if :<c-u>call coffee_tools#FunctionTextObject('i')<cr>
  onoremap <buffer> af :<c-u>call coffee_tools#FunctionTextObject('a')<cr>
  xnoremap <buffer> if :<c-u>call coffee_tools#FunctionTextObject('i')<cr>
  xnoremap <buffer> af :<c-u>call coffee_tools#FunctionTextObject('a')<cr>
endif

if g:coffee_tools_syntax_extensions
  autocmd Syntax coffee syntax match coffeeConstructor +\<\zsconstructor\ze:\s*\%((.*)\)\=\s*[-=]>+
  autocmd Syntax coffee syntax match nodejsKeywords    +module\.exports\|module\|exports\|global+

  autocmd Syntax coffee hi link coffeeConstructor Operator
  autocmd Syntax coffee hi link nodejsKeywords    Operator
endif
