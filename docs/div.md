---
title: div.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# div.fun

Discretization is the process o

```awk
   1.  @include "funny"
   2.  @include "col"
   3.  @include "the"
   4.  @include "Num"
```

```awk
   5.  function sdivEnough(a,b,     m,n,i,j) {
   6.    n = length(a)
   7.    m = THE.div.enough/(n+1)
   8.    for(i=1; i<=n; i++) 
   9.      if (rand() <=  m) {
  10.        j++
  11.        b[j].x = a[i].x
  12.        b[j].y = a[i].y }
  13.  }
  14.  function sdiv(xy0,cuts,   xy,xs,ys,i,step,tiny,x,y)  {
  15.     ksort(xy0,"x")
  16.     sdivEnough(xy0,xy)
  17.     Num(xs)
  18.     Num(ys)
  19.     for(i in xy) {
  20.       x = xy[i].x
  21.       y = xy[i].y
  22.       if (x != "?") Num1(xs, x)
  23.       if (y != "?") Num1(ys, y) }
  24.     List(cuts)
  25.     tiny = xs.sd * THE.div.cohen
  26.     step = length(xy)  ^ THE.div.min
  27.     sdiv1(xy, 1,length(xy), step,tiny, xs,ys,cuts) 
  28.  }
```

```awk
  29.  function sdiv1(xy,lo,hi,step,tiny,xs,ys,cuts,pre,
  30.                 xl,yl,xr,yr,cut) {
  31.    Num(xl); Num(yl)
  32.    Num(xr); Num(yr)
  33.    cut = sdivCut(xy,lo,hi,step,tiny,xs,ys,xl,xr,yl,yr) 
  34.    if (cut) {
  35.      print(pre xy[lo].x,"lo",lo,"hi",hi,"d",hi-lo,"cit",cut)
  36.      sdiv1(xy,lo,   cut,step,tiny,xl,yl,cuts,"|  "pre)
  37.      sdiv1(xy,cut+1, hi,step,tiny,xr,yr,cuts,"|  "pre)
  38.    } 
  39.    else
  40.      push(cuts,xy[lo].x)
  41.  }
  42.  function sdivCut(xy,lo,hi,step,tiny,xr,yr,xl1,xr1,yl1,yr1,
  43.                 cut,start,stop,yl,xl,n,best,i,x,y,tmp) {
  44.    start = xy[lo].x
  45.    stop  = xy[hi].x
  46.    if (stop - start < tiny) return
  47.    Num(yl); Num(xl)
  48.    n    = hi - lo + 1
  49.    best = yr.sd
  50.    for(i=lo; i<=hi; i++) {
  51.      x = xy[i].x
  52.      y = xy[i].y
  53.      if (x != "?") {Num1(xl, x); NumLess(xr,x)}
  54.      if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
  55.      if (xl.n >= step)
  56.        if (xr.n >= step)
  57.          if ((x - start) > tiny) 
  58.            if((stop - x) > tiny)  {
  59.              tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
  60.              if (tmp*THE.div.trivial < best) {
  61.                cut  = i
  62.                best = tmp
  63.                become(yl,yl1); become(yr,yr1)
  64.                become(xl,xl1); become(xr,xr1) }}}
  65.    return cut
  66.  }
```
