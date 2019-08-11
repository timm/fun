#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "num"

BEGIN {  tests("colok","_num,_any") }

Walk up a list of random numbers, adding to a `Num`
counter. Then walk down, removing numbers. Check
that we get to the same mu and standard deviation
both ways.

function _num(f,     n,a,i,mu,sd) {
  srand()
  Num(n,"c","v")
  List(a)
  for(i=1;i<=100;i+= 1) 
    push(a,rand()^2) 
  for(i=1;i<=100;i+= 1) { 
    Num1(n,a[i])
    if((i%10)==0) { 
     sd[i]=n.sd
     mu[i]=n.mu }}
  for(i=100;i>=1; i-= 1) {
    if((i%10)==0) {
      is(f, n.mu, mu[i])
      is(f, n.sd, sd[i])  }
    NumLess(n,a[i]) }
}

Check that it we pull from some initial gaussian distribution,
we can sample it to find the same means and standard deviation.

function _any(f,     max,n,a,i,mu,sd,n0,n1,x) {
  srand(1)
  Num(n0)
  Num(n1)
  List(a)
  max=300
  for(i=1;i<=max;i+= 1) {
    x=sqrt(-2*log(rand()))*cos(6.2831853*rand())
    Num1(n0,x)
    push(a, x) 
  }
  for(i=1;i<=max;i+= 1) Num1(n1, NumAny(n0))
  is(f,n0.sd, n1.sd,0.05)
  is(f, (n0.mu-n1.mu)< 0.05,1 )
}
