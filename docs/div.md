---
title: div.fun
---

 [about](/fun/ABOUT) |   [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE)<br>

----

# div.fun

Discretization is the process o

Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>
Uses:  "[the](the)"<br>
Uses:  "[Num](Num)"<br>

```awk
   1.  function Sdiv(i,xy0,
   2.                xs,ys,j,x,y) {
   3.    has(i,"cuts")
   4.    has(i,"xy")
   5.    ksort(xy0,"x")
   6.    sdivEnough(xy0,i.xy)
   7.    Num(xs)
   8.    Num(ys)
   9.    for(j in i.xy) {
  10.      x = i.xy[j].x
  11.      y = i.xy[j].y
  12.      if (x != "?") Num1(xs, x)
  13.      if (y != "?") Num1(ys, y) }
  14.    i.tiny = xs.sd * THE.div.cohen
  15.    i.step = length(i.xy)  ^ THE.div.min
  16.    print(i.tiny,i.step)
  17.    SdivCuts(i,1,length(i.xy), xs,ys)
  18.  }
  19.  function sdivEnough(a,b,     m,n,i,j) {
  20.    n = length(a)
  21.    m = THE.div.enough/(n+1)
  22.    for(i=1; i<=n; i++) 
  23.      if (rand() <=  m) {
  24.        j++
  25.        b[j].x = a[i].x
  26.        b[j].y = a[i].y }
  27.  }
  28.  function SdivCuts(i, lo,hi,xs,ys,pre,
  29.                   xl,yl,xr,yr,cut) {
  30.    Num(xl); Num(yl)
  31.    Num(xr); Num(yr)
  32.    cut = SdivCut(i,lo,hi,xs,ys,xl,xr,yl,yr) 
  33.    if (cut) {
  34.      if (THE.div.verbose)
  35.        print(pre i.xy[lo].x,"lo",lo,"hi",hi,"d",hi-lo,"cut",cut)
  36.      SdivCuts(i,   lo, cut,xl,yl,"|  "pre)
  37.      SdivCuts(i,cut+1,  hi,xr,yr,"|  "pre)
  38.    } 
  39.    else
  40.      push(i.cuts,i.xy[lo].x)
  41.  }
  42.  function SdivCut(i,lo,hi,xr,yr,xl1,xr1,yl1,yr1,
  43.                 j,cut,start,stop,yl,xl,n,best,x,y,tmp) {
  44.    start = i.xy[lo].x
  45.    stop  = i.xy[hi].x
  46.    if (stop - start < i.tiny) return
  47.    Num(yl); Num(xl)
  48.    n    = hi - lo + 1
  49.    best = yr.sd
  50.    for(j=lo; j<=hi; j++) {
  51.      x = i.xy[j].x
  52.      y = i.xy[j].y
  53.      if (x != "?") {Num1(xl, x); NumLess(xr,x)}
  54.      if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
  55.      if (xl.n >= i.step)
  56.        if (xr.n >= i.step)
  57.          if ((x - start) > i.tiny) 
  58.            if((stop - x) > i.tiny)  {
  59.              tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
  60.              if (tmp*THE.div.trivial < best) {
  61.                cut  = j
  62.                best = tmp
  63.                become(yl,yl1); become(yr,yr1)
  64.                become(xl,xl1); become(xr,xr1) }}}
  65.    return cut
  66.  }
```
