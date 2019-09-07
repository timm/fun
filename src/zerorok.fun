#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "zeror"

BEGIN { tests("zerorok","_zeror") }

function _zeror(f) {
  return _zeror1("labor")
}
function _zeror1(d,     z) {
  Abcds(i,"ZeroR",1)
  lines(i,"Abcds1",DOT DOT "/data/" d DOT "csv")
  oo(i.abcd)
} 

