let testfiles = {'input':'test_001.txt'}
execute ":edit" testfiles.input
call setpos('.',[0,1,1,0])
let pos = getpos('.')
let expected_pos = pos
let expected = { 'f' : { 'pos' : expected_pos } }
let p = parasang#Make()
let s:fail = p.fail
let s:Parse = p.Parse
let actual = s:fail->s:Parse(pos,line('$'))
call assert_equal(expected,actual,"basic test")
bwipeout!

echo v:errors
