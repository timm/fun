---
title: row.fun
---



| [index](/fun/index) | [about](/fun/ABOUT) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# row.fun

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Tbl]++-1..*[Row|cells;cooked;dom = 0],[Row]-uses-[Col||Col1()]">

`Tbl` (tables) have `Row`s.

```awk
   1.  @include "funny"
   2.  @include "the"
   3.  @include "col"
```

As `Row`s accept `cells`, it passes each cell to a table column
(so that column can update what it knows about that column).

```awk
   4.  function Row(i,t,cells,     c) {
   5.    Object(i)
   6.    has(i,"cells")
   7.    has(i,"cooked")
   8.    i.dom = 0
   9.    for(c in t.cols) 
  10.      i.cells[c] = Col1(t.cols[c],  cells[c]) 
  11.  }
```

To assess the worth of a `Row`, we compare it to a random
number of other `Row`s.

```awk
  12.  function RowDoms(i,all,t,  j) {
  13.    i.dom = 0
  14.    for(j=1; j<=THE.row.doms; j++)
  15.      i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
  16.  }
```

`Row` "_i_" dominates row "_j_"  if "_i_"'s  goals are "better".
To compute this "better", we complain loudly about   the loss between
each goal (where "complaining" means, raise it a power of 10).
If moving from "_i"_ to "_j_" shouts less than the other way around,
then "_i_" domiantes[^bdom].

```awk
  17.  function RowDom(i,j,t,   a,b,c,s1,s2,n) {
  18.    n = length(t.my.w)
  19.    for(c in t.my.w) {
  20.      a   = NumNorm( t.cols[c], i.cells[c] )
  21.      b   = NumNorm( t.cols[c], j.cells[c] )
  22.      s1 -= 10^( t.my.w[c] * (a-b)/n )
  23.      s2 -= 10^( t.my.w[c] * (b-a)/n )
  24.    }
  25.    return s1/n < s2/n
  26.  }
```

[^bdom]: XXX

## See also

- [Tbl](tbl)
- [Col](col)
 
