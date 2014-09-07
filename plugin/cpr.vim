" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if get(g:, 'loaded_cpr', 0) || &cp
    finish
endif
let g:loaded_cpr = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}



let g:cpr_cd_command = get(g:, 'cpr_cd_command', 'cd')
let g:cpr_autochdir_to_proj = get(g:, 'cpr_autochdir_to_proj', 0)



if g:cpr_autochdir_to_proj
    augroup chdir-proj-root
        autocmd!
        autocmd BufReadPost * silent CPRLookupCD
    augroup END
endif

command!
\   -bar -complete=dir -nargs=?
\   CPRLookupCD
\   call cpr#lookup_cd(<q-args>)


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
