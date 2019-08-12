---
title: tbl.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# tbl.fun


## Store rows of data (and summarize the columns).

Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>
Uses:  "[row](row)"<br>
Uses:  "[the](the)"<br>
Uses:  "[num](num)"<br>
Uses:  "[sym](sym)"<br>

```awk
   1.  BEGIN  {
   2.    SKIPCOL = "\\?"
   3.    NUMCOL  = "[<>\\$]"
   4.    GOALCOL = "[<>!]"
   5.    LESS    = "<"
   6.  }
```

```awk
   7.  function Tbl(i) { 
   8.    Object(i)
   9.    has(i,"my")
  10.    has(i,"cols")
  11.    has(i,"rows") 
  12.  }
  13.  function Tbl1(i,r,lst,    c) {
  14.    print("r",r)
  15.    if (r==1)  {
  16.      for(c in lst)
  17.        if (lst[c] !~ SKIPCOL) 
  18.          TblCols(i, c, lst[c])
  19.    } else  
  20.      has2(i.rows,r-1,"Row",i,lst)  
  21.  }
  22.  function TblCols(i,c,v) {
  23.    if (v ~ CLASSCOL) i.my.class = c
  24.    v ~ NUMCOL  ? i.my.nums[c] : i.my.syms[c]
  25.    v ~ GOALCOL ? i.my.goals[c]: i.my.xs[c]
  26.    if (v ~ />/) i.my.w[c] =  1
  27.    if (v ~ /</) i.my.w[c] = -1
  28.    has2(i.cols,c,
  29.         v ~NUMCOL ? "Num" : "Sym",
  30.         c,v) 
  31.  }
```


