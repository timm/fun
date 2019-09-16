---
title: tree.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# tree.fun

## Chop numbers into useful ranges.

Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>
Uses:  "[the](the)"<br>
Uses:  "[num](num)"<br>

```awk
   1.  function TreeSym(i,t,key,kex,klass,      add,var,a,j,x,y,tmp) {
   2.    i.key = key   ? key   : t.my.class
   3.    i.kex = kex   ? kex   : key
   4.    klass = klass ? klass : "Num"
   5.    add   = klass "1"
   6.    var   = klass "Variety"
   7.    List(a)
   8.    for(j in t.rows) {
   9.      x = rcol( t.rows[j], i.kex )
  10.      y = rcol( t.rows[j], i.key )
  11.      if ( (x != "?") && (y != "?")) {
  12.        if(! (x in a))
  13.           has(a,x,klass)
  14.        @add(a[x],y) 
  15.      }
  16.    }
  17.    i.best = 10^32
  18.    for(x in a)  {
  19.      tmp = @var(a[x])
  20.      if (tmp < i.best) {
  21.        i.cut=x
  22.        i.best=tmp }}
  23.    print ">",i.kex,i.key,"!",i.cut
  24.  }
```

`kex`
is a numeric column that we want to split such that
another column `key` is minimized. `key` can be 
numeric or symbolic, in which case we are minimizing
standard deviation or entropy (respectively). 

```awk
  25.  function TreeNum(i,t,key,kex,klass,          xs,ys) {
  26.    i.key = key ? key : t.my.class
  27.    i.kex = kex ? kex : key
  28.    klass = klass?klass : "Num"
  29.    has(i,"sort")
  30.    Num(xs, i.kex)
  31.    @klass(ys, i.key)
  32.    TreeSort(i,t,xs,ys,klass)
  33.    i.tiny = xs.sd * THE.div.cohen
  34.    i.step = length(i.sort) ^ THE.div.min
  35.    TreeArgMin(i,t, length(i.sort), xs, ys,klass)
  36.    print ">",i.kex,i.key,"!",i.cut
  37.  }
```

```awk
  38.  function TreeSort(i,t,xs,ys,klass,     m,n,j,x,y,k) {
  39.    n = length(t.rows)
  40.    m = THE.div.enough/(n+0.00001)
  41.    klass = klass "1"
  42.    for(j=1; j<=n; j++) 
  43.      if (rand() <= m)  {
  44.        x = rcol( t.rows[j], i.kex )
  45.        y = rcol( t.rows[j], i.key )
  46.        if ( (x != "?") && (y != "?")) {
  47.          Num1(xs, x) 
  48.          @klass(ys, y)
  49.          i.sort[ ++k ].row = j
  50.          i.sort[   k ].x   = x+0 
  51.          i.sort[   k ].y   = y+0 }} 
  52.    return ksort(i.sort,"x")
  53.  }
```

```awk
  54.  function TreeArgMin(i,t,hi,xr,yr,klass,
  55.                     j,start,stop,yl,xl,best,x,y,tmp,
  56.                     add, del, var) {
  57.    add  = klass "1"
  58.    del  = klass "Less"
  59.    var  = klass "Xpect"
  60.    start= i.sort[1].x
  61.    stop = i.sort[hi].x
  62.    if (stop - start < i.tiny) return
  63.    @klass(yl)
  64.    Num(xl)
  65.    i.best = @var(yl, yr)
  66.    for(j=1; j<=hi; j++) {
  67.      x = i.sort[j].x
  68.      y = i.sort[j].y
  69.      Num1(xl, x); NumLess(xr, x)
  70.      @add(yl, y); @del(yr, y) 
  71.      if (xl.n >= i.step)  
  72.        if (xr.n >= i.step) 
  73.          if ((x - start) > i.tiny)   
  74.            if((stop - x) > i.tiny)  {
  75.              tmp = @var(yl, yr) 
  76.              if (tmp*THE.div.trivial < i.best) {
  77.                i.cut  = x
  78.                i.best = tmp }}}
  79.  }
```

```awk
  80.  BEGIN { rogues() }
```
