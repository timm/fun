#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

## Naive Bayes Classifier

@include "funny"
@include "tbl"
@include "num"
@include "sym"

#!class [Nb||NbLike();]1-things-1*[Tbl], [Tbl]1-*[Num||NumLike();], [Tbl]1-*[Sym||SymLike()]

_Nave Bayes_ (here after, `Nb`) collects seperate statistics
for each class found in the training data.
Them, to classify a new example, it asks the statistics of
each class "how much do you _like_ this example?"
(where "like" means that the example is closest to the statistics
seen from that class)..
The new example gets laballed as the class that
 that "likes" it the most.

More precisely, `Nb` applies Baye's Theorem to data. This theorem
says what we conclude is a product of

- what we believed before (this is called the _prior_) and 
- what evidence we see now

That is, the probability of some hypothesis _H_,
 given evidence _E_, is
 the
the probabiliy of that evidence times the probability of that evidence, given that hypotehsis. That is:

- _new = now * before_ or, more formally:
- _P( H|E ) = P( E|H ) * P(H) _

The right-hand-side of this expression shoudlbe  divided by 
_P(E)_; i.e. the probability of the evidence. But we never have to compute that since when
when  we ask "does H1 or H2 have most evidence", then we compute:
 _P( H1|E ) / P( H2|E )_. 
Since the probability of the 
evidence is the same across all hypothesis, then this _P(E)_ term
just divides away (so we can ignore it).

To implement all this, we need to to keep statistics on all the different
hypotheses.
To that end, the `Nb` class reads rows either from some source `Tbl` or from
disk (via the `lines` function).  Internally, `Nb` maintains its
own `Tbl`s:

- One for each class seen during reading.
- One for the overall stats
 
To classify a new row, `Nb` asks each of those internal `Tbl`s how
much they `like` the new row (and the new row gets the classification
of the `Tbl` who likes it the most).

Here is a `Nb` payload object,
suitable for streaming over data, all the while
performing `Nb`-style classification.


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

