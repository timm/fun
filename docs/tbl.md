---
title: tbl.fun
---

<button class="button"><a href="/fun/ABOUT">about</a></button>   <button class="button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button2"><a href="/fun/license">license</a></button> <br>



# tbl.fun

Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>
Uses:  "[row](row)"<br>
Uses:  "[the](the)"<br>

```awk
   1.  BEGIN  {
   2.    SKIPCOL = "\\?"
   3.    NUMCOL  = "[<>\\$]"
   4.    GOALCOL = "[<>!]"
   5.    LESS    = "<"
   6.  }
```
#------------------------------------------------------------
```awk
   7.  func Row(i,t,lst,     c) {
   8.    Object(i)
   9.    has(i,"cells")
  10.    i.dom = 0
  11.    for(c in t.cols) 
  12.      i.cells[c] = Col1(t.cols[c],  lst[c]) 
  13.  }
  14.  func RowDoms(i,all,t,  j) {
  15.    i.dom = 0
  16.    for(j=1; j<=THE.row.doms; j++)
  17.      i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
  18.  }
  19.  func RowDom(i,j,t,   a,b,c,s1,s2,n) {
  20.    n = length(t.my.w)
  21.    for(c in t.my.w) {
  22.      a   = NumNorm( t.cols[c], i.cells[c] )
  23.      b   = NumNorm( t.cols[c], j.cells[c] )
  24.      s1 -= 10^( t.my.w[c] * (a-b)/n )
  25.      s2 -= 10^( t.my.w[c] * (b-a)/n )
  26.    }
  27.    return s1/n < s2/n
  28.  }
```

  
#------------------------------------------------------------
```awk
  29.  func Tbl(i) { 
  30.    Object(i)
  31.    has(i,"my")
  32.    has(i,"cols")
  33.    has(i,"rows") 
  34.  }
  35.  func Tbl1(i,r,lst,    c) {
  36.    if (r==1)  {
  37.      for(c in lst)
  38.        if (lst[c] !~ SKIPCOL) 
  39.          TblCols(i, c, lst[c])
  40.    } else  
  41.      has2(i.rows,r-1,"Row",i,lst)  
  42.  }
  43.  func TblCols(i,c,v) {
  44.    if (v ~ CLASSCOL) i.my.class = c
  45.    v ~ NUMCOL  ? i.my.nums[c] : i.my.syms[c]
  46.    v ~ GOALCOL ? i.my.goals[c]: i.my.xs[c]
  47.    if (v ~ />/) i.my.w[c] =  1
  48.    if (v ~ /</) i.my.w[c] = -1
  49.    has2(i.cols,c,
  50.         v ~NUMCOL ? "Num" : "Sym",
  51.         c,v) 
  52.  }
```

