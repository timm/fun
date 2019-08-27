---
title: row.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# row.fun


## Store rows of tables.

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Tbl]++-1..*[Row|cells;cooked;dom = 0],[Row]-uses-[Col||Col1()]">

`Tbl` (tables) have `Row`s.

Uses:  "[funny](funny)"<br>
Uses:  "[the](the)"<br>
Uses:  "[tbl](tbl)"<br>
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

## Scoring Rows

To assess the worth of a `Row`, we compare it to a random number
of other `Row`s.

```awk
   9.  function RowDoms(i,all,t,  j) {
  10.    i.dom = 0
  11.    for(j=1; j<=THE.row.doms; j++)
  12.      i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
  13.  }
```

`Row` "_i_" dominates row "_j_"  if "_i_"'s  goals are "better".
To compute this "better", we complain loudly about   the loss between
each goal (where "complaining" means, raise it a power of 10).  If
moving from "_i"_ to "_j_" shouts less than the other way around,
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

Here are some low-level trisk for sorting rows.  If the sort key
is numeric, sort on some cell of `Row`.  Else sort on some key of
the `Row` (outside of the cells).

```awk
  24.  function rcol(r,k) {
  25.    return (typeof(k) == "number")  ? r.cells[k] : r[k]
  26.  }
```

## Distance

```awk
  27.  function RowDist(i,j,t,what) {
  28.    what = what ? what : "xs"
  29.    return _rowDist(i,j, t.my[what], t.my.syms, t.cols)
  30.  }
```

```awk
  31.  function _rowDist(i,j,what,syms,cols,    p,c,n,d0,d) {
  32.    p = THE.row.p
  33.    for (c in what) {
  34.      n  = n + 1 
  35.      d0 = _rowDist1(i.cells[c], j.cells[c], cols[c], c in syms)
  36.      d += d0^p
  37.    }
  38.    return (d/n)^(1/p)
  39.  }
```

```awk
  40.  function _rowDist1(x, y, col, symp,     no) {
  41.    no = THE.row.skip
  42.    if (x==no && y==no)    
  43.      return 1 # assume max
  44.    else {
  45.      if (symp) {
  46.        if (x==no || y==no) 
  47.          return 1 # assume max
  48.        else 
  49.          return x==y ? 0 : 1 # identical symbols have no distance
  50.      } else { # if nump, set mising values to max, normalize numbers
  51.          print(x,y)
  52.          if (x==no) {
  53.            y = NumNorm(col, y)
  54.            x = y>0.5 ? 0 : 1
  55.          } else if (y==no) {
  56.            x = NumNorm(col, x)
  57.            y = x>0.5 ? 0 : 1
  58.          } else {
  59.            x = NumNorm(col, x)
  60.            y = NumNorm(col, y) 
  61.          }
  62.          print(x,y)
  63.          return abs(x-y) }}
  64.  }
```
