---
title: abcd.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# abcd.fun
## Compute classifier  performance measures

Uses:  "[funny](funny)"<br>

```awk
   1.  function Abcd(i, data,rx)  {
   2.    Object(i)
   3.    has(i,"known")
   4.    has(i,"a")
   5.    has(i,"b")
   6.    has(i,"c")
   7.    has(i,"d")
   8.    i.rx   = rx==""? "rx" : rx
   9.    i.data = data==""? "data" : data
  10.    i.yes  = i.no = 0
  11.  }
```

```awk
  12.  function Abcd1(i,actual, predicted,   x) {
  13.    if (++i.known[actual]    == 1) i.a[actual]   = i.yes + i.no 
  14.    if (++i.known[predicted] == 1) i.a[predicted]= i.yes + i.no 
  15.    actual == predicted ? i.yes++ : i.no++ 
  16.    for (x in i.known) 
  17.      if (actual == x) 
  18.        actual == predicted ? i.d[x]++ : i.b[x]++
  19.      else 
  20.        predicted == x      ? i.c[x]++ : i.a[x]++
  21.  }
```

```awk
  22.  function AbcdReport(i,   x,p,q,s,ds,pd,pf,pn,prec,g,f,acc,a,b,c,d) {
  23.    p = " %4.2f"
  24.    q = " %4s"
  25.    r = " %5s"
  26.    s = " |"
  27.    ds= "----"
  28.    printf(r s r s r s r s r s r s r s q s q s q s q s q s q s " class\n",
  29.          "db","rx","num","a","b","c","d","acc","pre","pd","pf","f","g")
  30.    printf(r  s r s r s r s r s r s r s q s q s q s q s q s q s "-----\n",
  31.           ds,ds,"----",ds,ds,ds,ds,ds,ds,ds,ds,ds,ds)
  32.    for (x in i.known) {
  33.      pd = pf = pn = prec = g = f = acc = 0
  34.      a = i.a[x]
  35.      b = i.b[x]
  36.      c = i.c[x]
  37.      d = i.d[x]
  38.      if (b+d > 0     ) pd   = d     / (b+d) 
  39.      if (a+c > 0     ) pf   = c     / (a+c) 
  40.      if (a+c > 0     ) pn   = (b+d) / (a+c) 
  41.      if (c+d > 0     ) prec = d     / (c+d) 
  42.      if (1-pf+pd > 0 ) g=2*(1-pf) * pd / (1-pf+pd) 
  43.      if (prec+pd > 0 ) f=2*prec*pd / (prec + pd)   
  44.      if (i.yes + i.no > 0 ) 
  45.         acc  = i.yes / (i.yes + i.no) 
  46.    printf(r s    r s  r s        r s r s r s r s p s p s  p s p s p s p s  " %s\n",
  47.           i.data,i.rx,i.yes+i.no,a,  b,  c,  d,  acc,prec,pd, pf, f,  g,  x)
  48.  }}
```

