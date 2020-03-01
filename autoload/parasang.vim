" keys starting in lowercase denote parser values that should never
" be invoked as functions from outside
function parasang#Make()
    return 
        \ { 
        \ 'Parse' : funcref('s:Parse'), 
        \ 'fail' : funcref('s:Fail'), 
        \ 'eof' : funcref('s:Eof'),
        \ 'eol' : funcref('s:Eol')  
        \ } 
endfunction

" pos a two-element list of [current_lnum, last_parsed_col] 
"   where last_parse_col should be 0 for new columns
function s:Parse(parser,pos,max_lnum)
    return a:parser(a:pos,a:max_lnum)
endfunction

function s:Fail(pos,max_lnum)
    return { 'f' : { 'pos' : a:pos } }
endfunction

function s:Eof(pos,max_lnum)
    if a:pos[0] > a:max_lnum
        return { 's' : [a:pos,''] }
    else
    return s:Fail(a:pos,a:max_lnum)
endfunction 

function s:Eol(pos,max_lnum)
    let [lnum,cnum] = a:pos
    if l:lnum > a:max_lnum
        return s:Fail(a:pos,a:max_lnum)
    endif
    let llen = strlen(getline(l:lnum))
    if l:cnum == l:llen
        return { 's' : [ [l:lnum+1,0], ''] }
    endif
    return s:Fail(a:pos,a:max_lnum)
endfunction 

