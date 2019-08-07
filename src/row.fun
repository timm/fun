#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- ---------

#!yuml [Tbl]1-1..+[Row]

function Row(i,t,lst,     c) {
  Object(i)
  has(i,"cells")
  has(i,"cooked")
  i.dom = 0
  for(c in t.cols) 
    i.cells[c] = Col1(t.cols[c],  lst[c]) 
}
function RowDoms(i,all,t,  j) {
  i.dom = 0
  for(j=1; j<=THE.row.doms; j++)
    i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
}
function RowDom(i,j,t,   a,b,c,s1,s2,n) {
  n = length(t.my.w)
  for(c in t.my.w) {
    a   = NumNorm( t.cols[c], i.cells[c] )
    b   = NumNorm( t.cols[c], j.cells[c] )
    s1 -= 10^( t.my.w[c] * (a-b)/n )
    s2 -= 10^( t.my.w[c] * (b-a)/n )
  }
  return s1/n < s2/n
}

 
