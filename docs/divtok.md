---
title: divtok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# divtok.fun


Uses:  "[funny](funny)"<br>
Uses:  "[divt](divt)"<br>
Uses:  "[tbl](tbl)"<br>

```awk
   1.  BEGIN { tests("divtok", "_divt") }
```

```awk
   2.  function  _divt(f,  i,t,r) {
   3.    Tbl(t)
   4.    lines(t,"Tbl1",DOT DOT "/data/auto" DOT "csv")
   5.    for(r in t.rows) 
   6.      RowDoms(t.rows[r], t.rows, t)
   7.    is(f, length(t.rows), 14)
   8.    Divt(i,t,2,"dom")
   9.    oo(t.my.nums)
  10.  }
```
