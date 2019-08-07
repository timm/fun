---
title: tbl.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019, Tim Menzies, http://menzies.us</em>

# tbl.fun

```awk
@include "funny"
@include "col"
@include "row"
@include "the"
```

```awk
BEGIN  {
  SKIPCOL = "\\?"
  NUMCOL  = "[<>\\$]"
  GOALCOL = "[<>!]"
  LESS    = "<"
}
```
#------------------------------------------------------------
```awk
func Row(i,t,lst,     c) {
  Object(i)
  has(i,"cells")
  i.dom = 0
  for(c in t.cols) 
    i.cells[c] = Col1(t.cols[c],  lst[c]) 
}
func RowDoms(i,all,t,  j) {
  i.dom = 0
  for(j=1; j<=THE.row.doms; j++)
    i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
}
func RowDom(i,j,t,   a,b,c,s1,s2,n) {
  n = length(t.my.w)
  for(c in t.my.w) {
    a   = NumNorm( t.cols[c], i.cells[c] )
    b   = NumNorm( t.cols[c], j.cells[c] )
    s1 -= 10^( t.my.w[c] * (a-b)/n )
    s2 -= 10^( t.my.w[c] * (b-a)/n )
  }
  return s1/n < s2/n
}
```

  
#------------------------------------------------------------
```awk
func Tbl(i) { 
  Object(i)
  has(i,"my")
  has(i,"cols")
  has(i,"rows") 
}
func Tbl1(i,r,lst,    c) {
  if (r==1)  {
    for(c in lst)
      if (lst[c] !~ SKIPCOL) 
        TblCols(i, c, lst[c])
  } else  
    has2(i.rows,r-1,"Row",i,lst)  
}
func TblCols(i,c,v) {
  if (v ~ CLASSCOL) i.my.class = c
  v ~ NUMCOL  ? i.my.nums[c] : i.my.syms[c]
  v ~ GOALCOL ? i.my.goals[c]: i.my.xs[c]
  if (v ~ />/) i.my.w[c] =  1
  if (v ~ /</) i.my.w[c] = -1
  has2(i.cols,c,
       v ~NUMCOL ? "Num" : "Sym",
       c,v) 
}
```

