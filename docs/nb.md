---
title: nb.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# nb.fun
## Naive Bayes Classifier

Uses:  "[funny](funny)"<br>
Uses:  "[tbl](tbl)"<br>
Uses:  "[num](num)"<br>
Uses:  "[sym](sym)"<br>

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Nb||NbLike();]1-things-1*[Tbl], [Tbl]1-*[Num||NumLike();], [Tbl]1-*[Sym||SymLike()]">

_Nave Bayes_ (here after, `Nb`) collects seperate statistics
for each class found in the training data.
Them, to classify a new example, it asks the statistics of
each class "how much do you _like_ this example?"
(where "like" means that the example is closest to the statistics
seen from that class)..
The new example gets laballed as the class that
 that "likes" it the most.

The `Nb` class reads rows either from some source `Tbl` or from
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




```awk
   1.  function Nb(i) {
   2.    has1(i,"all","Tbl",1) # Tables do not keep rows (uses less memory).
   3.    has(i,"things")
   4.    i.m = THE.nb.m
   5.    i.k = THE.nb.k
   6.  }
```

```awk
   7.  function NbLike(i,row,    best,t,like,guess) {
   8.    best = -10^64
   9.    for(t in i.things) {
  10.      like = _nblike( i, row, length(i.all.rows) length(i.things), i.things[t]))
  11.      if (like > best) {
  12.        best  = like
  13.        guess = t
  14.    }}
  15.    return guess
  16.  }
```

```awk
  17.  function _nblike(i,row,nall,nthings,thing,    like,prior,c,x,inc) {
  18.      like = prior = (length(thing.rows)  + i.k) / (nall + i.k * nthings)
  19.      like = log(like)
  20.      for(c in  thing.xs) {
  21.        x = row.cells[c]
  22.        if (x == SKIPCOL) continue
  23.        if (c in thing.nums)
  24.          like += log( NumLike(thing.cols[c], x) )
  25.        else
  26.          like += log( SymLike(thing.cols[c], x, prior, i.m) )
  27.      }
  28.      return like
  29.  }
```

```awk
  30.  function NbFromFile(i,f) { lines(i.all,"Nb1",f) }
```

Add a new row to the NaiveBayes classifier

```awk
  31.  function Nb1(i,r,lst) {
  32.    Tbl1(i,r,lst)
  33.    i.rows[length(i.rows)]
  34.  }
```

