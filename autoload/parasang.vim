" keys starting in lowercase denote parser values that should never
" be invoked as functions from outside
function parasang#Make()
    return { 'Parse' : funcref('s:Parse'), 'fail' : funcref('s:Fail') } 
endfunction

function s:Parse(parser,pos,stopline)
    call setpos('.',a:pos)
    return a:parser(a:stopline)
endfunction

function s:Fail(stopline)
    let pos = getpos('.')
    return { 'f' : { 'pos' : pos } }
endfunction

