let p = parasang#Make()
let s:fail = p.fail
let s:Parse = p.Parse

let s:testfiles = {'input':'test_001.txt'}
execute ":edit" s:testfiles.input
let s:pos = [1,0]
let s:expected = { 'f' : { 'pos' : s:pos } }
let s:actual = s:fail->s:Parse(s:pos,line('$'))
call assert_equal(s:expected,s:actual,"basic test")
bwipeout!

echo v:errors
