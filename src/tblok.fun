#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "tbl"
@include "num"

#BEGIN { tests("tblok","_weather,_auto") }
BEGIN { tests("tblok","_weather") }
#BEGIN { tests("tblok","_weathernum") }
#BEGIN { tests("tblok","_dist1") }
#BEGIN { tests("tblok","_dist2") }
#BEGIN { tests("tblok","_distances") }

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
function _dist1(f) { return _dist0(f, "auto") }
function _dist2(f) { return _dist0(f, "labor") }

function _dist0(f,d,   t,r1,r2) {
  Tbl(t)
  lines(t,"Tbl1",DOT DOT "/data/" d DOT "csv")
  for(r1 in t.rows)  {
    print("\n" r1, flat(t.rows[r1].cells))
    for(r2 in t.rows) {
      if(r2+0 > r1+0) 
        print(r2, flat(t.rows[r2].cells), RowDist(t.rows[r1],t.rows[r2],t))
}}}


function _distances(f,  d,sum,n,i,r) {
  for(d=2;d<=100;d+=5) { 
     sum=0
     Num(n)
     r=100
     for(i=1;i<=r;i++)
        Num1(n,_distances1(d) )
     print d,n.mu,n.sd,n.lo,n.hi}
}
function _distances1(d,   a,b) {
  while(d--) {
    a[d]=rand()
    b[d]=rand()
  }
  return _distance(a,b) 
}
      
function _distance(a,b,  i,d) {
   for(i in a) 
     d += (a[i]-b[i])^2
  return (d/length(a))^0.5
}
