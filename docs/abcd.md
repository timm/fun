---
title: abcd.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# abcd.fun
## Compute classifier  performance measures


Uses:  "[funny](funny)"<br>

To use this code:

1. Create an `Abcd` object.
2. Run your classifier on a test suite. Take the `predicted` and `actual` classification and throw it a `Abcd1`.
3. After that, get  a report using `AbcdReport`.

For example suppose:

- Six times, `yes` objects are predicted to be `yes`;
- Twice, a `no` obect is rpedicted to be `no`;
- Five times, `maybe`s are called `maybe`s;
- And once, a `maybe` is called `no`.

After all that,  `AbcdReport` would print:

```
    db |    rx |   num |     a |     b |     c |     d |  acc |  pre |   pd |   pf |    f |    g | class
  ---- |  ---- |  ---- |  ---- |  ---- |  ---- |  ---- | ---- | ---- | ---- | ---- | ---- | ---- |-----
  data |    rx |    14 |    11 |       |     1 |     2 | 0.93 | 0.67 | 1.00 | 0.08 | 0.80 | 0.96 | no
  data |    rx |    14 |     8 |       |       |     6 | 0.93 | 1.00 | 1.00 | 0.00 | 1.00 | 1.00 | yes
  data |    rx |    14 |     8 |     1 |       |     5 | 0.93 | 1.00 | 0.83 | 0.00 | 0.91 | 0.91 | maybe
```

```awk
   1.  function Abcds(i,learn,wait,train,classify)  {
   2.    i.train    = train    =="" ? learn "Train"    : train
   3.    i.classify = classify =="" ? learn "Classify" : classify
   4.    i.wait     = wait     =="" ? 20               : wait
   5.    has(i,"learn",learn)
   6.    has(i,"abcd","Abcd" )
   7.  }
```

```awk
   8.  function Abcds1(i,r,lst,    train,classify, got,want) {
   9.    if( r > i.wait ) {
  10.      classify = i.classify
  11.      got      = @classify(i.learn,r,lst)
  12.      want     = lst[ i.learn.tbl.my.class ]
  13.      Abcd1(i.abcd, want,got) 
  14.    }
  15.    train = i.train
  16.    @train(i.learn,r,lst)
  17.  }
```

```awk
  18.  function Abcd(i, data,rx)  {
  19.    Object(i)
  20.    has(i,"known")
  21.    has(i,"a")
  22.    has(i,"b")
  23.    has(i,"c")
  24.    has(i,"d")
  25.    i.rx   = rx==""? "rx" : rx
  26.    i.data = data==""? "data" : data
  27.    i.yes  = i.no = 0
  28.  }
```

```awk
  29.  function Abcd1(i,want, got,   x) {
  30.    if (++i.known[want] == 1) i.a[want]= i.yes + i.no 
  31.    if (++i.known[got]  == 1) i.a[got] = i.yes + i.no 
  32.    want == got ? i.yes++ : i.no++ 
  33.    for (x in i.known) 
  34.      if (want == x) 
  35.        want == got ? i.d[x]++ : i.b[x]++
  36.      else 
  37.        got == x      ? i.c[x]++ : i.a[x]++
  38.  }
```

```awk
  39.  function AbcdReport(i,   
  40.                      x,p,q,r,s,ds,pd,pf,
  41.                      pn,prec,g,f,acc,a,b,c,d) {
  42.    p = " %4.2f"
  43.    q = " %4s"
  44.    r = " %5s"
  45.    s = " |"
  46.    ds= "----"
  47.    printf(r s r s r s r s r s r s r s q s q s q s q s q s q s " class\n",
  48.          "db","rx","num","a","b","c","d","acc","pre","pd","pf","f","g")
  49.    printf(r  s r s r s r s r s r s r s q s q s q s q s q s q s "-----\n",
  50.           ds,ds,"----",ds,ds,ds,ds,ds,ds,ds,ds,ds,ds)
  51.    for (x in i.known) {
  52.      pd = pf = pn = prec = g = f = acc = 0
  53.      a = i.a[x]
  54.      b = i.b[x]
  55.      c = i.c[x]
  56.      d = i.d[x]
  57.      if (b+d > 0     ) pd   = d     / (b+d) 
  58.      if (a+c > 0     ) pf   = c     / (a+c) 
  59.      if (a+c > 0     ) pn   = (b+d) / (a+c) 
  60.      if (c+d > 0     ) prec = d     / (c+d) 
  61.      if (1-pf+pd > 0 ) g=2*(1-pf) * pd / (1-pf+pd) 
  62.      if (prec+pd > 0 ) f=2*prec*pd / (prec + pd)   
  63.      if (i.yes + i.no > 0 ) 
  64.         acc  = i.yes / (i.yes + i.no) 
  65.    printf(r s    r s  r s        r s r s r s r s p s p s  p s p s p s p s  " %s\n",
  66.           i.data,i.rx,i.yes+i.no,a,  b,  c,  d,  acc,prec,pd, pf, f,  g,  x)
  67.  }}
```

