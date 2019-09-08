#!/usr/bin/env ./fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------



@include "funny"
@include "col"
@include "row"
@include "the"
@include "num"
@include "sym"

#!class [Tbl|norows=0]1-rows-1*[Row], [Tbl]1-cols-*[Col], [Col]^-[Num], [Col]^-[Sym]

## Store rows of data (and summarize the columns).

If `norows` is true. just keep the statistics for the columns.


BEGIN  {
  SKIPCOL = "\\?"
  NUMCOL  = "[<>\\$]"
  GOALCOL = "[<>!]"
  LESS    = "<"
}

function Tbl(i, norows) { 
  Object(i)
  has(i,"my","TblAbout")
  has(i,"cols")
  has(i,"rows") 
  i.norows = norows
}
function Tbl1(i,r,lst,    c) {
  if (r==1)  {
    for(c in lst)
      if (lst[c] !~ SKIPCOL) 
        TblCols(i, c, lst[c])
  } else  {
    if (i.norows)
      for(c in i.cols)
        Col1(i.cols[c],lst[c])
    else
      has2(i.rows,r-1,"Row",i,lst)  
} }

function TblAbout(i) {
  i.class = ""
  has(i,"nums")
  has(i,"syms")
  has(i,"xnums")
  has(i,"xsyms")
  has(i,"goals")
  has(i,"xs")
  has(i,"w")
}
function TblCols(i,c,v) {
  if (v ~ CLASSCOL) i.my.class = c
  v ~ NUMCOL  ? i.my.nums[c] : i.my.syms[c]
  v ~ GOALCOL ? i.my.goals[c]: i.my.xs[c]
  if (c in i.my.xs && c in i.my.nums) i.my.xnums[c]
  if (c in i.my.xs && c in i.my.syms) i.my.xsyms[c]
  if (v ~ />/) i.my.w[c] =  1
  if (v ~ /</) i.my.w[c] = -1
  has2(i.cols,c,
       v ~NUMCOL ? "Num" : "Sym",
       c,v) 
}

function TblHeader(i,  lst,c) {
  List(lst)
  for(c in i.cols)
    lst[c] = i.cols[c].txt
}
