#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

## Chop numbers into useful ranges.

@include "funny"
@include "col"
@include "the"
@include "num"

function TreeSym(i,t,key,kex,klass,      add,var,a,j,x,y,tmp) {
  i.key = key   ? key   : t.my.class
  i.kex = kex   ? kex   : key
  klass = klass ? klass : "Num"
  add   = klass "1"
  var   = klass "Variety"
  List(a)
  for(j in t.rows) {
    x = rcol( t.rows[j], i.kex )
    y = rcol( t.rows[j], i.key )
    if ( (x != "?") && (y != "?")) {
      if(! (x in a))
         has(a,x,klass)
      @add(a[x],y) 
    }
  }
  i.best = 10^32
  for(x in a)  {
    tmp = @var(a[x])
    if (tmp < i.best) {
      i.cut=x
      i.best=tmp }}
  print ">",i.kex,i.key,"!",i.cut
}

`kex`
is a numeric column that we want to split such that
another column `key` is minimized. `key` can be 
numeric or symbolic, in which case we are minimizing
standard deviation or entropy (respectively). 

function TreeNum(i,t,key,kex,klass,          xs,ys) {
  i.key = key ? key : t.my.class
  i.kex = kex ? kex : key
  klass = klass?klass : "Num"
  has(i,"sort")
  Num(xs, i.kex)
  @klass(ys, i.key)
  TreeSort(i,t,xs,ys,klass)
  i.tiny = xs.sd * THE.div.cohen
  i.step = length(i.sort) ^ THE.div.min
  TreeArgMin(i,t, length(i.sort), xs, ys,klass)
  print ">",i.kex,i.key,"!",i.cut
}

function TreeSort(i,t,xs,ys,klass,     m,n,j,x,y,k) {
  n = length(t.rows)
  m = THE.div.enough/(n+0.00001)
  klass = klass "1"
  for(j=1; j<=n; j++) 
    if (rand() <= m)  {
      x = rcol( t.rows[j], i.kex )
      y = rcol( t.rows[j], i.key )
      if ( (x != "?") && (y != "?")) {
        Num1(xs, x) 
        @klass(ys, y)
        i.sort[ ++k ].row = j
        i.sort[   k ].x   = x+0 
        i.sort[   k ].y   = y+0 }} 
  return ksort(i.sort,"x")
}

function TreeArgMin(i,t,hi,xr,yr,klass,
                   j,start,stop,yl,xl,best,x,y,tmp,
                   add, del, var) {
  add  = klass "1"
  del  = klass "Less"
  var  = klass "Xpect"
  start= i.sort[1].x
  stop = i.sort[hi].x
  if (stop - start < i.tiny) return
  @klass(yl)
  Num(xl)
  i.best = @var(yl, yr)
  for(j=1; j<=hi; j++) {
    x = i.sort[j].x
    y = i.sort[j].y
    Num1(xl, x); NumLess(xr, x)
    @add(yl, y); @del(yr, y) 
    if (xl.n >= i.step)  
      if (xr.n >= i.step) 
        if ((x - start) > i.tiny)   
          if((stop - x) > i.tiny)  {
            tmp = @var(yl, yr) 
            if (tmp*THE.div.trivial < i.best) {
              i.cut  = x
              i.best = tmp }}}
}

BEGIN { rogues() }
