#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "div"

BEGIN { tests("divok", "_div") }

function _div1(x) {
  if (x<=10) return 0
  if (x<=20) return 1
  return 2
}
function _div(  lst,a,i,cuts) {
   List(a)
   for(i=1;i<=30;i++) 
     pash2(a,"Xy",i, _div1(i))
   sdiv(a,cuts)
   oo(cuts)
}
