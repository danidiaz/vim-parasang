" keys starting in lowercase denote parser values that should never
" be invoked as functions from outside
function parasang#Make()
    return 
        \ { 
        \ 'Parse' : funcref('s:Parse'), 
        \ 'Fail' : funcref('s:Fail'), 
        \ 'eof' : funcref('s:Eof'),
        \ 'eol' : funcref('s:Eol'),
        \ 'Then' : funcref('s:Then') ,
        \ '_Then' : funcref('s:_Then'),  
        \ 'Then_' : funcref('s:Then_')  
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
        return l:r
    else
        let [new_pos, value] = l:r.s 
        return a:f(l:value)(l:new_pos,a:max_lnum)
    endif
endfunction

function s:_Then(m,n)
    return funcref('s:_ThenClos',[a:m,a:n])
endfunction

function s:_ThenClos(m, n, pos, max_lnum)
    let r = a:m(a:pos, a:max_lnum)
    if has_key(l:r,'f')
        return l:r
    else
        let [new_pos, @_] = l:r.s 
        return a:n(l:new_pos,a:max_lnum)
    endif
endfunction

function s:Then_(m,n)
    return funcref('s:ThenClos_',[a:m,a:n])
endfunction 

function s:ThenClos_(m, n, pos, max_lnum)
    let m_r = a:m(a:pos, a:max_lnum)
    if has_key(l:m_r,'f')
        return l:m_r
    else
        let [m_new_pos, m_value] = l:m_r.s 
        let n_r = a:n(l:m_new_pos,a:max_lnum)
        if has_key(l:n_r,'f')
            return l:n_r
        else
            let [n_new_pos, @_] = l:rn.s 
            return Success(n_new_pos,m_value)
        endif
    endif
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

