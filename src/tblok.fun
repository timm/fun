#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "tbl"

#BEGIN { tests("tblok","_weather,_auto") }
#BEGIN { tests("tblok","_weathernum") }
BEGIN { tests("tblok","_dist") }

function _weather(f) { return _tbl0(f,"weather") }
function _weathernum(f) { return _tbl0(f,"weathernum") }

function _tbl0(f,d,  t,com) { 
  Tbl(t)
  lines(t,"Tbl1",DOT DOT "/data/" d DOT "csv")
  oo(t,"t")
  is(f, length(t.rows), 14)
}
function _auto(f,  t,r,n,m) { 
  srand(1)
  Tbl(t)
  lines(t, "Tbl1", "auto" DOT "csv")
  for(r in t.rows) 
    RowDoms(t.rows[r], t.rows, t)
  ksort(t.rows,"dom")
  n = length(t.rows)
  m=5
  for(r=1;r<=m;r++)
    print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
  print ""
  for(r=n-m;r<=n;r++)
    print(t.rows[r].oid "\t" t.rows[r].dom "\t" flat(t.rows[r].cells, t.my.goals)) 
}
function _dist(f) { return _dist0(f, "auto") }

function _dist0(f,d,   t,r1,r2) {
  Tbl(t)
  lines(t,"Tbl1",DOT DOT "/data/" d DOT "csv")
  for(r1 in t.rows)  {
    if (r1==390) {
    print("\n" r1, flat(t.rows[r1].cells))
    for(r2 in t.rows) {
      if (r2==391) {
      if(r2+0 > r1+0) 
        print(r2, flat(t.rows[r2].cells), RowDist(t.rows[r1],t.rows[r2],t))
}}}}}
