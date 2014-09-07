" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


let s:Vital = vital#of('cpr')
let s:Prelude = s:Vital.import('Prelude')
let s:Filepath = s:Vital.import('System.Filepath')
unlet s:Vital


function! cpr#lookup_cd(args)
    " Expand |filename-modifiers| .
    let dir = expand(a:args != '' ? a:args : '%:p:h')
    " Get fullpath.
    let dir = fnamemodify(dir, ':p')
    if !isdirectory(dir)
        call s:warn("No such a directory: " . dir)
        return
    endif
    let dir = s:Prelude.path2project_directory(dir)
    if dir !=# ''
        execute g:cpr_cd_command dir
    else
        call s:warn('Not found a project directory.')
    endif
endfunction

function! s:echomsg(hl, msg)
    execute 'echohl' a:hl
    try
        echomsg a:msg
    finally
        echohl None
    endtry
endfunction

function! s:warn(msg)
    call s:echomsg('WarningMsg', a:msg)
endfunction


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
