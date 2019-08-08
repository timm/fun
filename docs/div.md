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
```

```awk
   4.  function sdivEnough(a,b,     m,n,i,j) {
   5.    n = length(a)
   6.    m = THE.div.enough/(n+1)
   7.    for(i=1; i<=n; i++) 
   8.      if (rand() <=  m) {
   9.        j++
  10.        b[j].x = a[i].x
  11.        b[j].y = a[i].y }
  12.  }
  13.  function sdiv(xy0,cuts,   xy,xs,ys,i,step,tiny,x,y)  {
  14.     ksort(xy0,"x")
  15.     sdivEnough(xy0,xy)
  16.     Num(xs)
  17.     Num(ys)
  18.     for(i in xy) {
  19.       x = xy[i].x
  20.       y = xy[i].y
  21.       if (x != "?") Num1(xs, x)
  22.       if (y != "?") Num1(ys, y) }
  23.     List(cuts)
  24.     tiny = xs.sd * THE.div.cohen
  25.     step = length(xy)  ^ THE.div.min
  26.     sdiv1(xy, 1,length(xy), step,tiny, xs,ys,cuts) 
  27.  }
```

```awk
  28.  function sdiv1(xy,lo,hi,step,tiny,xs,ys,cuts,pre,
  29.                 xl,yl,xr,yr,cut) {
  30.    Num(xl); Num(yl)
  31.    Num(xr); Num(yr)
  32.    cut = sdivCut(xy,lo,hi,step,tiny,xs,ys,xl,xr,yl,yr) 
  33.    if (cut) {
  34.      print(pre xy[lo].x,"lo",lo,"hi",hi,"d",hi-lo,"cit",cut)
  35.      sdiv1(xy,lo,   cut,step,tiny,xl,yl,cuts,"|  "pre)
  36.      sdiv1(xy,cut+1, hi,step,tiny,xr,yr,cuts,"|  "pre)
  37.    } 
  38.    else
  39.      push(cuts,xy[lo].x)
  40.  }
  41.  function sdivCut(xy,lo,hi,step,tiny,xr,yr,xl1,xr1,yl1,yr1,
  42.                 cut,start,stop,yl,xl,n,best,i,x,y,tmp) {
  43.    start = xy[lo].x
  44.    stop  = xy[hi].x
  45.    if (stop - start < tiny) return
  46.    Num(yl); Num(xl)
  47.    n    = hi - lo + 1
  48.    best = yr.sd
  49.    for(i=lo; i<=hi; i++) {
  50.      x = xy[i].x
  51.      y = xy[i].y
  52.      if (x != "?") {Num1(xl, x); NumLess(xr,x)}
  53.      if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
  54.      if (xl.n >= step)
  55.        if (xr.n >= step)
  56.          if ((x - start) > tiny) 
  57.            if((stop - x) > tiny)  {
  58.              tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
  59.              if (tmp*THE.div.trivial < best) {
  60.                cut  = i
  61.                best = tmp
  62.                become(yl,yl1); become(yr,yr1)
  63.                become(xl,xl1); become(xr,xr1) }}}
  64.    return cut
  65.  }
```
