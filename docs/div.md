---
title: div.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# div.fun

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
   7.    has(i,"cuts")
   8.    has(i,"xy")
   9.    ksort(xy0,"x")
  10.    sdivEnough(xy0,i.xy)
  11.    Num(xs)
  12.    Num(ys)
  13.    for(j in i.xy) {
  14.      x = i.xy[j].x
  15.      y = i.xy[j].y
  16.      if (x != "?") Num1(xs, x)
  17.      if (y != "?") Num1(ys, y) }
  18.    i.tiny = xs.sd * THE.div.cohen
  19.    i.step = length(i.xy)  ^ THE.div.min
  20.    print(i.tiny,i.step)
  21.    SdivCuts(i,1,length(i.xy), xs,ys)
  22.  }
  23.  function sdivEnough(a,b,     m,n,i,j) {
  24.    n = length(a)
  25.    m = THE.div.enough/(n+1)
  26.    for(i=1; i<=n; i++) 
  27.      if (rand() <=  m) {
  28.        j++
  29.        b[j].x = a[i].x
  30.        b[j].y = a[i].y }
  31.  }
  32.  function SdivCuts(i, lo,hi,xs,ys,pre,
  33.                   xl,yl,xr,yr,cut) {
  34.    Num(xl); Num(yl)
  35.    Num(xr); Num(yr)
  36.    cut = SdivCut(i,lo,hi,xs,ys,xl,xr,yl,yr) 
  37.    if (cut) {
  38.      if (THE.div.verbose)
  39.        print(pre i.xy[lo].x,"lo",lo,"hi",hi,"d",hi-lo,"cut",cut)
  40.      SdivCuts(i,   lo, cut,xl,yl,"|  "pre)
  41.      SdivCuts(i,cut+1,  hi,xr,yr,"|  "pre)
  42.    } 
  43.    else
  44.      push(i.cuts,i.xy[lo].x)
  45.  }
  46.  function SdivCut(i,lo,hi,xr,yr,xl1,xr1,yl1,yr1,
  47.                 j,cut,start,stop,yl,xl,n,best,x,y,tmp) {
  48.    start = i.xy[lo].x
  49.    stop  = i.xy[hi].x
  50.    if (stop - start < i.tiny) return
  51.    Num(yl); Num(xl)
  52.    n    = hi - lo + 1
  53.    best = yr.sd
  54.    for(j=lo; j<=hi; j++) {
  55.      x = i.xy[j].x
  56.      y = i.xy[j].y
  57.      if (x != "?") {Num1(xl, x); NumLess(xr,x)}
  58.      if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
  59.      if (xl.n >= i.step)
  60.        if (xr.n >= i.step)
  61.          if ((x - start) > i.tiny) 
  62.            if((stop - x) > i.tiny)  {
  63.              tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
  64.              if (tmp*THE.div.trivial < best) {
  65.                cut  = j
  66.                best = tmp
  67.                become(yl,yl1); become(yr,yr1)
  68.                become(xl,xl1); become(xr,xr1) }}}
  69.    return cut
  70.  }
```
