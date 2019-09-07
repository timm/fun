#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

## Zero-R Classifier

@include "funny"
@include "tbl"

function ZeroR(i) {
  has(i,"tbl","Tbl") 
}

function ZeroRTrain(i,r,lst) { 
  Tbl1(i.tbl, r, lst) 
}
function ZeroRClassify(i,r,lst,x) {
  return  i.tbl.cols[ i.tbl.my.class ].mode
}
