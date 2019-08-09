#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
--------- --------- --------- --------- --------- ---------

@include "funny"
@include "sk"

BEGIN { tests("skok", "_sk") }

function _sk(f,   w,a,b,x,max) {
   srand(1)
   for(w=1;w<=1.5;w+=0.05) {
     List(a)
     List(b)
     max=10^2
     for(x=1;x<=max;x++) {
       a[x] = x
       b[x] = x*w }
     print w,bootstrap(a,b)
   }
}
