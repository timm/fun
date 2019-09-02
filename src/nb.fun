#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

## Naive Bayes Classifier

@include "funny"
@include "tbl"
@include "num"
@include "sym"

#!class [Nb||NbLike();]1-things-1*[Tbl], [Tbl]1-*[Num||NumLike();], [Tbl]1-*[Sym||SymLike()]

The `Nb` class reads rows either from some source `Tbl` or from disk (via the `lines` function).
Internally, `Nb` maintains its own `Tbl`s:

- One for each class seen during reading.
- One for the overall stats
 
To classify a new row, `Nb` asks each of those internal `Tbl`s how much they `like` the new
row (and the new row gets the classification of the `Tbl` who likes it the most).

function Nb(i) {
  has1(i,"all","Tbl",1) # Tables do not keep rows (uses less memory).
  has(i,"things")
  i.m = THE.nb.m
  i.k = THE.nb.k
}

function NbLike(i,row,    best,t,like,guess) {
  best = -10^64
  for(t in i.things) {
    like = _nblike( i, row, length(i.all.rows) length(i.things), i.things[t]))
    if (like > best) {
      best  = like
      guess = t
  }}
  return guess
}

function _nblike(i,row,nall,nthings,thing,    like,prior,c,x,inc) {
    like = prior = (length(thing.rows)  + i.k) / (nall + i.k * nthings)
    like = log(like)
    for(c in  thing.xs) {
      x = row.cells[c]
      if (x == SKIPCOL) continue
      if (c in thing.nums)
        like += log( NumLike(thing.cols[c], x) )
      else
        like += log( SymLike(thing.cols[c], x, prior, i.m) )
    }
    return like
}

function NbFromFile(i,f) { lines(i.all,"Nb1",f) }

Add a new row to the NaiveBayes classifier

function Nb1(i,r,lst) {
  Tbl1(i,r,lst)
  i.rows[length(i.rows)]
}

