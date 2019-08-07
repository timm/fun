#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "div"

BEGIN { tests("divok", "_div") }

function _div1(x,max) {
  if (x<=max*1/3) return 0
  if (x<=max*2/3) return rand()
  return 2*rand()
}
function _div(  lst,a,i,cuts,max) {
   srand(1)
   List(a)
   max=30000
   for(i=1;i<=max;i++) 
     pash2(a,"Xy",i*(1+rand()), _div1(i,max))
   sdiv(a,cuts)
   oo(cuts)
}
