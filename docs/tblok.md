---
title: tblok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

|[home](http://menzies.us/fun) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/LICENSE) |

# tblok.fun
#--------- --------- --------- --------- --------- ---------

```awk
@include "funny"
@include "tbl"
```

```awk
BEGIN { tests("tblok","_auto") }
```

```awk
func _weather(f,  t,com) { 
  Tbl(t)
  lines(t,"Tbl1","weather" DOT "csv")
  oo(t,"t")
}
func _auto(f,  t,r,n,m) { 
  srand(1)
  Tbl(t)
  lines(t, "Tbl1", "auto" DOT "csv")
  for(r in t.rows) 
    RowDoms(t.rows[r], t.rows, t)
  ksort(t.rows,"dom")
  n = length(t.rows)
  m=5
  for(r=1;r<=m;r++)
    print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
  print ""
  for(r=n-m;r<=n;r++)
    print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
}
```


_&copy; 2019;, Tim Menzies, http://menzies.us _
