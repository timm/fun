#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"

BEGIN { tests("funny", "_isnt,_any") }

function _isnt(f) {
  print "this one should fail"
  is(f, 0,1)
}

function _any(f,   a,b,i) {
  split("a,b,c,d,e,f",a,",")
  for(i=1;i<=50;i++) b[i]=any(a)
  asort(b)
  is(f, b[1],1)
}
