" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


let s:Vital = vital#of('cpr')
let s:Filepath = s:Vital.import('System.Filepath')
unlet s:Vital


function! cpr#lookup_cd(args)
    " Expand |filename-modifiers| .
    let dir = expand(a:args != '' ? a:args : '%:p:h')
    " Get fullpath.
    let dir = fnamemodify(dir, ':p')
    if !isdirectory(dir)
        call s:warn("No such directory: " . dir)
        return
    endif
    let dir = s:lookup_repo(dir)
    if dir !=# ''
        execute g:cpr_cd_command dir
    else
        call s:warn('Not found project directory.')
    endif
endfunction

function! s:is_root_project_dir(dir)
    " .git may be a file when its repository is a submodule.
    return isdirectory(s:Filepath.join(a:dir, '.git'))
    \   || filereadable(s:Filepath.join(a:dir, '.git'))
    \   || isdirectory(s:Filepath.join(a:dir, '.hg'))
endfunction

function! s:lookup_repo(dir)
    " Assert isdirectory(a:dir)

    let parent = s:Filepath.dirname(a:dir)
    if a:dir ==# parent    " root
        return ''
    elseif s:is_root_project_dir(a:dir)
        return a:dir
    else
        return s:lookup_repo(parent)
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
