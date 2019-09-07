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
  16.        if (lst[c] !~ SKIPCOL) 
  17.          TblCols(i, c, lst[c])
  18.    } else  {
  19.      if (i.norows)
  20.        for(c in i.cols)
  21.          Col1(i.cols[c],lst[c])
  22.      else
  23.        has2(i.rows,r-1,"Row",i,lst)  
  24.  } }
```

```awk
  25.  function TblAbout(i) {
  26.    i.class = ""
  27.    has(i,"nums")
  28.    has(i,"syms")
  29.    has(i,"xnums")
  30.    has(i,"xsyms")
  31.    has(i,"goals")
  32.    has(i,"xs")
  33.    has(i,"w")
  34.  }
  35.  function TblCols(i,c,v) {
  36.    if (v ~ CLASSCOL) i.my.class = c
  37.    v ~ NUMCOL  ? i.my.nums[c] : i.my.syms[c]
  38.    v ~ GOALCOL ? i.my.goals[c]: i.my.xs[c]
  39.    if (c in i.my.xs && c in i.my.nums) i.my.xnums[c]
  40.    if (c in i.my.xs && c in i.my.syms) i.my.xsyms[c]
  41.    if (v ~ />/) i.my.w[c] =  1
  42.    if (v ~ /</) i.my.w[c] = -1
  43.    has2(i.cols,c,
  44.         v ~NUMCOL ? "Num" : "Sym",
  45.         c,v) 
  46.  }
```

