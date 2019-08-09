#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
--------- --------- --------- --------- --------- ---------

@include "funny"
@include "sk"
@include "num"

BEGIN { tests("skok", "_sk,_cd1,_cd2,_cd3") }

function _sample(fun,   w,a,b,x,max) {
   print ""
   srand(1)
   for(w=1;w<1.5;w+=0.05) {
     List(a)
     List(b)
     max=500
     for(x=1;x<=max;x++) {
       a[x] = rand()
       b[x] = a[x]*w }
     print fun,w,@fun(a,b)
   }
}

function _sk(f) { _sample("bootstrap") }
function _cd1(f) { _sample("cdslow") }
function _cd2(f) { _sample("cliffsDelta") }
function _cd3(f) { _sample("distinct") }


function cdslow(a,b,   x,y,gt,lt,m) {
  for(x in a) 
   for(y in a) {
      gt += a[x] > b[y]
      lt += a[x] < b[y] }
 m = length(a)*length(b)
 return abs(gt - lt)/ m > 0.147
}
