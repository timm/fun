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

_Naive Bayes_ (here after, `Nb`) collects seperate statistics
for each class found in the training data.
Them, to classify a new example, it asks the statistics of
each class "how much do you _like_ this example?"
(where "like" means that the example is closest to the statistics
seen from that class)..
The new example gets laballed as the class that
 that "likes" it the most.

For example, here are some red and blue things, measured using some _x,y_ values.
Red things have a mean x,y value of 7,8 and blue things have a mean x,y value of 3,4.
The red line shows the "decision boundary" where we start "liking" one color
more that the other. 

![](assets/img/bayes102.png)

`Nb`  is fast to execute (to classify new examples) and  also fast to train
(as you see each row, update the statistics kept for every column).
Better yet, it is easy to incrementally update Naive Bayes classifiers, one row
of data at a time. The e same can not be said for other learers that must reflect
over all the data to build their models.

Naive Bayes is called "naive" since it keeps statistics on each
column seperate to all rest.

-  The good news is that this means
that Naive Bayes classifiers are very memory effecient. All
you need is the memory for the column statistics
(and  
updates
the
column stats, there is no need to hang on to the row).
- On the other hand, the bad news is that Naive Bayes classifiers never considers dependancies
between the columns. 

Strange to say, in practice, this Naive Baues assumption
 rarely matters. Here are some performance results
of Naive Bayes versus other learners (where those other learners reflect
on attribute dependancy). Observe that Naive Bayes does pretty well:

[![](assets/img/bayes301.png)](http://engr.case.edu/ray_soumya/mlrg/optimality_of_nb.pdf)  

Why isn't Naive Bayes so naive?
It turns other that
such dependancies exist between attributes, then they alter the decision boundary by some
amount &epsilon;. 
[Domingos and Pazzani](http://engr.case.edu/ray_soumya/mlrg/optimality_of_nb.pdf)  have
shown that
As the number of dimensions grows,
then the hypervolume of these &epsilons;s shrinks to a very small fraction  of the total
attribute space. That is, the decisions made by a Naive Bayes classifier (that fretted
about dependancies) is usually the same as an optimal Bayes classifier (that took
those dependancies into account).

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

