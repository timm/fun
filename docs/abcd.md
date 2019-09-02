---
title: abcd.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# abcd.fun
Uses:  "[fun](fun)"<br>

```awk
   1.  function Abcd(i, data,rx)  {
   2.    Object(i)
   3.    has(i,"known")
   4.    has(i,"a")
   5.    has(i,"b")
   6.    has(i,"c")
   7.    has(i,"d")
   8.    i.rx= rx==""? "rx" : rx
   9.    i.date= date==""? "data" : data
  10.    i.yes = i.no = 0
  11.  }
```

```awk
  12.  function Abcd1(i,want, got) {
  13.    if (++i.known[want] == 1 ) i.a[want] = i.yes + i.no 
  14.    if (++i.known[got]  == 1 ) i.a[got]  = i.yes + i.no 
  15.    want == got ?  i.yes++ : i.no++ 
  16.    for (x in i.known) {
  17.      if (want == x) 
  18.        want == got? i.d[x]++ : i.b[x]++
  19.      else 
  20.        got  == x  ? i.c[x]++ : i.a[x]++
  21.  }}
```

```awk
  22.  function AbcdReport(i,   out,pd,pf,pn,prec,g,f,acc,a,b,c,d) {
  23.    p = " %3.2f"
  24.    f = " %3s"
  25.    s = "|"
  26.    ds= "---"
  27.    printf(f s f s "%5s" s f s f s f s f s f s f s f s f s f s f s "class\n",
  28.          "db","rx","num","a","b","c","d","acc","pre","pd","pf","f","g")
  29.    printf(f s f s "%5s" s f s f s f s f s f s f s f s f s f s f s "-----\n",
  30.           ds,ds,"----",ds,ds,ds,ds,ds,ds,ds,ds,ds,ds)
  31.    for (x in i.known) {
  32.      pd = pf = pn = prec = g = f = acc = 0
  33.      a = i.a[x]
  34.      b = i.b[x]
  35.      c = i.c[x]
  36.      d = i.d[x]
  37.      if (b+d > 0     ) pd   = d     / (b+d) 
  38.      if (a+c > 0     ) pf   = c     / (a+c) 
  39.      if (a+c > 0     ) pn   = (b+d) / (a+c) 
  40.      if (c+d > 0     ) prec = d     / (c+d) 
  41.      if (1-pf+pd > 0 ) g=2*(1-pf) * pd / (1-pf+pd) 
  42.      if (prec+pd > 0 ) f=2*prec*pd / (prec + pd)   
  43.      if (i.yes + i.no > 0 ) 
  44.         acc  = i.yes / (i.yes + i.no) 
  45.    printf(f s f s "%5s" s p s p s p s p s p s p s p s p s p s p s "%s\n",
  46.           i.db,i.rx,num,a,b,c,d,acc,prec,pd,pf f,g,x)
  47.  }}
```

