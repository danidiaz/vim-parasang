function s:Fail(stopline)
    let pos = getpos('.')
    return { 'f' : { 'pos' : pos } }
endfunction

function s:Parse(parser,pos,stopline)
    call setpos('.',a:pos)
    return a:parser(a:stopline)
endfunction

function parasang#Make()
    return { 'parse' : funcref('s:Parse'), 'fail' : funcref('s:Fail') } 
endfunction

