#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"

function Tiny(i) {
  i.a=23

}

BEGIN {Tiny(i); oo(i)}
