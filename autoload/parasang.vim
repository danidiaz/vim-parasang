" keys starting in lowercase denote parser values that should never
" be invoked as functions from outside
function parasang#Make()
    return 
        \ { 
        \ 'Parse' : funcref('s:Parse'), 
        \ 'Fail' : funcref('s:Fail'), 
        \ 'eof' : funcref('s:Eof'),
        \ 'eol' : funcref('s:Eol'),
        \ 'Then' : funcref('s:Then')  
        \ } 
endfunction

" pos a two-element list of [current_lnum, last_parsed_col] 
"   where last_parse_col should be 0 for new columns
function s:Parse(parser,pos,max_lnum)
    return a:parser(a:pos,a:max_lnum)
endfunction

function s:Fail(msg)
    return { pos, max_lum -> s:Failure(pos,a:msg) }
endfunction

function s:Eof(pos,max_lnum)
    if a:pos[0] > a:max_lnum
        return s:Success(a:pos,'')
    else
    return s:Failure(a:pos,'eof')
endfunction 

function s:Eol(pos,max_lnum)
    let [lnum,cnum] = a:pos
    if l:lnum > a:max_lnum
        return s:Failure(a:pos,'eol past eof')
    endif
    if l:cnum == strlen(getline(l:lnum))
        return s:Success([l:lnum + 1,0],'')
    endif
    return s:Failure(a:pos,'not at eol')
endfunction 

function s:Then(m,f)
    return funcref('s:ThenClos',[a:m,a:f])
endfunction 

function s:ThenClos(m, f, pos, max_lnum)
    let r = a:m(a:pos, a:max_lnum)
    if has_key(l:r,'f')
        return r
    else
        let [new_pos, value] = r.s 
        return a:f(l:value)(l:new_pos,a:max_lnum)
    endif
endfunction

function s:_Then(m,n)
    return { post, max_lnum -> s:Then({ _ -> n}) }
endfunction

" function s:Then_(m,n)
"     return { post, max_lnum -> s:Then({ _ -> n}) }
" endfunction

function s:Failure(pos,msg)
    return {'f' : [a:pos,a:msg]}
endfunction

function s:Success(pos,val)
    return {'s' : [a:pos,a:val]}
endfunction

