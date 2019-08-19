---
title: divt.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# divt.fun

## Chop numbers into useful ranges.

Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>
Uses:  "[the](the)"<br>
Uses:  "[num](num)"<br>

```awk
   1.  function _k1(i,t,r) {return rcol(t.rows[ i.sort[r].row ], i.k1)}
   2.  function _k2(i,t,r) {return rcol(t.rows[ i.sort[r].row ], i.k2)}
```

```awk
   3.  function Divt(i,t,k1,k2,
   4.                xs,ys,r,x,y) {
   5.    i.k1 = k1 ? k1 : t.my.class
   6.    i.k2 = k2 ? k2 : k1
   7.    has(i,"stats") 
   8.    has(i,"sort")
   9.    DivSort(i,t)
  10.    Num(xs)
  11.    Num(ys)
  12.    for(r in i.sort) {
  13.      x = _k1(i, t, r)
  14.      y = _k2(i, t, r)
  15.      if (x != "?") Num1(xs, x)
  16.      if (y != "?") Num1(ys, y) 
  17.    }
  18.    i.tiny = xs.sd * THE.div.cohen
  19.    i.step = length(i.sort) ^ THE.div.min
  20.    print(i.tiny,i.step)
  21.    DivCuts(i,t, 1,length(i.sort), xs,ys)
  22.  }
```

Sort the table rows, then place a sample of those
sorted row indexes into `i.sort` (this trick means that
that we can effeciently divide very long columns).

```awk
  23.  function DivSort(i,t,     m,n,j,k,k1,v) {
  24.    n = length(t.rows)
  25.    m = THE.div.enough/(n+0.00001)
  26.    for(j=1; j<=n; j++) 
  27.      if (rand() <= m)  {
  28.        v = rcol( t.rows[j], i.k1 )
  29.        if (v != "?") {
  30.          i.sort[ ++k ].row = j
  31.          i.sort[   k ].v   = v 
  32.    }} 
  33.    return ksort(i.sort,"v")
  34.  }
```

If we can find a cut between `lo` and `hi`, then recurse on each
side of the cut.  Else, `cook` the column contents (i.e. assign on
value to that column from `lo` to `hi`).

```awk
  35.  function DivCuts(i,t,lo,hi,xs,ys,pre,
  36.                   xl,yl,xr,yr,cut,r) {
  37.    Num(xl); Num(yl)
  38.    Num(xr); Num(yr)
  39.    cut = DivArgMin(i,t,lo,hi,xs,ys,xl,xr,yl,yr) 
  40.    if (cut) {
  41.      if (THE.div.verbose)
  42.        print(pre _k2(i,t,cut)," n ", hi - lo)
  43.      DivCuts(i, t,    lo, cut, xl, yl,"|  "pre)
  44.      DivCuts(i, t, cut+1,  hi, xr, yr,"|  "pre)
  45.    } 
  46.    else {
  47.      push(i.stats, ys.sd*ys.n) 
  48.      for(r=lo; r<=hi; r++)
  49.        t.rows[ i.sort[r].row ].cooked[i.k1] = xs.lo
  50.    }
  51.  }
```

`DivArgMin` finds the `cut` that splits of `lo`..`hi` such that
it most reduces the expected value of the standard deviation, after
the split. 

- Reject any split that is too small (fewer than `i.step` items);
- Reject any split which has too little difference (less than `i.tiny`) 
  between the lower/upper bound of the split. 
- If nothing satisfies those constraints, then return nothing.

```awk
  52.  function DivArgMin(i,t,lo,hi,xr,yr,xl1,xr1,yl1,yr1,
  53.                     j,cut,start,stop,yl,xl,n,best,x,y,tmp) {
  54.    start= _k1(i,t,lo)
  55.    stop = _k1(i,t,hi)
  56.    if (stop - start < i.tiny) return
  57.    Num(yl); Num(xl)
  58.    n    = hi - lo + 1
  59.    best = yr.sd
  60.    for(j=lo; j<=hi; j++) {
  61.      x  = _k1(i,t,j)
  62.      y  = _k2(i,t,j)
  63.      if (x != "?") {Num1(xl, x); NumLess(xr,x)}
  64.      if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
  65.      if (xl.n >= i.step)
  66.        if (xr.n >= i.step)
  67.          if ((x - start) > i.tiny) 
  68.            if((stop - x) > i.tiny)  {
  69.              tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
  70.              if (tmp*THE.div.trivial < best) {
  71.                cut  = j
  72.                best = tmp
  73.                become(yl,yl1); become(yr,yr1)
  74.                become(xl,xl1); become(xr,xr1) }}}
  75.    return cut
  76.  }
```

```awk
  77.  BEGIN { rogues() }
```
