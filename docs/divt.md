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
  19.    i.step = length(t.rows) ^ THE.div.min
  20.    print(i.tiny,i.step)
  21.    DivCuts(i,t, 1,length(i.sort), xs,ys)
  22.  }
```

Sort the table rows, then place a sample of those
sorted row indexes into `i.sort` (this trick means that
that we can effeciently divide very long columns).

```awk
  23.  function DivSort(i,t,     m,n,j,k1) {
  24.    n = length(t.rows)
  25.    m = THE.div.enough/(n+0.00001)
  26.    for(j=1; j<=n; j++) 
  27.      if (rand() <= m)  {
  28.       print 1
  29.        k1 = rcol( t.rows[j], i.k1 )
  30.      print 2
  31.        i.sort[ k1 ] = j 
  32.    }
  33.    PROCINFO["sorted_in"] = "@ind_num_asc"
  34.    return asorti(i.sort)
  35.  }
```

If we can find a cut between `lo` and `hi`, then recurse on each
side of the cut.  Else, `cook` the column contents (i.e. assign on
value to that column from `lo` to `hi`).

```awk
  36.  function DivCuts(i,t,lo,hi,xs,ys,pre,
  37.                   xl,yl,xr,yr,cut,r) {
  38.    Num(xl); Num(yl)
  39.    Num(xr); Num(yr)
  40.    cut = DivArgMin(i,t,lo,hi,xs,ys,xl,xr,yl,yr) 
  41.    if (cut) {
  42.      if (THE.div.verbose)
  43.        print(pre _k1(i,t,lo),"lo",lo,"hi",hi,"d",hi-lo,"cut",cut)
  44.      DivCuts(i, t,    lo, cut, xl, yl,"|  "pre)
  45.      DivCuts(i, t, cut+1,  hi, xr, yr,"|  "pre)
  46.    } 
  47.    else {
  48.      push(i.stats, ys.sd*ys.n) 
  49.      for(r=lo; r<=hi; r++)
  50.        t.rows[ i.sort[r] ].cooked[i.k1] = xs.lo
  51.    }
  52.  }
```

`DivArgMin` finds the `cut` that splits of `lo`..`hi` such that
it most reduces the expected value of the standard deviation, after
the split. 

- Reject any split that is too small (fewer than `i.step`
items);
- Reject any split which has too little difference (less than `i.tiny`)
between the lower/upper bound of the split. 
- If nothing satisfies
those constraints, then return nothing.

```awk
  53.  function DivArgMin(i,t,lo,hi,xr,yr,xl1,xr1,yl1,yr1,
  54.                     j,cut,start,stop,yl,xl,n,best,x,y,tmp) {
  55.    start= _k1(i,t,lo)
  56.    stop = _k1(i,t,hi)
  57.    if (stop - start < i.tiny) return
  58.    Num(yl); Num(xl)
  59.    n    = hi - lo + 1
  60.    best = yr.sd
  61.    for(j=lo; j<=hi; j++) {
  62.      print 3
  63.      x  = _k1(i,t,j)
  64.      y  = _k2(i,t,j)
  65.      print 4
  66.      if (x != "?") {Num1(xl, x); NumLess(xr,x)}
  67.      if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
  68.      if (xl.n >= i.step)
  69.        if (xr.n >= i.step)
  70.          if ((x - start) > i.tiny) 
  71.            if((stop - x) > i.tiny)  {
  72.              tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
  73.              if (tmp*THE.div.trivial < best) {
  74.                cut  = j
  75.                best = tmp
  76.                become(yl,yl1); become(yr,yr1)
  77.                become(xl,xl1); become(xr,xr1) }}}
  78.    return cut
  79.  }
```

```awk
  80.  BEGIN { rogues() }
```
