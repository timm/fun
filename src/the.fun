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

  i.some.most  = 256
  i.some.cliffs=   0.147 # small effect. From Romano 2006

  i.nums.hedges=   0.38 # small effect. Use 1.0 for medium effect
  i.nums.ttest=   95 # selects thresholds for ttest

}

BEGIN {Config(THE)}
