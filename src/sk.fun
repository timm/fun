#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"
@include "nums"

#/class [Array1]-.-[note: sk(){bg:cornsilk}]]-.-[Array2]

function testStatistic(i,j) { 
   return (j.mu - i.mu) / (i.sd/i.n + j.sd/j.n)^0.5 }

function sample(a,b,w) { for(w in a) b[w] = a[any(a)] }

function bootstrap(y0,z0,   
                  x,y,z,tobs,w,b,yhat,zhat,y1,z1,ynum,znum,big) {
  nums(x,y0)
  nums(x,z0)
  nums(y,y0)
  nums(z,z0)
  tobs = testStatistic(y,z)
  for(w in y0) yhat[w]= y0[w]- y.mu + x.mu 
  for(w in z0) zhat[w]= z0[w]- z.mu + x.mu 
  b = THE.sk.b
  for(w=1; w<=b; w++) {
    sample(yhat, y1) 
    nums(ynum,   y1)
    sample(zhat, z1) 
    nums(znum,   z1)
    big +=  testStatistic(ynum,znum) > tobs
  }
  print big,b,THE.sk.conf
  return big / b < THE.sk.conf
}

function cliffsDelta(a1,a2,
                     a3, m,n,j,x,lo,hi,lt,gt,k) {
  n= asort(a2, a3)
  for(k in a1) {
    x= a1[k]
    lo= hi= bsearch(a3,x,1)
    while(lo >= 1 && a3[lo] >= x) lo--
    while(hi <= n && a3[hi] <= x) hi++
    lt += n - hi + 1
    gt += lo 
  }
  m = length(a1)*length(a2)
  return abs(gt - lt) / m > THE.sk.cliffs
}

BEGIN{rogues()}
