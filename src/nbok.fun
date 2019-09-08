#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "nb"
@include "abcd"

BEGIN { tests("nbok","_nb") }

function _nb(f) {
  return _nb1("weathernon")
}
function _nb1(d,     z) {
  Abcds(z,"Nb",4)
  lines(z,"Abcds1",DOT DOT "/data/" d DOT "csv")
  AbcdReport(z.abcd)
} 
