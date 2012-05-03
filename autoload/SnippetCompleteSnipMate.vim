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

let s:snipMateSigil = '%'
function! s:SnippetHint( snippetContent )
    let l:lineNum = len(split(a:snippetContent, "\n", 1))
    if l:lineNum == 1
	return s:snipMateSigil .':' . CompleteHelper#Abbreviate#Text(a:snippetContent)
    else
	return printf('%s%d:%s', s:snipMateSigil, l:lineNum, CompleteHelper#Abbreviate#Text(a:snippetContent))
    endif
endfunction

function! SnippetCompleteSnipMate#Generator()
    let l:snippets = GetSnipsInCurrentScope()
    return map(keys(l:snippets), '{ "word": v:val, "menu": s:SnippetHint(l:snippets[v:val]) }')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
