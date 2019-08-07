#!/usr/bin/env ./fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"

func Config(i) {
  Object(i)
  i.row.doms  =   64
  i.div.min   =    0.5
  i.div.cohen =    0.3
  i.div.trivial=   1.05
  i.div.enough=  512
}

BEGIN {Config(THE)}
