#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

## Zero-R Classifier

@include "funny"
@include "tbl"

Here is a `ZeroR` payload object,
suitable for streaming over data.

function ZeroR(i) {
  has(i,"tbl","Tbl") 
}

Here is the `ZeroR`
training function, suitable
for updating the payload `i` from row number
`r` containint fields `lst`.

function ZeroRTrain(i,r,lst) { 
  Tbl1(i.tbl, r, lst) 
}

Here is the `ZeroR` classification function, 
suitable
for guessing the class of a row containing
the data in `lst`. Note that `ZeroR` classifies
everything as belonging to the  most frequent
class.


function ZeroRClassify(i,r,lst,x) {
  return  i.tbl.cols[ i.tbl.my.class ].mode
}


