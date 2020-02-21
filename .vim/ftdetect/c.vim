augroup c_ft
  au!
  au BufRead,BufNewFile *.[ch] setfiletype c setlocal noexpandtab
  au FileType c setlocal noexpandtab
augroup end
