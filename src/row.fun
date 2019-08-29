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

function RowDist(i,j,t,what) {
  what = what ? what : "xs"
  return _rowDist(i,j, t.my[what], t.my.syms, t.cols)
}

function _rowDist(i,j,what,syms,cols,    p,c,n,d0,d) {
  p = THE.row.p
  for (c in what) {
    n  = n + 1 
    d0 = _rowDist1(i.cells[c], j.cells[c], cols[c], c in syms)
    d += d0^p
  }
  return (d/n)^(1/p)
}

The following needs a little explaination. Accoring to [Aha91](#aha-91):

- _Principle1_ : when doing distance calculations, normalize all distances for
   each attribte from zero to one (otherwise, one attribute can have an undue 
   influence, For example,  astronauts have age 0 to 120 but 
   fly at speeds 0 to 25,000. So before we compare to rows containing
   information and astronaut age and velocity, make all ranges 0..1, min..max.
   - For symbols, this is is easy: indentical symbols have distance 
     zero; otherwise, their distance is one.
   - For numerics, just normalize all values `x` with `(x - lo)/(hi - lo`+&epsilon;`)` where `x` comes from some column and `lo,hi` are the smallest and largest
     values in that colum, and &epsilon; is some tiny amout (`10^-32`) included
     to avoid divde-by-zero errirs).
- _Principle2_: when position are unknown, assume maximum. This heuristic
  assumes that unknown things can be anywhere which means, on average,
  they are not close by.

The following code applies these principles:

- _Case1_: randomly selected items can be very distant so if i
  there is uncertainty about both position, assume worst case.
- _Case2_: identical things are not seperated. 
- If a symbol then
    - _Case3_if either is unknown, assume max distance=1;
    - _Case4_ else, if they are different, then distance=1;
    - _Case5_ else, if the same, then distance=0 (covered by _Case2_)
- If a number, then:
    - _Case6_ if one is unknown, make the assumptions that maximizies the distance
    - _Case7_: Finally, after normalizing the nuers zero to one, return
      the distance between them

function _rowDist1(x, y, col, symp,     no) {
  no = THE.row.skip
  if (x==no && y==no)    
    return 1 # Case1: assume max
  else if (x==y)
     return 0 # Case2: return min
  else {
    if (symp) 
      return 1 # Case3, Case4
    else { 
      if (x==no) { #Case6
        y = NumNorm(col, y)
        x = y>0.5 ? 0 : 1
      } else if (y==no) { #Case6
        x = NumNorm(col, x)
        y = x>0.5 ? 0 : 1
      } else { #ensure everything is noralized
        x = NumNorm(col, x)
        y = NumNorm(col, y) 
      }
      return abs(x-y) }} # Case7
}


## References

### Aha 91

David W. Aha, Dennis Kibler, and Marc K. Albert. 1991. Instance-Based Learning Algorithms. Mach. Learn. 6, 1 (January 1991), 37-66. DOI: https://doi.org/10.1023/A:1022689900470
