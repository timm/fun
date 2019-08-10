---
title: row.fun
---

<<button class="button button1"><a href="/fun/index">index</a></button>   button class="button button2"><a href="/fun/ABOUT">about</a></button>   <button class="button button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button2"><a href="/fun/license">license</a></button> <br>



# row.fun

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Tbl]++-1..*[Row|cells;cooked;dom = 0],[Row]-uses-[Col||Col1()]">

`Tbl` (tables) have `Row`s.

Uses:  "[funny](funny)"<br>
Uses:  "[the](the)"<br>
Uses:  "[col](col)"<br>

As `Row`s accept `cells`, it passes each cell to a table column
(so that column can update what it knows about that column).

```awk
   1.  function Row(i,t,cells,     c) {
   2.    Object(i)
   3.    has(i,"cells")
   4.    has(i,"cooked")
   5.    i.dom = 0
   6.    for(c in t.cols) 
   7.      i.cells[c] = Col1(t.cols[c],  cells[c]) 
   8.  }
```

To assess the worth of a `Row`, we compare it to a random
number of other `Row`s.

```awk
   9.  function RowDoms(i,all,t,  j) {
  10.    i.dom = 0
  11.    for(j=1; j<=THE.row.doms; j++)
  12.      i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
  13.  }
```

`Row` "_i_" dominates row "_j_"  if "_i_"'s  goals are "better".
To compute this "better", we complain loudly about   the loss between
each goal (where "complaining" means, raise it a power of 10).
If moving from "_i"_ to "_j_" shouts less than the other way around,
then "_i_" domiantes[^bdom].

```awk
  14.  function RowDom(i,j,t,   a,b,c,s1,s2,n) {
  15.    n = length(t.my.w)
  16.    for(c in t.my.w) {
  17.      a   = NumNorm( t.cols[c], i.cells[c] )
  18.      b   = NumNorm( t.cols[c], j.cells[c] )
  19.      s1 -= 10^( t.my.w[c] * (a-b)/n )
  20.      s2 -= 10^( t.my.w[c] * (b-a)/n )
  21.    }
  22.    return s1/n < s2/n
  23.  }
```

[^bdom]: XXX

## See also

- [Tbl](tbl)
- [Col](col)
 
