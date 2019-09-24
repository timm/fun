#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "nb"
@include "abcd"

BEGIN { tests("nbok","_nb1,_nb2") }

function _nb1(f) { return _nb0("weathernon") }
function _nb2(f) { return _nb0("diabetes",20) }
function _nb0(d,n,    z) {
  print("")
  print(d)
  n = n=="" ? 4 : n
  Abcds(z,"Nb",n)
  lines(z,"Abcds1",DOT DOT "/data/" d DOT "csv")
  AbcdReport(z.abcd)
} 
