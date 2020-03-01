let p = parasang#Make()
let s:fail = p.fail
let s:eof = p.eof
let s:eol = p.eol
let s:Parse = p.Parse

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,0]
let s:expected = { 'f' : { 'pos' : s:pos } }
let s:actual = s:fail->s:Parse(s:pos,line('$'))
call assert_equal(s:expected,s:actual,"basic")
bwipeout!

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [2,0]
let s:expected = { 's' : [s:pos,''] } 
let s:actual = s:eof->s:Parse(s:pos,line('$'))
call assert_equal(s:expected,s:actual,"eof - at eof")
bwipeout!

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,0]
let s:expected = { 'f' : { 'pos' : s:pos } }
let s:actual = s:eof->s:Parse(s:pos,line('$'))
call assert_equal(s:expected,s:actual,"eof - not at eof")
bwipeout!

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,2]
let s:expected = { 's' : [[2,0], ''] }
let s:actual = s:eol->s:Parse(s:pos,line('$'))
call assert_equal(s:expected,s:actual,"eol - at eol")
bwipeout!

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,1]
let s:expected = { 'f' : { 'pos' : [1,1] } }
let s:actual = s:eol->s:Parse(s:pos,line('$'))
call assert_equal(s:expected,s:actual,"eol - not at eol")
bwipeout!

echo v:errors
