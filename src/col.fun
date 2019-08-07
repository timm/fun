#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"

#!class [Col|n = 0; col; txt|Col1()]^-[Num|mu = 0; sd = 0|NumAny()],[Col]^-[Sym|mode|NumEnt();SymAny()]

`Num` and `Sym`s keep summary statistics on `Col`umns in tables. 

See also:  [Num](num),  [Sym](sym).

## Col

function Col(i,c,v) { 
  Object(i)   
  i.n=0
  i.col=c
  i.txt=v 
} 

The generic add function ignroes anything that is a `"?"`. 

BEGIN {IGNORE="\\?"}
function Col1(i,v,   add) {
  if (v ~ IGNORE) return v
  add = i.add
  return @add(i,v)
} 

Sym and Num track the central tendancies and variety  of the the columns they watch

- For `Num`s, that is called mode and entropy (see `mode` and `NumEnt()`);
- For `Sym`s, that is called mean and standard deviation (see `mu` and `sd`),

`Sym` and `Num` also know  how to "sample"; i.e. to generate numbers or symbols
at a frequency that is similiar to the data from which they learned their distributions
(see the `*Any()` functions).


