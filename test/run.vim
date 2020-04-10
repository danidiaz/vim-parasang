let p = parasang#Make()
let s:eof = p.eof
let s:eol = p.eol
let s:Fail = p.Fail
let s:Parse = p.Parse
let s:Then = p.Then
let s:_Then = p._Then
let s:Then_ = p.Then_

function s:MuteMessage(result)
    if has_key(a:result,'f')
        let [pos,_] = a:result.f
        return { 'f' : [l:pos,''] }
    endif
    return a:result
endfunction

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,0]
let s:expected = { 'f' : [ s:pos, '' ] }
let s:actual = s:Fail('')->s:Parse("",s:pos,line('$'))
call assert_equal(s:expected,s:MuteMessage(s:actual),"basic")
bwipeout!

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [2,0]
let s:expected = { 's' : [s:pos, ''] } 
let s:actual = s:eof->s:Parse("",s:pos,line('$'))
call assert_equal(s:expected,s:actual,"eof - at eof")
bwipeout!

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,0]
let s:expected = { 'f' : [ s:pos, '' ] }
let s:actual = s:eof->s:Parse("",s:pos,line('$'))
call assert_equal(s:expected,s:MuteMessage(s:actual),"eof - not at eof")
bwipeout!

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,2]
let s:expected = { 's' : [[2,0], ''] }
let s:actual = s:eol->s:Parse("",s:pos,line('$'))
call assert_equal(s:expected,s:actual,"eol - at eol")
bwipeout!

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,1]
let s:expected = { 'f' : [ [1,1], ''] }
let s:actual = s:eol->s:Parse("",s:pos,line('$'))
call assert_equal(s:expected,s:MuteMessage(s:actual),"eol - not at eol")
bwipeout!

let s:testfiles = {'input':'test_002_twoblanklines.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,0]
let s:expected = { 'f' : [ [2,0], ''] }
let s:actual = s:eol->s:Then({ _ -> s:eof})->s:Parse("",s:pos,line('$'))
call assert_equal(s:expected,s:MuteMessage(s:actual),"eol but not eof - Then")
bwipeout!

let s:testfiles = {'input':'test_002_twoblanklines.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,0]
let s:expected = { 'f' : [ [2,0], ''] }
let s:actual = s:eol->s:_Then(s:eof)->s:Parse("",s:pos,line('$'))
call assert_equal(s:expected,s:MuteMessage(s:actual),"eol but not eof - _Then")
bwipeout!

let s:testfiles = {'input':'test_002_twoblanklines.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,0]
let s:expected = { 'f' : [ [2,0], ''] }
let s:actual = s:eol->s:Then_(s:eof)->s:Parse("",s:pos,line('$'))
call assert_equal(s:expected,s:MuteMessage(s:actual),"eol but not eof - Then_")
bwipeout!

echo v:errors
