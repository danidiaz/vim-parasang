# vim-parasang
UNDER CONSTRUCTION



# stuff I found useful while writing this plugin

- `:h search()` 
- `:h searchpos()` Example `:echo searchpos("\\%#fooo","ceW")`
- `:h match()`
- `echo match('aaa bbb ccc','^bbb',4)`
- [How can I get a token from a search in a whole file in vimscript?](https://stackoverflow.com/questions/1228100/substituting-zero-width-match-in-vim-script) Strange that there isn't a more direct way.
- `:h \%#` Matches current cursor position.
- [Functional Parsing - Computerphile](https://www.youtube.com/watch?v=dDtZLm7HIJs)
- [Vimscript functions must start with a capital letter if they are unscoped!](https://learnvimscriptthehardway.stevelosh.com/chapters/23.html)

> Even if you do add a scope to a function (we'll talk about that later) you may as well capitalize the first letter of function names anyway. Most Vimscript coders seem to do it, so don't break the convention.

- `:h method` about the `->` style of function and lambda chaining.
- [how do you get the number of lines in the current file using vimscript?](https://stackoverflow.com/questions/13372621/in-vim-how-do-you-get-the-number-of-lines-in-the-current-file-using-vimscript)

- `:h local-variable`
- [Get the length/number of colums in the current line/row](https://vi.stackexchange.com/questions/21086/get-the-length-number-of-colums-in-the-current-line-row)

- `:h func-closure`

Non-lambda closures defined inside functions are available outside the
functions, that's gross.

```
    function Foo()
        function! Bar() closure
            return 7
        endfunction
    endfunction
```

