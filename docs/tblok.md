---
title: tblok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# tblok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[tbl](tbl)"<br>
Uses:  "[num](num)"<br>

#BEGIN { tests("tblok","_weather,_auto") }
```awk
   1.  BEGIN { tests("tblok","_weather") }
```
#BEGIN { tests("tblok","_weathernum") }
#BEGIN { tests("tblok","_dist1") }
#BEGIN { tests("tblok","_dist2") }
#BEGIN { tests("tblok","_distances") }

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
  25.  function _dist1(f) { return _dist0(f, "auto") }
  26.  function _dist2(f) { return _dist0(f, "labor") }
```

```awk
  27.  function _dist0(f,d,   t,r1,r2) {
  28.    Tbl(t)
  29.    lines(t,"Tbl1",DOT DOT "/data/" d DOT "csv")
  30.    for(r1 in t.rows)  {
  31.      print("\n" r1, flat(t.rows[r1].cells))
  32.      for(r2 in t.rows) {
  33.        if(r2+0 > r1+0) 
  34.          print(r2, flat(t.rows[r2].cells), RowDist(t.rows[r1],t.rows[r2],t))
  35.  }}}
```


```awk
  36.  function _distances(f,  d,sum,n,i,r) {
  37.    for(d=2;d<=100;d+=5) { 
  38.       sum=0
  39.       Num(n)
  40.       r=100
  41.       for(i=1;i<=r;i++)
  42.          Num1(n,_distances1(d) )
  43.       print d,n.mu,n.sd,n.lo,n.hi}
  44.  }
  45.  function _distances1(d,   a,b) {
  46.    while(d--) {
  47.      a[d]=rand()
  48.      b[d]=rand()
  49.    }
  50.    return _distance(a,b) 
  51.  }
```
      
```awk
  52.  function _distance(a,b,  i,d) {
  53.     for(i in a) 
  54.       d += (a[i]-b[i])^2
  55.    return (d/length(a))^0.5
  56.  }
```
