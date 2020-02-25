function parasang#Make()
    return {
        \       'fail' : function('s:Fail') 
        \  }
endfunction

function s:Fail(stopline)
    let pos = getpos('.')
    return { 'pos' : a:pos }
end
