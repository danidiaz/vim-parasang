let testfiles = {'input':'test_001.txt'}
execute ":edit" testfiles.input
call setpos('.',[0,1,1,0])
let pos = getpos('.')
let expected_pos = pos
let expected = { 'f' : { 'pos' : expected_pos } }
let p = parasang#Make()
let Parse = p.parse
let actual = p.fail->Parse(pos,line('$'))
call assert_equal(expected,actual,"basic test")
bwipeout!

echo v:errors
