---
title: tbl.fun
---



| [index](/fun/index) | [about](/fun/ABOUT) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# tbl.fun

```awk
   1.  @include "funny"
   2.  @include "col"
   3.  @include "row"
   4.  @include "the"
```

```awk
   5.  BEGIN  {
   6.    SKIPCOL = "\\?"
   7.    NUMCOL  = "[<>\\$]"
   8.    GOALCOL = "[<>!]"
   9.    LESS    = "<"
  10.  }
```
#------------------------------------------------------------
```awk
  11.  func Row(i,t,lst,     c) {
  12.    Object(i)
  13.    has(i,"cells")
  14.    i.dom = 0
  15.    for(c in t.cols) 
  16.      i.cells[c] = Col1(t.cols[c],  lst[c]) 
  17.  }
  18.  func RowDoms(i,all,t,  j) {
  19.    i.dom = 0
  20.    for(j=1; j<=THE.row.doms; j++)
  21.      i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
  22.  }
  23.  func RowDom(i,j,t,   a,b,c,s1,s2,n) {
  24.    n = length(t.my.w)
  25.    for(c in t.my.w) {
  26.      a   = NumNorm( t.cols[c], i.cells[c] )
  27.      b   = NumNorm( t.cols[c], j.cells[c] )
  28.      s1 -= 10^( t.my.w[c] * (a-b)/n )
  29.      s2 -= 10^( t.my.w[c] * (b-a)/n )
  30.    }
  31.    return s1/n < s2/n
  32.  }
```

  
#------------------------------------------------------------
```awk
  33.  func Tbl(i) { 
  34.    Object(i)
  35.    has(i,"my")
  36.    has(i,"cols")
  37.    has(i,"rows") 
  38.  }
  39.  func Tbl1(i,r,lst,    c) {
  40.    if (r==1)  {
  41.      for(c in lst)
  42.        if (lst[c] !~ SKIPCOL) 
  43.          TblCols(i, c, lst[c])
  44.    } else  
  45.      has2(i.rows,r-1,"Row",i,lst)  
  46.  }
  47.  func TblCols(i,c,v) {
  48.    if (v ~ CLASSCOL) i.my.class = c
  49.    v ~ NUMCOL  ? i.my.nums[c] : i.my.syms[c]
  50.    v ~ GOALCOL ? i.my.goals[c]: i.my.xs[c]
  51.    if (v ~ />/) i.my.w[c] =  1
  52.    if (v ~ /</) i.my.w[c] = -1
  53.    has2(i.cols,c,
  54.         v ~NUMCOL ? "Num" : "Sym",
  55.         c,v) 
  56.  }
```

