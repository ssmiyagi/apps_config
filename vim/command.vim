function! s:fzf_neighbouring_files()
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = 'ag -g "" -f ' . cwd . ' --depth 0'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction

command! FZFNeigh call s:fzf_neighbouring_files()

function! s:peco_dir()
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  "let command = 'ag -g "" -f ' . cwd . ' --depth 0'
  "let command = 'ag -g "" -f ' . cwd . ' --depth 0'
  let command = 'dir -name ' . cwd . 

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction

