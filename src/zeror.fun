#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

## Zero-R Classifier

@include "funny"
@include "tbl"

`ZeroR` classifies everything as belonging to the  most frequent
class.

Here is a `ZeroR` payload object, suitable for streaming over data.

function ZeroR(i) {
  has(i,"tbl","Tbl") 
}

Here is the `ZeroR` training function, suitable for updating the
payload `i` from row number `r` 
(which contains the data found in `lst`).



function ZeroRTrain(i,r,lst) { 
  Tbl1(i.tbl, r, lst) 
}

Here is the `ZeroR` classification function, that uses the payload
`i` to guess the class of row number `r`
(which contains the data found in `lst`).

function ZeroRClassify(i,r,lst,x) {
  return  i.tbl.cols[ i.tbl.my.class ].mode
}


