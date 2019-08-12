---
title: tblok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# tblok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[tbl](tbl)"<br>

```awk
   1.  BEGIN { tests("tblok","_weather,_auto") }
```

```awk
   2.  function _weather(f,  t,com) { 
   3.    Tbl(t)
   4.    print(1)
   5.    lines(t,"Tbl1",DOT DOT "/data/weather" DOT "csv")
   6.    oo(t,"t")
   7.    is(f, length(t.rows), 14)
   8.  }
   9.  function _auto(f,  t,r,n,m) { 
  10.    srand(1)
  11.    Tbl(t)
  12.    lines(t, "Tbl1", "auto" DOT "csv")
  13.    for(r in t.rows) 
  14.      RowDoms(t.rows[r], t.rows, t)
  15.    ksort(t.rows,"dom")
  16.    n = length(t.rows)
  17.    m=5
  18.    for(r=1;r<=m;r++)
  19.      print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
  20.    print ""
  21.    for(r=n-m;r<=n;r++)
  22.      print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
  23.  }
```
