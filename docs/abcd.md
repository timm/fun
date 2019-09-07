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
   4.    i.wait     = wait     =="" ? 20               : want
   5.    has(i,"learn",learn)
   6.    has(i,"abcd","Abcd" )
   7.  }
```

```awk
   8.  function Abcds1(i,r,lst,    train,classify) {
   9.    print("learn",length(i.learn))
  10.  
  11.    train = i.train
  12.    print("train",train,"wait", i.wait)
  13.    @train(i.learn,r,lst)
  14.    if( r > i.wait ) {
  15.      oo(lst,"lst"r )
  16.      classify = i.classify
  17.      print("class",classify)
  18.      got      = @classify(i.learn,r,lst)
  19.      print(2)
  20.      want     = lst[ i.learn.my.class ]
  21.      Abcd1(i.abcd, want,got) 
  22.      print(3)
  23.    }
  24.  }
```

```awk
  25.  function Abcd(i, data,rx)  {
  26.    Object(i)
  27.    has(i,"known")
  28.    has(i,"a")
  29.    has(i,"b")
  30.    has(i,"c")
  31.    has(i,"d")
  32.    i.rx   = rx==""? "rx" : rx
  33.    i.data = data==""? "data" : data
  34.    i.yes  = i.no = 0
  35.  }
```

```awk
  36.  function Abcd1(i,want, got,   x) {
  37.    if (++i.known[want] == 1) i.a[want]= i.yes + i.no 
  38.    if (++i.known[got]  == 1) i.a[got] = i.yes + i.no 
  39.    want == got ? i.yes++ : i.no++ 
  40.    for (x in i.known) 
  41.      if (want == x) 
  42.        want == got ? i.d[x]++ : i.b[x]++
  43.      else 
  44.        got == x      ? i.c[x]++ : i.a[x]++
  45.  }
```

```awk
  46.  function AbcdReport(i,   
  47.                      x,p,q,r,s,ds,pd,pf,
  48.                      pn,prec,g,f,acc,a,b,c,d) {
  49.    p = " %4.2f"
  50.    q = " %4s"
  51.    r = " %5s"
  52.    s = " |"
  53.    ds= "----"
  54.    printf(r s r s r s r s r s r s r s q s q s q s q s q s q s " class\n",
  55.          "db","rx","num","a","b","c","d","acc","pre","pd","pf","f","g")
  56.    printf(r  s r s r s r s r s r s r s q s q s q s q s q s q s "-----\n",
  57.           ds,ds,"----",ds,ds,ds,ds,ds,ds,ds,ds,ds,ds)
  58.    for (x in i.known) {
  59.      pd = pf = pn = prec = g = f = acc = 0
  60.      a = i.a[x]
  61.      b = i.b[x]
  62.      c = i.c[x]
  63.      d = i.d[x]
  64.      if (b+d > 0     ) pd   = d     / (b+d) 
  65.      if (a+c > 0     ) pf   = c     / (a+c) 
  66.      if (a+c > 0     ) pn   = (b+d) / (a+c) 
  67.      if (c+d > 0     ) prec = d     / (c+d) 
  68.      if (1-pf+pd > 0 ) g=2*(1-pf) * pd / (1-pf+pd) 
  69.      if (prec+pd > 0 ) f=2*prec*pd / (prec + pd)   
  70.      if (i.yes + i.no > 0 ) 
  71.         acc  = i.yes / (i.yes + i.no) 
  72.    printf(r s    r s  r s        r s r s r s r s p s p s  p s p s p s p s  " %s\n",
  73.           i.data,i.rx,i.yes+i.no,a,  b,  c,  d,  acc,prec,pd, pf, f,  g,  x)
  74.  }}
```

