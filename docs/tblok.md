---
title: tblok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/license">license</a></button> <br>



# tblok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[tbl](tbl)"<br>

```awk
   1.  BEGIN { tests("tblok","_auto") }
```

```awk
   2.  func _weather(f,  t,com) { 
   3.    Tbl(t)
   4.    lines(t,"Tbl1","weather" DOT "csv")
   5.    oo(t,"t")
   6.  }
   7.  func _auto(f,  t,r,n,m) { 
   8.    srand(1)
   9.    Tbl(t)
  10.    lines(t, "Tbl1", "auto" DOT "csv")
  11.    for(r in t.rows) 
  12.      RowDoms(t.rows[r], t.rows, t)
  13.    ksort(t.rows,"dom")
  14.    n = length(t.rows)
  15.    m=5
  16.    for(r=1;r<=m;r++)
  17.      print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
  18.    print ""
  19.    for(r=n-m;r<=n;r++)
  20.      print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
  21.  }
```
