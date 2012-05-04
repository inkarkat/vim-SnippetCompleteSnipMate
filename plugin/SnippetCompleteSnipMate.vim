" SnippetCompleteSnipMate.vim: Integration snipMate snippets into
" SnippetComplete plugin.
"
" DEPENDENCIES:
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	04-May-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_SnippetCompleteSnipMate') || (v:version < 700)
    finish
endif
let g:loaded_SnippetCompleteSnipMate = 1

if ! exists('g:SnippetComplete_RegisteredTypes')
    " Apparently, the SnippetComplete plugin isn't installed or active.
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:SnippetComplete_RegisteredTypes['snipMate'] = {
\   'priority': 100,
\   'pattern': '\S\+',
\   'generator': function('SnippetCompleteSnipMate#Generator')
\}

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
