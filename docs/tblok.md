---
title: tblok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# tblok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[tbl](tbl)"<br>

#BEGIN { tests("tblok","_weather,_auto") }
```awk
   1.  BEGIN { tests("tblok","_weathernum") }
```

```awk
   2.  function _weather(f) { return _tbl0(f,"weather") }
   3.  function _weathernum(f) { return _tbl0(f,"weathernum") }
```

```awk
   4.  function _tbl0(f,d,  t,com) { 
   5.    Tbl(t)
   6.    lines(t,"Tbl1",DOT DOT "/data/" d DOT "csv")
   7.    oo(t,"t")
   8.    is(f, length(t.rows), 14)
   9.  }
  10.  function _auto(f,  t,r,n,m) { 
  11.    srand(1)
  12.    Tbl(t)
  13.    lines(t, "Tbl1", "auto" DOT "csv")
  14.    for(r in t.rows) 
  15.      RowDoms(t.rows[r], t.rows, t)
  16.    ksort(t.rows,"dom")
  17.    n = length(t.rows)
  18.    m=5
  19.    for(r=1;r<=m;r++)
  20.      print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
  21.    print ""
  22.    for(r=n-m;r<=n;r++)
  23.      print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
  24.  }
```
