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
"	002	23-May-2012	Handle multi-snippets, as are defined for HTML.
"	001	04-May-2012	file creation

function! s:RenderMultiSnippet( name, snippet )
    return printf("-- %s --\n%s\n", a:name, a:snippet)
endfunction
function! s:SnippetToMatch( trigger, snippet )
    if type(a:snippet) == type([])
	let l:snippet = a:snippet[0][1] " multi-snippet := [[multi1, snippet1], ...]
	let l:snipMateSigil = len(a:snippet) . '*'
    else
	let l:snippet = a:snippet
	let l:snipMateSigil = ' %'
    endif

    let l:lineNum = len(split(l:snippet, "\n", 1))
    let l:prefix = (l:lineNum == 1 ? printf('%s  ', l:snipMateSigil) : printf('%s%d ', l:snipMateSigil, l:lineNum))
    let l:text = CompleteHelper#Abbreviate#Text(l:snippet)

    let l:matchObject = { 'word': a:trigger, 'menu': l:prefix . l:text }

    if type(a:snippet) == type([])
	let l:matchObject.info = join(map(copy(a:snippet), 's:RenderMultiSnippet(v:val[0], v:val[1])'), "\n")
    else
	if l:text !=# l:snippet
	    " When the entire snippet doesn't fit into the popup menu, offer it for
	    " showing in the preview window.
	    let l:matchObject.info = l:snippet
	endif
    endif

    return l:matchObject
endfunction

function! SnippetCompleteSnipMate#Generator()
    let l:snippets = GetSnipsInCurrentScope()
    return map(keys(l:snippets), 's:SnippetToMatch(v:val, l:snippets[v:val])')
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
