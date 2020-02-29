" keys starting in lowercase denote parser values that should never
" be invoked as functions from outside
function parasang#Make()
    return { 'Parse' : funcref('s:Parse'), 'fail' : funcref('s:Fail') } 
endfunction

" pos a two-element list of [current_lnum, last_parsed_col] 
"   where last_parse_col should be 0 for new columns
function s:Parse(parser,pos,max_lnum)
    return a:parser(a:pos,a:max_lnum)
endfunction

function s:Fail(pos,max_lnum)
    return { 'f' : { 'pos' : a:pos } }
endfunction


