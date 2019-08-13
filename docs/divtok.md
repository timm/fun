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
   2.  function  _divt(f,  i,t) {
   3.    Tbl(t)
   4.  print 1
   5.    lines(t,"Tbl1",DOT DOT "/data/weather" DOT "csv")
   6.  print 2
   7.    is(f, length(t.rows), 14)
   8.    Divt(i,t,2,2)
   9.  }
```
