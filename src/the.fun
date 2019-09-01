#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------


## Configuration options.

@include "funny"

Generates `THE`,  a global to store all the configuration settings.
The thing to note here is that a data miner/optimizer uses many,
many settings.  AI tools are needed to explore this very large space
of options.

function Config(i,   dot) {
  dot = sprintf("%c",46)
  i.row.doms   =   64
  i.row.p      =    2
  i.row.skip   =    "?"

  i.div.min    =    0.5
  i.div.cohen  =    0.3
  i.div.trivial=    1.05
  i.div.enough =  512
  i.div.verbose=    1

  i.some.most  =  256
  i.some.ks    =   95

  i.sk.cliffs  =    0.147 # small effect. From Romano 2006
  i.sk.b       =  200 
  i.sk.conf    =   99

  i.nums.hedges=    0.38 # small effect. Use 1.0 for medium effect
  i.nums.ttest =   95 # selects thresholds for ttest

  i.cocomo.num = "[+-]?([0-9]+["dot"]?[0-9]*|["dot"][0-9]+)([eE][+-]?[0-9]+)?"


}

BEGIN {Config(THE)}
