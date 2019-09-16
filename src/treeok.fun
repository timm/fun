#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------


@include "funny"
@include "tree"
@include "tbl"

BEGIN { tests("treeok", "_tree") }

function  _tree(f,  i,t,c) {
  Tbl(t)
  lines(t,"Tbl1",DOT DOT "/data/weathernom" DOT "csv")
  #for(c in t.xnums) TreeNum(i,t,'$playHours',c)
  for(c in t.my.xsyms)
     TreeSym(i,t,t.my.class,c)
}
