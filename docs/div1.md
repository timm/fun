---
title: div1.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# div1.fun

Discretization is the process o

```awk
   1.  @include "funny"
   2.  @include "col"
   3.  @include "the"
   4.  @include "Num"
```

```awk
   5.  function Sdiv(i,xy0,
   6.                xs,ys,j,x,y) {
   7.    print 1
   8.    has(i,"cuts")
   9.    has(i,"xy")
  10.    ksort(xy0,"x")
  11.    sdivEnough(xy0,i.xy)
  12.    Num(xs)
  13.    Num(ys)
  14.    for(j in i.xy) {
  15.      x = i.xy[j].x
  16.      y = i.xy[j].y
  17.      if (x != "?") Num1(xs, x)
  18.      if (y != "?") Num1(ys, y) }
  19.    i.tiny = xs.sd * THE.div.cohen
  20.    i.step = length(i.xy)  ^ THE.div.min
  21.    print(i.tiny,i.step)
  22.    SdivCuts(i,1,length(i.xy), xs,ys)
  23.  }
  24.  function sdivEnough(a,b,     m,n,i,j) {
  25.    n = length(a)
  26.    m = THE.div.enough/(n+1)
  27.    for(i=1; i<=n; i++) 
  28.      if (rand() <=  m) {
  29.        j++
  30.        b[j].x = a[i].x
  31.        b[j].y = a[i].y }
  32.  }
```

```awk
  33.  function SdivCuts(i, lo,hi,xs,ys,pre,
  34.                   xl,yl,xr,yr,cut) {
  35.    Num(xl); Num(yl)
  36.    Num(xr); Num(yr)
  37.    cut = SdivCut(i,lo,hi,xs,ys,xl,xr,yl,yr) 
  38.    if (cut) {
  39.      if (THE.div.verbose)
  40.        print(pre i.xy[lo].x,"lo",lo,"hi",hi,"d",hi-lo,"cut",cut)
  41.      SdivCuts(i,   lo, cut,xl,yl,"|  "pre)
  42.      SdivCuts(i,cut+1,  hi,xr,yr,"|  "pre)
  43.    } 
  44.    else
  45.      push(i.cuts,i.xy[lo].x)
  46.  }
  47.  function SdivCut(i,lo,hi,xr,yr,xl1,xr1,yl1,yr1,
  48.                 j,cut,start,stop,yl,xl,n,best,x,y,tmp) {
  49.    start = i.xy[lo].x
  50.    stop  = i.xy[hi].x
  51.    if (stop - start < i.tiny) return
  52.    Num(yl); Num(xl)
  53.    n    = hi - lo + 1
  54.    best = yr.sd
  55.    for(j=lo; j<=hi; j++) {
  56.      x = i.xy[j].x
  57.      y = i.xy[j].y
  58.      if (x != "?") {Num1(xl, x); NumLess(xr,x)}
  59.      if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
  60.      if (xl.n >= i.step)
  61.        if (xr.n >= i.step)
  62.          if ((x - start) > i.tiny) 
  63.            if((stop - x) > i.tiny)  {
  64.              tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
  65.              if (tmp*THE.div.trivial < best) {
  66.                cut  = j
  67.                best = tmp
  68.                become(yl,yl1); become(yr,yr1)
  69.                become(xl,xl1); become(xr,xr1) }}}
  70.    return cut
  71.  }
```
