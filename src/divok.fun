#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
--------- --------- --------- --------- --------- ---------

@include "div"

BEGIN { tests("divok", "_div1") }

function _div1(f) {
   _div2(f,"_div1a")
   _div2(f,"_div2a")
   _div2(f,"_div3a")
}
function _div2(f,g,    s,lst,a,i,cuts,max) {
   srand(1)
   List(a)
   max=i=10^4
   for(i=1;i<=max;i++) {
     a[i].x = i
     a[i].y = @g(i,max) }
   Sdiv(s,a)
   oo(s.cuts,g)
   print("")
}

function _div1a(x,max) {
  if (x<=max*1/3) return 0
  if (x<=max*2/3) return 1
  return 2
}
function _div2a(x,max) {
  if (x<=max*1/3) return 0
  if (x<=max*2/3) return rand()
  return 2*rand()
}
function _div3a(x,max) { return 0 }

