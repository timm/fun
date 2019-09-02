---
title: tbl.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# tbl.fun



Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>
Uses:  "[row](row)"<br>
Uses:  "[the](the)"<br>
Uses:  "[num](num)"<br>
Uses:  "[sym](sym)"<br>

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Tbl|norows=0]1-rows-1*[Row], [Tbl]1-cols-*[Col], [Col]^-[Num], [Col]^-[Sym]">

## Store rows of data (and summarize the columns).

If `norows` is true. just keep the statistics for the columns.


```awk
   1.  BEGIN  {
   2.    SKIPCOL = "\\?"
   3.    NUMCOL  = "[<>\\$]"
   4.    GOALCOL = "[<>!]"
   5.    LESS    = "<"
   6.  }
```

```awk
   7.  function Tbl(i, norows) { 
   8.    Object(i)
   9.    has(i,"my","TblAbout")
  10.    has(i,"cols")
  11.    has(i,"rows") 
  12.    i.norows = norows
  13.  }
  14.  function Tbl1(i,r,lst,    c) {
  15.    if (r==1)  {
  16.      for(c in lst)
  17.        if (lst[c] !~ SKIPCOL) 
  18.          TblCols(i, c, lst[c])
  19.    } else  {
  20.      if (i.norows)
  21.        for(c in i.cols)
  22.          Col1(i.cols[c],lst[c])
  23.      else
  24.        has2(i.rows,r-1,"Row",i,lst)  
  25.  }}
```

```awk
  26.  function TblAbout(i) {
  27.    i.class = ""
  28.    has(i,"nums")
  29.    has(i,"syms")
  30.    has(i,"xnums")
  31.    has(i,"xsyms")
  32.    has(i,"goals")
  33.    has(i,"xs")
  34.    has(i,"w")
  35.  }
  36.  function TblCols(i,c,v) {
  37.    if (v ~ CLASSCOL) i.my.class = c
  38.    v ~ NUMCOL  ? i.my.nums[c] : i.my.syms[c]
  39.    v ~ GOALCOL ? i.my.goals[c]: i.my.xs[c]
  40.    if (c in i.my.xs && c in i.my.num ) i.my.xnums[c]
  41.    if (c in i.my.xs && c in i.my.syms) i.my.xsyms[c]
  42.    if (v ~ />/) i.my.w[c] =  1
  43.    if (v ~ /</) i.my.w[c] = -1
  44.    has2(i.cols,c,
  45.         v ~NUMCOL ? "Num" : "Sym",
  46.         c,v) 
  47.  }
```

