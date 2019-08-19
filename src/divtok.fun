#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------


@include "funny"
@include "divt"
@include "tbl"

BEGIN { tests("divtok", "_divt") }

function  _divt(f,  i,t,r) {
  Tbl(t)
  lines(t,"Tbl1",DOT DOT "/data/auto" DOT "csv")
  for(r in t.rows) 
    RowDoms(t.rows[r], t.rows, t)
  is(f, length(t.rows), 14)
  Divt(i,t,2,"dom")
  oo(t.my.nums)
}
