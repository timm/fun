---
title: divt.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# divt.fun

## Chop numbers into useful ranges.

Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>
Uses:  "[the](the)"<br>
Uses:  "[Num](Num)"<br>

```awk
   1.  function _k1(i,t,r) {return rcol(t.rows[ i.sort[r] ], i.k1)}
   2.  function _k2(i,t,r) {return rcol(t.rows[ i.sort[r] ], i.k2)}
```

```awk
   3.  function Divt(i,t,k1,k2,
   4.                xs,ys,r,x,y) {
   5.    i.k1 = k1 ? k1 : t.my.class
   6.    i.k2 = k2 ? k2 : k1
   7.    has(i,"stats") 
   8.    has(i,"sort")
   9.    has(i,"keys")
  10.    DivSort(i,t)
  11.    Num(xs)
  12.    Num(ys)
  13.    for(r in i.sort) {
  14.      x = _k1(i, t, r)
  15.      y = _k2(i, t, r)
  16.      if (x != "?") Num1(xs, x)
  17.      if (y != "?") Num1(ys, y) 
  18.    }
  19.    i.tiny = xs.sd * THE.div.cohen
  20.    i.step = length(i.sort) ^ THE.div.min
  21.    print(i.tiny,i.step)
  22.    DivCuts(i,t, 1,length(i.sort), xs,ys)
  23.  }
```

Sort the table rows, then place a sample of those
sorted row indexes into `i.sort`.

```awk
  24.  function DivSort(i,t,     m,n,j,k) {
  25.    rsort(t.rows,  i.k1)
  26.    n = length(t.rows)
  27.    m = THE.div.enough/(n+0.00001)
  28.    for(j=1; j<=n; j++) 
  29.      if (rand() <= m) 
  30.        i.sort[++k] = j
  31.  }
```

If we can find a cut between `lo` and `hi`, then recurse on each
side of the cut.  Else, `cook` the column contents (i.e. assign on
value to that column from `lo` to `hi`).

```awk
  32.  function DivCuts(i,t,lo,hi,xs,ys,pre,
  33.                   xl,yl,xr,yr,cut,r) {
  34.    Num(xl); Num(yl)
  35.    Num(xr); Num(yr)
  36.    cut = DivArgMin(i,t,lo,hi,xs,ys,xl,xr,yl,yr) 
  37.    if (cut) {
  38.      if (THE.div.verbose)
  39.        print(pre _k1(i,t,lo),"lo",lo,"hi",hi,"d",hi-lo,"cut",cut)
  40.      DivCuts(i, t,    lo, cut, xl, yl,"|  "pre)
  41.      DivCuts(i, t, cut+1,  hi, xr, yr,"|  "pre)
  42.    } 
  43.    else {
  44.      push(i.stats, ys.sd*ys.n) 
  45.      for(r=lo; r<=hi; r++)
  46.        t.rows[ i.sort[r] ].cooked[i.k1] = xs.lo
  47.    }
  48.  }
```

`DivArgMin` finds the `cut` that splits of `lo`..`hi` such that
it most reduces the expected value of the standard deviation, after
the split. 

- Reject any splits that are too small (fewer than `i.step`
items);
- Rekect any splits which have too little difference (less than `i.tiny`)
between the lower/upper bound of the split. 
- If nothing satisfies
those constraints, then return nothing.

```awk
  49.  function DivArgMin(i,t,lo,hi,xr,yr,xl1,xr1,yl1,yr1,
  50.                     j,cut,start,stop,yl,xl,n,best,x,y,tmp) {
  51.    start= _k1(i,t,lo)
  52.    stop = _k1(i,t,hi)
  53.    if (stop - start < i.tiny) return
  54.    Num(yl); Num(xl)
  55.    n    = hi - lo + 1
  56.    best = yr.sd
  57.    for(j=lo; j<=hi; j++) {
  58.      x  = _k1(i,t,j)
  59.      y  = _k2(i,t,j)
  60.      if (x != "?") {Num1(xl, x); NumLess(xr,x)}
  61.      if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
  62.      if (xl.n >= i.step)
  63.        if (xr.n >= i.step)
  64.          if ((x - start) > i.tiny) 
  65.            if((stop - x) > i.tiny)  {
  66.              tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
  67.              if (tmp*THE.div.trivial < best) {
  68.                cut  = j
  69.                best = tmp
  70.                become(yl,yl1); become(yr,yr1)
  71.                become(xl,xl1); become(xr,xr1) }}}
  72.    return cut
  73.  }
```

```awk
  74.  BEGIN {rogues() }
```
