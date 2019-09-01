#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "some"
@include "num"

BEGIN {  tests("someof","_some,_someks") }

`s` are `Some` of some random numbers. `n0` is
the distribution seen from those numbers. It should have
(nearly) the same mean and standard deviations
as `n1`, a
the distribution drawn from `SomeAny(s)`. 

func _some(f,     n0,n1,s,a,max,x,i) {
  max = 3000
  srand(1)
  Num(n0)
  Num(n1)
  Some(s)
  List(a)
  for(i=1;i<=max;i+= 1) {
    x = push(a, rand()) 
    Num1(n0,x)
    Some1(s,x)
  }
  for(i=1;i<=max;i+= 1) 
    Num1(n1, SomeAny(s))
  is(f,n0.sd, n1.sd, 0.01)
  is(f,n0.mu, n1.mu, 0.01)
}
function _someks(f,  g) {
   srand(1)
  for(g=1; g<=1.5;g += 0.05)  
    is(f g,_someks1(g),g>= 1.15) 
}

function _someks1(g,  s1,s2,n,x) {
  Some(s1)
  Some(s2)
  n=10000
  while(n--) {
    x=rand()
    Some1(s1,x)
    Some1(s2,x*g)
  } 
  return SomeKS(s1,s2)
}
