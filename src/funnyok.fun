#!/usr/bin/env ./fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"

BEGIN { tests("lauk", "_lauk") }

func _lauk(f,   a,b,i) {
  split("a,b,c,d,e,f",a,",")
  for(i=1;i<=50;i++) b[i]=anyi(a)
  asort(b)
  flat(b,1)
}
