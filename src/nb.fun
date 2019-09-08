#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

## Naive Bayes Classifier

@include "funny"
@include "tbl"
@include "num"
@include "sym"

#!class [Nb||NbLike();]1-things-1*[Tbl], [Tbl]1-*[Num||NumLike();], [Tbl]1-*[Sym||SymLike()]

_Naive Bayes_ (here after, `Nb`) collects seperate statistics
for each class found in the training data.
Them, to classify a new example, it asks the statistics of
each class "how much do you _like_ this example?"
(where "like" means that the example is closest to the statistics
seen from that class)..
The new example gets laballed as the class that
 that "likes" it the most.

For example, here are some red and blue things.
Red things have a mean x,y value of 7,8 and blue things have a mean x,y value of 3,4.
The red line shows the "decision boundary" where we start "liking" one color
more that the other. 

![](assets/img/bayes102.png)

`Nb`  is fast to execute (to classify new examples) and  also fast to train
(as you see each row, update the statistics kept for every column).
Better yet, it is easy to incrementally update Naive Bayes classifiers, one row
of data at a time. The  same can not be said for other learers that must reflect
over all the data to build their models.

Naive Bayes is called "naive" since it keeps statistics on each
column seperate to all rest.

-  The good news is that this means
that Naive Bayes classifiers are very memory effecient. All
you need is the memory for the column statistics
(since once you  update the column stats, there is no need to hang on to the row).
- On the other hand, the bad news is that Naive Bayes classifiers never considers dependancies
between the columns. This means, in theory anyway, that Naive Bayes' probability
calculations could be erroneous.

Strange to say, in practice, the naive assumption of
 Naive Bayes 
 rarely matters. Here are some performance results
of Naive Bayes versus other learners (where those other learners reflect
on attribute dependancy). Observe that Naive Bayes does pretty well:

[![](assets/img/bayes301.png)](http://engr.case.edu/ray_soumya/mlrg/optimality_of_nb.pdf)  

Why isn't Naive Bayes so naive?
It turns other that
when  dependancies exist between attributes, then they alter the decision boundary by some
amount &Epsilon;. 
[Domingos and Pazzani](http://engr.case.edu/ray_soumya/mlrg/optimality_of_nb.pdf)  have
shown that
As the number of dimensions grows,
then the hypervolume of these &Epsilons;s shrinks to a very small fraction  of the total
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

- `new = now * before`;  or, more formally, 
- `P( H|E ) = P( E|H ) * P(H)`  

To be precise, this expression should be  divided by 
_P(E)_; i.e. the probability of the evidence. But we never have to compute that since when
when  we ask "does H1 or H2 have most evidence", then we compute:
 _P( H1|E ) / P( H2|E )_. 
Since the probability of the 
evidence is the same across all hypothesis, then this _P(E)_ term
just cancels out (so we can ignore it).

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
  i.n = -1
}

Here is the `Nb` training function, suitable for updating
the payoad `i` from row number `r` 
(which contains the data found in `lst`).
In this function, if we have not seen a row of this class before,
we create a new table for that class.
After that, we update the statistics in 

- the `all` table;
- as well as the table for  this row's class.

# new class has to clone from old

function NbTrain(i,r,lst,   class) {
  Tbl1(i.all,r,lst)
  if(r>1) {
    i.n++
    class = lst[ i.all.my.class ]
    NbEnsureClassExists(i, class) 
    Tbl1(i.things[class], r,lst)
  }
}

function NbEnsureClassExists(i,class,   head) {
  if (! (class in i.things)) {
    has1(i.things, class, "Tbl",1)
    TblHeader(i.all, head)
    Tbl1(i.things[class],1,head)
  }
}
 
Here is the `Nb` classification function, that uses the payload
`i` to guess the class of row number `r`
(which contains the data found in `lst`).
To do this,  we find the  class' table that `like`s this
row the most (i.e. whose rows are most similar to `lst`).

function NbClassify(i,r,lst,    most,class,like,guess) {
  most = -10^64
  for(class in i.things) {
    like = bayestheorem( i, lst, i.n, 
                                length(i.things), 
                                i.things[class])
    if (like > most) {
      most  = like
      guess = class
  }}
  return guess
}

The `bayestheorem` functionReturns `P( E|H ) * P(H)` where:

- `P(H)` is the prior probaility of this class,
i.e. the ratio of how often it apears in the data;
- `P( E|H )` is calcualted by multiplying together the probability
that the value in `row` column `c` belongs to the distribution seen  in column `c`.

function bayestheorem(i,lst,nall,nthings,thing,    like,prior,c,x,inc) {
    like = prior = (length(thing.rows)  + i.k) / (nall + i.k * nthings)
    like = log(like)
    for(c in thing.my.xs) {
      x = lst[c]
      if (x == SKIPCOL) continue
      if (c in thing.my.nums)
        like += log( NumLike(thing.cols[c], x) )
      else
        like += log( SymLike(thing.cols[c], x, prior, i.m) )
    }
    return like
}

Note that:

- [NumLike](num.md#like) computes the likelihood by assuming the column data comes from a normal bell curve;
- [SymLike](sym.md#like) computes the likelihood by assuming the column data comes from a histogram
  of discrete values.
- Instead of multiplying probabilities, this code adds the logs of those numbers.
  This is a numerical methods trick that can assist with mutliplying together very small numbers.
- This code skips over cells with unknown values (i.e. those that match `SKIPCOL`).
- Also, the `i.k` and `nthings` variables are used to handle low freqeuncy data 
  (in the manner recommended by 
  [Yang et al.](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.72.8235&rep=rep1&type=pdf)). 


