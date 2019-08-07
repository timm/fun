#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "col"
@include "the"

function sdiv(xy,cuts,   xs,ys,i,step,tiny,x,y)  {
   ksort(xy,"x")
   Num(xs)
   Num(ys)
   for(i in xy) {
     x = xy[i].x
     y = xy[i].y
     if (x != "?") Num1(xs, x)
     if (y != "?") Num1(ys, y) }
   List(cuts)
   step = xs.n  ^ THE.div.min
   tiny = xs.sd * THE.div.cohen
   sdiv1(xy, 1,length(xy), step,tiny, xs,ys,cuts) 
}

function sdiv1(xy,lo,hi,step,tiny,xs,ys,cuts,pre,
               xl,yl,xr,yr,cut) {
  Num(xl); Num(yl)
  Num(xr); Num(yr)
  cut = sdivCut(xy,lo,hi,step,tiny,xs,ys,xl,xr,yl,yr) 
  print(pre xy[lo].x,"lo",lo,"hi",hi,"d",hi-lo,"cit",cut)
  if (cut) {
    oo(yl,"yl")
    sdiv1(xy,lo,   cut,step,tiny,xl,yl,cuts,"|  "pre)
    sdiv1(xy,cut+1, hi,step,tiny,xr,yr,cuts,"|  "pre)
  } else
    push(cuts,xy[lo].x)
}
function sdivCut(xy,lo,hi,step,tiny,xr,yr,xl1,xr1,yl1,yr1,
               cut,start,stop,yl,xl,n,best,i,x,y,tmp) {
  start = xy[lo].x
  stop  = xy[hi].x
  if (stop - start < tiny) return
  Num(yl); Num(xl)
  n    = hi - lo
  best = yr.sd
  for(i=lo; i<=hi-step; i++) {
    x = xy[i].x
    y = xy[i].y
    if (x != "?") {Num1(xl, x); NumLess(xr,x)}
    if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
    if (xl.n >= step)
      if (xr.n >= step)
        if ((x - start) > tiny) 
          if((stop - x) > tiny)  {
            tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
            if (tmp*THE.div.trivial < best) {
              cut  = i
              best = tmp
              become(yl,yl1); become(yr,yr1)
              become(xl,xl1); become(xr,xr1) }}}
  return cut
}