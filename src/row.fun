#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- --


## Store rows of tables.

#!class [Tbl]++-1..*[Row|cells;cooked;dom = 0],[Row]-uses-[Col||Col1()]

`Tbl` (tables) have `Row`s.

@include "funny"
@include "the"
@include "tbl"
@include "col"

As `Row`s accept `cells`, it passes each cell to a table column
(so that column can update what it knows about that column).

function Row(i,t,cells,     c) {
  Object(i)
  has(i,"cells")
  has(i,"cooked")
  i.dom = 0
  for(c in t.cols) 
    i.cells[c] = Col1(t.cols[c],  cells[c]) 
}

## Scoring Rows

To assess the worth of a `Row`, we compare it to a random number
of other `Row`s.

function RowDoms(i,all,t,  j) {
  i.dom = 0
  for(j=1; j<=THE.row.doms; j++)
    i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
}

`Row` "_i_" dominates row "_j_"  if "_i_"'s  goals are "better".
To compute this "better", we complain loudly about   the loss between
each goal (where "complaining" means, raise it a power of 10).  If
moving from "_i"_ to "_j_" shouts less than the other way around,
then "_i_" domiantes[^bdom].

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

Here are some low-level trisk for sorting rows.  If the sort key
is numeric, sort on some cell of `Row`.  Else sort on some key of
the `Row` (outside of the cells).

function rcol(r,k) {
  return (typeof(k) == "number")  ? r.cells[k] : r[k]
}

## Distance

function RowDist(i,j,t,what,     n,p,c,d) {
  what = what ? what : "xs"
  p    = THE.row.p
  for (c in t.my[what]) {
    n  = n + 1 
    d += _rowDist1(i.cells[c], j.cells[c], t.cols[c],
                   c in t.my.nums) ^ p
  }
  #print("d",d,"n",n,"p",p)
  return (d/n)^(1/p)
}

function _rowDist1(x, y, col, nump,     no) {
  no = THE.row.skip
  if (x==no && y==no)   
    return 1
  if (!nump) {
    if (x==no || y==no) 
      return 1 
    else 
      return x==y ? 0 : 1 
  }
  if (x==no) {
    y = NumNorm(col, y)
    x = y>0.5 ? 0 : 1
    return abs(x-y)
  } 
  if (y==no) {
    x = NumNorm(col, x)
    y = x>0.5 ? 0 : 1
    return abs(x-y)
  } 
  x = NumNorm(col, x)
  y = NumNorm(col, y) 
  return abs(x-y)
}
