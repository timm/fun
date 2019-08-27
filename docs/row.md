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
  27.  function RowDist(i,j,t,what,     n,p,c,d) {
  28.    what = what ? what : "xs"
  29.    p    = THE.row.p
  30.    for (c in t.my[what]) {
  31.      n  = n + 1 
  32.      d += _rowDist1(i.cells[c], j.cells[c], t.cols[c],
  33.                     c in t.my.nums) ^ p
  34.    }
  35.    #print("d",d,"n",n,"p",p)
  36.    return (d/n)^(1/p)
  37.  }
```

```awk
  38.  function _rowDist1(x, y, col, nump,     no) {
  39.    no = THE.row.skip
  40.    if (x==no && y==no)   
  41.      return 1
  42.    if (!nump) {
  43.      if (x==no || y==no) 
  44.        return 1 
  45.      else 
  46.        return x==y ? 0 : 1 
  47.    }
  48.    if (x==no) {
  49.      y = NumNorm(col, y)
  50.      x = y>0.5 ? 0 : 1
  51.      return abs(x-y)
  52.    } 
  53.    if (y==no) {
  54.      x = NumNorm(col, x)
  55.      y = x>0.5 ? 0 : 1
  56.      return abs(x-y)
  57.    } 
  58.    x = NumNorm(col, x)
  59.    y = NumNorm(col, y) 
  60.    return abs(x-y)
  61.  }
```
