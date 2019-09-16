#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

## Summarize numeric columns.

@include "funny"
@include "col"
@include "nums"

#!class [Col|n = 0]^-[Num|mu = 0; m2 = 0; lo; hi| Num1(); NumNorm();NumLess();NumAny()]

`Num` incrementally  maintains the mean and standard deviation of
the numbers seen in a column.

function Num(i,c,v) {
  Col(i,c,v)
  i.n  = i.mu = i.m2 = i.sd = 0
  i.lo = 10^32 
  i.hi = -1*i.lo
  i.add ="Num1" 
}

The slow way to compute standard deviation is to run over the data
in two passes. In pass1, we find the mean, then in pass2 you look
for the difference of everything else to the mean; i.e.
_sqrt(&sum;(x-&mu;)^2/(n-1))_.  The following code does the same
thing, in one pass using 
[Welford's on-line algorithm](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm):

function Num1(i,v,    d) {
  v += 0
  i.n++
  i.lo  = v < i.lo ? v : i.lo
  i.hi  = v > i.hi ? v : i.hi
  d     = v - i.mu
  i.mu += d/i.n
  i.m2 += d*(v - i.mu)
  i.sd  = _NumSd(i)
  return v
}

function _NumSd(i) {
  if (i.m2 < 0) return 0
  if (i.n < 2)  return 0
  return  (i.m2/(i.n - 1))^0.5
}

`Num` also maintains is the lowest and highest number seen so far. With
that information we can normalize numbers zero to one.

function NumNorm(i,x) {
  return (x - i.lo) / (i.hi - i.lo + 10^-32)
}

If done carefully, it is also possible to incrementally decrement
these numbers.  Be wary of using the following when `i.n` is less
than, say, 5 to 10 and the total sum of the remaining numbers is
small.

function NumLess(i,v, d) {
  if (i.n < 2) {i.sd=0; return v}
  i.n  -= 1
  d     = v - i.mu
  i.mu -= d/i.n
  i.m2 -= d*(v - i.mu)
  i.sd  = _NumSd(i)
  return v
}

function NumVariety(i) { return i.sd }

function NumXpect(i,j, n) {
  n = i.n + j.n
  return i.sd * i.n/n + j.sd * j.n/n 
}


To sample from `Num`, we assume that its numbers are like a a normal
bell-shaped curve. If so,  then the [Box Muller
](https://people.maths.ox.ac.uk/gilesm/mc/mc/lec1.pdf) can do the
sampling:

function NumAny(i) { 
  return i.m + i.sd * z()
}

function z() {
  return sqrt(-2*log(rand()))*cos(6.2831853*rand())

}
function NumAnyT(i) { # Another any, assumes a triangle distribution
  return triangle(i.lo, i.mu, i.hi)
}

Here, we check if two `Num`s are significantly different
and differ by mroe than a small effect:

function NumDiff(i,j) {
  return diff(i,j) # defined in "Nums"
}

Here's a convenience function to load all the numbers of an array 
`a` into a `Num`. 

function nums(n,a,   x,    v,i) {
  if (!isarray(n)) # if n is not already a Num..
    Num(n)         # ... then make it a num
  for(i in a)  {
    v= x ? a[i][x] : a[i]
    if (v != "?") Num1(n, v) }
}

## Like

`Num`s can also report how much they "like" some number `x`, by assuming it is drawn from some
normal bell-shapped curve (all we need do is report the height of that curve at `x`).

function NumLike(i,x,      var,denom,num) {
  var   = i.sd^2
  denom = (3.14159*2*var)^.5
  num   =  2.71828^(-(x-i.mu)^2/(2*var+0.0001))
  return num/(denom + 10^-64)
}

