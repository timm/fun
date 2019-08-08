#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "sym"

BEGIN {  tests("colok","_sym,_syms") }

If we sample from a `Sym`, does it generate
items at the right frequency?

func _syms(f,   max,s,a,b,i,j,k) {
  max=256
  s="aaaabbc"
  Sym(i)
  Sym(j)
  split(s,a,"")
  for(k in a) Sym1(i, a[k]) # load "i"
  for(k=1; k<=max; k++) 
    Sym1(j,SymAny(i))  # sample "i" to load "j"
  is(f, SymEnt(i), SymEnt(j), 0.05)
}

Checkng some sample entropy counts:

function _sym(f) {
  is(f, _sym1("aaaabbc"), 1.37878) 
  is(f, _sym1("aaaaaaa"), 0)
}

func _sym1(s,   a,i,j) {
  Sym(i)
  split(s,a,"")
  for(j in a) 
    Sym1(i, a[j])
  return SymEnt(i)
}
