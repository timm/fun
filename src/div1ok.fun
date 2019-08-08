#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
--------- --------- --------- --------- --------- ---------

@include "div1"

BEGIN { tests("divok", "_div") }

function _div1(x,max) {
  if (x<=max*1/3) return 0
  if (x<=max*2/3) return rand()
  return 2*rand()
}
function _div(f,    s, lst,a,i,cuts,max) {
   srand(1)
   List(a)
   max=i=10^4
   for(i=1;i<=max;i++) {
     a[i].x = i
     a[i].y = _div1(i,max) }
   Sdiv(s,a)
   oo(s.cuts)
}
