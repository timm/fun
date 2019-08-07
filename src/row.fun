#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- --

@include "col"
@include "the"
@include "funny"

#!class [Tbl]++->1..*[Row|cells;cooked;dom = 0]

`Tbl` (tables) have `Row`s.
As `Roach w` accepts `cells`, it passes each cell to a table column
(at which point, that column uupdates its stats about the values
in that column).

function Row(i,t,cells,     c) {
  Object(i)
  has(i,"cells")
  has(i,"cooked")
  i.dom = 0
  for(c in t.cols) 
    i.cells[c] = Col1(t.cols[c],  cells[c]) 
}

To assess the worth of a `Row`, we compare it to a random
number of other `Row`s.

function RowDoms(i,all,t,  j) {
  i.dom = 0
  for(j=1; j<=THE.row.doms; j++)
    i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
}

One `Row` dominates another if its goals are "better".
To compute this "better", we "shout"  the loss between
each goal (where "shout" means, raise it a power of 10).
If moving from here to there shouts less than there to here,
then here is better.


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

 
