---
title: tblok.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# tblok.fun

```awk
   1.  @include "funny"
   2.  @include "tbl"
```

```awk
   3.  BEGIN { tests("tblok","_auto") }
```

```awk
   4.  func _weather(f,  t,com) { 
   5.    Tbl(t)
   6.    lines(t,"Tbl1","weather" DOT "csv")
   7.    oo(t,"t")
   8.  }
   9.  func _auto(f,  t,r,n,m) { 
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
