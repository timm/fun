#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"
@include "col"

#!class [Col|n = 0; col; txt|Col1()]^-[Num|mu = 0; sd = 0],[Col]^-[Sym|mode|SymEnt();SymAny()]-[note: "any" does the sampling{bg:cornsilk}]

[Col|txr;col;n = 0|Col1()]^-[Sym|mode;most = 0;cnt:List|SymEnt(); SymAny()]

The `Sym` class incrementally counts of the symbols seen in a column
as well as the most frequently seen symbol (the `mode`).

function Sym(i,c,v) { 
  Col(i,c,v)
  i.mode=""
  i.most=0
  has(i,"cnt") 
  i.add ="Sym1" 
}
function Sym1(i,v,  tmp) {
  i.n++
  tmp = ++i.cnt[v]
  if (tmp > i.most) {
    i.most = tmp
    i.mode = v }
  return v
}

Entropy is a measure of the variety of a set of systems.
One way to build a learner is to find splits in the data that most reduces
that variety (and then to recursively split divide each split).
Entropy is minimal (zero) when all the symbols  are the same. Otherwise,
given symbols at probability P1, P2, etc then entropy is calcuated[^ent] as follows 

- _&sum;-Px*log2(Px)_ 

Note that the analog  of entropy for continuous distributions is Standard deviation
(discussed below).

[^ent]: For an approximate justification of  this formula,  consder a piece of string 10 meters long, stained in two places by a  meter of red and two metres of green. The probability of stumbling over those colors is Pr=0.1 and Pg=0.2, respectively. To measure the variety of the signal in that string, we could record the effort associated with reconstructing it (i.e. finding all its parts).  To that end, for each color, fold the string in half till oen color is isolated (which requires a number of folds that is approximately _log2(Px)_). Wehn the  probability of doing tose folds is  proportinal to the odds we'll look for that color, then the total effort is _Px*log2(Px)_ (which is repeated for all colors). Finally, by convention, we throw a minus sign around the summation.

function SymEnt(i,   p,e,k) {
  for(k in i.cnt) {
    p  = i.cnt[k]/i.n
    e -= p*log(p)/log(2)  # log(N)/log(2) is the same an log2(N)
  }
  return e
}

To sample symbols from this distribution, (1) pick a random number;
then (2) let every entry "eat" some portion of it;
and (3)
return the symbols found where there is nothing left to eat. Note that for distributions with many numbers,
it is useful to sort the ditionary of symbol counts in descending order (since, usually, the first items in that sort
will be selected most often). But for non-large distribtuions, the following does quite nicely.

function SymAny(i,without,  r,k,m) {
  r = rand()
  for(k in i.cnt) {
    m   = without : i.n - i.cnt[k] : i.cnt[k]
    r  -= m/i.n
    if (r <= 0) return k
  }
  return k
}


