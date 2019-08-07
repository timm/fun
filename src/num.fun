#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"
@include "col"


The `Num` class incrementally  maintains the mean and standard
deviation of the numbers seen in a column.

function Num(i,c,v) {
  Col(i,c,v)
  i.n  = i.mu = i.m2 = i.sd = 0
  i.lo = 10^32 
  i.hi = -1*i.lo
  i.add ="Num1" 
}
function Num1(i,v,    d) {
  v += 0
  i.n++
  i.lo  = v < i.lo ? v : i.lo
  i.hi  = v > i.hi ? v : i.hi
  d     = v - i.mu
  i.mu += d/i.n
  i.m2 += d*(v - i.mu)
  i.sd  = NumSd0(i)
  return v
}

function NumSd0(i) {
  if (i.m2<0) return 0
  if (i.n < 2)  return 0
  return  (i.m2/(i.n - 1))^0.5
}

Also maintained is the lowest and highest number seen so far. With
that information we can normalize numbers zero to one.

function NumNorm(i,x) {
  return (x - i.lo) / (i.hi - i.lo + 10^-32)
}

If done carefully, it is also possible to incrementally decrement
these numbers.  Be wary of using the following when `i.n` is less
than, say, 5 to 10 and the total sum of the remaining numbers is small.

function NumLess(i,v, d) {
  if (i.n < 2) {i.sd=0; return v}
  i.n  -= 1
  d     = v - i.mu
  i.mu -= d/i.n
  i.m2 -= d*(v - i.mu)
  i.sd  = NumSd0(i)
  return v
}

To sample from `Num`, we assume that its numbers are like a 
a normal bell-shaped curve. If so,  then
the [Marsaglia function](https://people.maths.ox.ac.uk/gilesm/mc/mc/lec1.pdf)
can do the sampling:

function NumAny(i) { return i.m + i.sd * marsaglia() }

function marsaglia(     w,x1,x2) { 
   while (w == 0 || w >= 1) {
     x1= 2.0 * rand() - 1;
     x2= 2.0 * rand() - 1;
     w = x1*x1 + x2*x2 
   }
   w = sqrt((-2.0 * log(w))/w);
   return x1 * w;
}
