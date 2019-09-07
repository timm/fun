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
   1.  function Abcds(i,learner,wait,train,classify)  {
   2.    i.train    = train    =="" ? learner "Train"    : train
   3.    i.classify = classify =="" ? learner "Classify" : test
   4.    i.wait     = wait     =="" ? 20                 : want
   5.    has(i,"learn",learner)
   6.    has(i,"abcd","Abcd" )
   7.  }
```

```awk
   8.  function Abcds1(i,r,lst,    train,classify) {
   9.    train = i.train
  10.    print("train",train)
  11.    @train(i.learn,r,lst)
  12.    if( r > i.wait ) {
  13.      classify = i.classify
  14.      print("class",classify)
  15.      got      = @classify(i.learn,r,lst)
  16.      print(2)
  17.      want     = lst[ i.learn.my.class ]
  18.      Abcd1(i.abcd, want,got) 
  19.      print(3)
  20.    }
  21.  }
```

```awk
  22.  function Abcd(i, data,rx)  {
  23.    Object(i)
  24.    has(i,"known")
  25.    has(i,"a")
  26.    has(i,"b")
  27.    has(i,"c")
  28.    has(i,"d")
  29.    i.rx   = rx==""? "rx" : rx
  30.    i.data = data==""? "data" : data
  31.    i.yes  = i.no = 0
  32.  }
```

```awk
  33.  function Abcd1(i,want, got,   x) {
  34.    if (++i.known[want] == 1) i.a[want]= i.yes + i.no 
  35.    if (++i.known[got]  == 1) i.a[got] = i.yes + i.no 
  36.    want == got ? i.yes++ : i.no++ 
  37.    for (x in i.known) 
  38.      if (want == x) 
  39.        want == got ? i.d[x]++ : i.b[x]++
  40.      else 
  41.        got == x      ? i.c[x]++ : i.a[x]++
  42.  }
```

```awk
  43.  function AbcdReport(i,   
  44.                      x,p,q,r,s,ds,pd,pf,
  45.                      pn,prec,g,f,acc,a,b,c,d) {
  46.    p = " %4.2f"
  47.    q = " %4s"
  48.    r = " %5s"
  49.    s = " |"
  50.    ds= "----"
  51.    printf(r s r s r s r s r s r s r s q s q s q s q s q s q s " class\n",
  52.          "db","rx","num","a","b","c","d","acc","pre","pd","pf","f","g")
  53.    printf(r  s r s r s r s r s r s r s q s q s q s q s q s q s "-----\n",
  54.           ds,ds,"----",ds,ds,ds,ds,ds,ds,ds,ds,ds,ds)
  55.    for (x in i.known) {
  56.      pd = pf = pn = prec = g = f = acc = 0
  57.      a = i.a[x]
  58.      b = i.b[x]
  59.      c = i.c[x]
  60.      d = i.d[x]
  61.      if (b+d > 0     ) pd   = d     / (b+d) 
  62.      if (a+c > 0     ) pf   = c     / (a+c) 
  63.      if (a+c > 0     ) pn   = (b+d) / (a+c) 
  64.      if (c+d > 0     ) prec = d     / (c+d) 
  65.      if (1-pf+pd > 0 ) g=2*(1-pf) * pd / (1-pf+pd) 
  66.      if (prec+pd > 0 ) f=2*prec*pd / (prec + pd)   
  67.      if (i.yes + i.no > 0 ) 
  68.         acc  = i.yes / (i.yes + i.no) 
  69.    printf(r s    r s  r s        r s r s r s r s p s p s  p s p s p s p s  " %s\n",
  70.           i.data,i.rx,i.yes+i.no,a,  b,  c,  d,  acc,prec,pd, pf, f,  g,  x)
  71.  }}
```

