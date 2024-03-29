" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Chiel92/vim-autoformat'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Syntax highlighting
syntax on

" Folding according to syntax highlighting rules
set fdm=syntax
set foldlevelstart=99

" Use the mouse
set mouse=a

" Line numbering
set number

" 80c width
set colorcolumn=81

" highlight whitespace at EOL
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" highlight TODO or FIXME
:highlight Todos ctermbg=yellow guibg=yellow
:match Todos /\(TODO\|FIXME\)/

" use real regexes like an adult
:nnoremap / /\v
:cnoremap %s/ %s/\v
:cnoremap s/ s/\v
:xnoremap '<,'>s/ '<,'>s/\v
:xnoremap / /\v
:xnoremap s/ s/\v

" put Git magic on anybody in Git
au BufRead,BufNewFile ~/git* call SetGitTabs()
function SetGitTabs()
  setlocal noexpandtab
  setlocal softtabstop=0
  setlocal shiftwidth=8
endfunction

" sometimes we need it on files that usually should follow Google convention 
command Git call SetGitTabs()

" use the cool highlighter for mutt mail replies
autocmd BufNewFile,BufRead /tmp/mutt* set syntax=replydiff
autocmd BufNewFile,BufRead ~/tmp/mutt* set syntax=replydiff

highlight CustomHighlighted ctermbg=green guibg=green
function HighlightThisLine()
  let line=getline('.')
  :matchaddpos("CustomHighlighted", line)
endfunction

" use Felipe Contreras's sharness highlighter
au! BufRead,BufNewFile */git*/t/*.sh set ft=sharness

" handy read thing for getting code snippets
function ReadExcerpt(file, start, end)
  let sedscript = "read!sed -n \"" . a:start . "," . a:end . "p\" \"" . a:file . "\""
  :exe sedscript
endfunction
command -nargs=+ -complete=file Excerpt call ReadExcerpt(<f-args>)

" look for filename in a new split
function s:DoVimDef(name)
  let $VIMDEF_FROM_VIM=1
  let l:def = system("~/.vimdef.sh " . a:name)
  let l:argv = split(l:def)
  if (len(l:argv) == 2)
    let l:loc = l:argv[0]
    let l:file = l:argv[1]
    exec "split" l:loc l:file
  else
    echo l:def
  endif
endfunction
command -nargs=1 VimDef call s:DoVimDef(<f-args>)
