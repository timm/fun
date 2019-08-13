#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------


@include "funny"
@include "divt"
@include "tbl"

BEGIN { tests("divtok", "_divt") }

function  _divt(f,  i,t) {
  Tbl(t)
print 1
  lines(t,"Tbl1",DOT DOT "/data/weather" DOT "csv")
print 2
  is(f, length(t.rows), 14)
  Divt(i,t,2,2)
}
