function! coffee_tools#OpenPreview()
  if !exists('b:preview_file')
    call coffee_tools#InitPreview()
  endif

  if bufwinnr(b:preview_file) < 0
    exe g:coffee_tools_split_command.' '.b:preview_file
    let b:original_file = expand('#')

    doautocmd User CoffeeToolsPreviewOpened

    if !g:coffee_tools_autojump
      call coffee_tools#SwitchWindow(b:original_file)
    endif
  endif

  call coffee_tools#UpdatePreview()
endfunction

function! coffee_tools#ClosePreview()
  if exists('b:preview_file') && bufwinnr(b:preview_file) >= 0
    call coffee_tools#SwitchWindow(b:preview_file)
    quit!
  endif
endfunction

function! coffee_tools#TogglePreview()
  if !exists('b:preview_file') || bufwinnr(b:preview_file) < 0
    call coffee_tools#OpenPreview()
  else
    call coffee_tools#ClosePreview()
  endif
endfunction

function! coffee_tools#InitPreview()
  let b:preview_file    = tempname().'.js'
  let b:preview_command = printf('coffee -p %s > %s 2>&1', shellescape(expand('%')), b:preview_file)

  autocmd BufWritePost <buffer>
        \ if bufwinnr(b:preview_file) >= 0    |
        \   call coffee_tools#UpdatePreview() |
        \ endif
endfunction

function! coffee_tools#UpdatePreview()
  if !exists('b:preview_file') || bufwinnr(b:preview_file) < 0
    return
  endif

  call system(b:preview_command)

  call coffee_tools#SwitchWindow(b:preview_file)
  let b:original_file = expand('#')
  silent edit!
  syntax on " workaround for weird lack of syntax
  normal! zR
  call coffee_tools#SwitchWindow(b:original_file)
endfunction

function! coffee_tools#SwitchWindow(bufname)
  let window = bufwinnr(a:bufname)
  exe window.'wincmd w'
endfunction

function! coffee_tools#DeleteAndDedent(visual)
  if a:visual
    let depth = ((indent("'>") - indent("'<")) / &sw) + 1
    call s:DedentBelow("'>", depth)
    normal! gvd
  else
    call s:DedentBelow('.', 1)
    normal! dd
  endif

  echo
endfunction

function! coffee_tools#OpenLineAndIndent()
  let whitespace = repeat(' ', indent("'<"))
  normal! gv>O
  exe 's/^\s*/'.whitespace.'/'
  startinsert!
endfunction

function! coffee_tools#Paste(paste_key, register)
  let whitespace_pattern = '^\(\s*\).*$'
  let pasted_text        = getreg(a:register)
  let register_type      = getregtype(a:register)
  let local_whitespace   = substitute(getline('.'), whitespace_pattern, '\1', '')
  let pasted_whitespace  = substitute(pasted_text, whitespace_pattern, '\1', '')

  let formatted_lines = []
  for line in split(pasted_text, "\n")
    let line = substitute(line, '^'.pasted_whitespace, local_whitespace, '')
    call add(formatted_lines, line)
  endfor

  call setreg(a:register, join(formatted_lines, "\n"), register_type)
  exe 'normal! "'.a:register.a:paste_key
endfunction

function! s:DedentBelow(lineno, depth)
  if line(a:lineno) == line('$')
    " then it's the last line, don't mind it
    return
  endif

  let base_indent  = indent(a:lineno)
  let current_line = line(a:lineno)
  let next_line    = nextnonblank(current_line + 1)

  while current_line < line('$') && indent(next_line) > base_indent
    let current_line = next_line
    let next_line    = nextnonblank(current_line + 1)
  endwhile

  if current_line == line(a:lineno)
    " then there's nothing to dedent
    return
  endif

  let saved_cursor = getpos('.')
  silent exe (line(a:lineno) + 1).','.current_line.repeat('<', a:depth)
  call setpos('.', saved_cursor)
endfunction
