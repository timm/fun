#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

## Chop numbers into useful ranges.

@include "funny"
@include "col"
@include "the"
@include "num"

function _k1(i,t,r) {return rcol(t.rows[ i.sort[r] ], i.k1)}
function _k2(i,t,r) {return rcol(t.rows[ i.sort[r] ], i.k2)}

function Divt(i,t,k1,k2,
              xs,ys,r,x,y) {
  i.k1 = k1 ? k1 : t.my.class
  i.k2 = k2 ? k2 : k1
  has(i,"stats") 
  has(i,"sort")
  has(i,"keys")
  DivSort(i,t)
  Num(xs)
  Num(ys)
  for(r in i.sort) {
    x = _k1(i, t, r)
    y = _k2(i, t, r)
    if (x != "?") Num1(xs, x)
    if (y != "?") Num1(ys, y) 
  }
  i.tiny = xs.sd * THE.div.cohen
  i.step = length(i.sort) ^ THE.div.min
  print(i.tiny,i.step)
  DivCuts(i,t, 1,length(i.sort), xs,ys)
}

Sort the table rows, then place a sample of those
sorted row indexes into `i.sort` (this trick means that
that we can effeciently divide very long columns).

function DivSort(i,t,     m,n,j,k) {
  rsort(t.rows,  i.k1)
  n = length(t.rows)
  m = THE.div.enough/(n+0.00001)
  for(j=1; j<=n; j++) 
    if (rand() <= m) 
      i.sort[++k] = j
}

If we can find a cut between `lo` and `hi`, then recurse on each
side of the cut.  Else, `cook` the column contents (i.e. assign on
value to that column from `lo` to `hi`).

function DivCuts(i,t,lo,hi,xs,ys,pre,
                 xl,yl,xr,yr,cut,r) {
  Num(xl); Num(yl)
  Num(xr); Num(yr)
  cut = DivArgMin(i,t,lo,hi,xs,ys,xl,xr,yl,yr) 
  if (cut) {
    if (THE.div.verbose)
      print(pre _k1(i,t,lo),"lo",lo,"hi",hi,"d",hi-lo,"cut",cut)
    DivCuts(i, t,    lo, cut, xl, yl,"|  "pre)
    DivCuts(i, t, cut+1,  hi, xr, yr,"|  "pre)
  } 
  else {
    push(i.stats, ys.sd*ys.n) 
    for(r=lo; r<=hi; r++)
      t.rows[ i.sort[r] ].cooked[i.k1] = xs.lo
  }
}

`DivArgMin` finds the `cut` that splits of `lo`..`hi` such that
it most reduces the expected value of the standard deviation, after
the split. 

- Reject any split that is too small (fewer than `i.step`
items);
- Reject any split which has too little difference (less than `i.tiny`)
between the lower/upper bound of the split. 
- If nothing satisfies
those constraints, then return nothing.

function DivArgMin(i,t,lo,hi,xr,yr,xl1,xr1,yl1,yr1,
                   j,cut,start,stop,yl,xl,n,best,x,y,tmp) {
  start= _k1(i,t,lo)
  stop = _k1(i,t,hi)
  if (stop - start < i.tiny) return
  Num(yl); Num(xl)
  n    = hi - lo + 1
  best = yr.sd
  for(j=lo; j<=hi; j++) {
    x  = _k1(i,t,j)
    y  = _k2(i,t,j)
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

BEGIN {rogues() }
