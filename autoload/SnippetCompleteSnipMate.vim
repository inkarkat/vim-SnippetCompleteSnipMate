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
function! s:SnippetToMatch( trigger, snippet )
    let l:lineNum = len(split(a:snippet, "\n", 1))
    let l:prefix = (l:lineNum == 1 ? s:snipMateSigil . ':' : printf('%s%d:', s:snipMateSigil, l:lineNum))
    let l:text = CompleteHelper#Abbreviate#Text(a:snippet)

    let l:matchObject = { 'word': a:trigger, 'menu': l:prefix . l:text }

    if l:text !=# a:snippet
	" When the entire snippet doesn't fit into the popup menu, offer it for
	" showing in the preview window.
	let l:matchObject.info = a:snippet
    endif

    return l:matchObject
endfunction

function! SnippetCompleteSnipMate#Generator()
    let l:snippets = GetSnipsInCurrentScope()
    return map(keys(l:snippets), 's:SnippetToMatch(v:val, l:snippets[v:val])')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
