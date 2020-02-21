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
