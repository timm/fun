#!/usr/bin/env ./fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------


@include "funny"
@include "col"
@include "the"

function sdiv(xy,    x0,y0,u,cuts)  {
   ksort(xy,"x")
   Num(x0)
   Num(y0)
   for(i in xy) {
     Col1(x0,xy[i].x)
     Col1(y0,xy[i].y) }
   List(cuts)
   scut(xy, 1,length(xy),
        x0.n*THE.div.min,
        x0.sd*THE.div.cohen,
        x0,y0,cuts) 
}
function scut1(xy,lo,hi,step,tiny,xr,yr,xl1,xr1,yl1,yr1,
              start,stop,yl,yr, n,cut,best,i,tmp) {
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
          if((stop -x) > tiny)  {
            tmp = yl.n/n*ly.sd + yr.n/n*yr.sd
            if (tmp*THE.div.trivial < best) {
              cut  = i
              best = tmp
              become(yl1,yl) become(yr1,yr)
              become(xl1,xl) become(xr1,xr) }}}
  return cut
}
