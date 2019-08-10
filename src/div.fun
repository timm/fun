#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

## Chop numbers into useful ranges.

@include "funny"
@include "col"
@include "the"
@include "Num"

function Sdiv(i,xy0,
              xs,ys,j,x,y) {
  has(i,"cuts")
  has(i,"xy")
  ksort(xy0,"x")
  sdivEnough(xy0,i.xy)
  Num(xs)
  Num(ys)
  for(j in i.xy) {
    x = i.xy[j].x
    y = i.xy[j].y
    if (x != "?") Num1(xs, x)
    if (y != "?") Num1(ys, y) }
  i.tiny = xs.sd * THE.div.cohen
  i.step = length(i.xy)  ^ THE.div.min
  print(i.tiny,i.step)
  SdivCuts(i,1,length(i.xy), xs,ys)
}
function sdivEnough(a,b,     m,n,i,j) {
  n = length(a)
  m = THE.div.enough/(n+1)
  for(i=1; i<=n; i++) 
    if (rand() <=  m) {
      j++
      b[j].x = a[i].x
      b[j].y = a[i].y }
}
function SdivCuts(i, lo,hi,xs,ys,pre,
                 xl,yl,xr,yr,cut) {
  Num(xl); Num(yl)
  Num(xr); Num(yr)
  cut = SdivCut(i,lo,hi,xs,ys,xl,xr,yl,yr) 
  if (cut) {
    if (THE.div.verbose)
      print(pre i.xy[lo].x,"lo",lo,"hi",hi,"d",hi-lo,"cut",cut)
    SdivCuts(i,   lo, cut,xl,yl,"|  "pre)
    SdivCuts(i,cut+1,  hi,xr,yr,"|  "pre)
  } 
  else
    push(i.cuts,i.xy[lo].x)
}
function SdivCut(i,lo,hi,xr,yr,xl1,xr1,yl1,yr1,
               j,cut,start,stop,yl,xl,n,best,x,y,tmp) {
  start = i.xy[lo].x
  stop  = i.xy[hi].x
  if (stop - start < i.tiny) return
  Num(yl); Num(xl)
  n    = hi - lo + 1
  best = yr.sd
  for(j=lo; j<=hi; j++) {
    x = i.xy[j].x
    y = i.xy[j].y
    if (x != "?") {Num1(xl, x); NumLess(xr,x)}
    if (y != "?") {Num1(yl, y); NumLess(yr,y)} 
    if (xl.n >= i.step)
      if (xr.n >= i.step)
        if ((x - start) > i.tiny) 
          if((stop - x) > i.tiny)  {
            tmp = yl.n/n*yl.sd + yr.n/n*yr.sd
            if (tmp*THE.div.trivial < best) {
              cut  = j
              best = tmp
              become(yl,yl1); become(yr,yr1)
              become(xl,xl1); become(xr,xr1) }}}
  return cut
}
