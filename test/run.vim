let testfiles = {'input':'test_001.txt'}
execute ":edit" testfiles.input
call setpos('.',[0,1,1,0])
let pos = getpos('.')
let expected_pos = pos
let expected = { 'f' : { 'pos' : expected_pos } }
let actual = expected
call assert_equal(expected,actual,"basic test")
bwipeout!

echo v:errors
