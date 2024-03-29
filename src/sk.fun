#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :


## Non-parametric comparisons of numerics.

@include "funny"
@include "nums"

#!class [Array1]-.-[note: sk(){bg:cornsilk}]]-.-[Array2]

Two lists of numbers `lst1,lst2` are different if they are:

- Statistically indistinguisable (which is the test for statistically significant differences);
- They are not different by merely a trivially small amount (which is the effect size test).

If we make a _parametric assumption_ that the distributions a normal bell curve, then we can perform
these two steps using a a [t-test](nums#ttest) (for significant differences) and a 
[Hedge's tes](nums#hedges) (for small effects).

But 
that parametric assumption often raise red flags. Shown below are statistical tests that do not assume normal bell curves.

- Note that these _nonparametric tests_ can be slower (in particular, the `bootstrap` test). 
- So if you need to do some
test many times during a search, then from a pragmatic perspective,
it is best to use 
the  [t-test](nums#ttest) and the
[Hedge's test](nums#hedges). 
- But when making some final assessment about the overall benefits associated
with some treatments, use the following `bootstrap` and `cliffsDelta` tests.

function distinct(lst1,lst2) {
   return cliffsDelta(lst1,lst2) && bootstrap(lst1,lst2)
}

### Cliff's Delta

Cliff's delta tells us if numbers from one list are outliers in the other.
This is a non-parametric _effect size test_ that two distributions `a1,a2` are not trivially different.

function cliffsDelta(a1,a2,
                     a3, m,n,j,x,lo,hi,lt,gt,k) {
  n= asort(a2, a3)
  for(k in a1) {
    x= a1[k]
    lo= hi= bsearch(a3,x,1)
    while(lo >= 1 && a3[lo] >= x) lo--
    while(hi <= n && a3[hi] <= x) hi++
    lt += n - hi + 1
    gt += lo 
  }
  m = length(a1)*length(a2)
  return abs(gt - lt) / m > THE.sk.cliffs
}

### Bootstrap

_(From Chapter 16 of [Efron's text](REFS#efron-1993) on bootstrapping.)_

To check if two distributions are statistically significantly
different (without making any parametric assumptions),
first we define some
test statistic.

function testStatistic(i,j) { 
  return abs(j.mu - i.mu) / (i.sd/i.n + j.sd/j.n )^0.5 
}

Then, many times, we see if this test statistic holds across many
samples of the two distributions.  Here's how we build one such
sample (and note that this is "sample with replacement"; i.e the
same thing can come back multiple times):

function sample(a,b,w) { for(w in a) b[w] = a[any(a)] }

Here's the code that does the multiple sampling. Technical, this
is known as a bootstrap test.  

function bootstrap(y0,z0,   
                  x,y,z,baseline,w,b,yhat,zhat,
                  y1,z1,ynum,znum,strange) {
  nums(x,y0)
  nums(x,z0)
  nums(y,y0)
  nums(z,z0)
  baseline = testStatistic(y,z)
  for(w in y0) yhat[w]= y0[w]- y.mu + x.mu 
  for(w in z0) zhat[w]= z0[w]- z.mu + x.mu 
  b = THE.sk.b
  for(w=1; w<=b; w++) { 
    sample(yhat, y1) 
    nums(ynum,   y1)
    sample(zhat, z1) 
    nums(znum,   z1)
    strange +=  testStatistic(ynum,znum) >=  baseline
  }
  return strange / b < THE.sk.conf / 100
}

In this code, first we find a `baseline`; i.e.
what does the test statistic look like for the two distributions.
Next, Efron recommends transforming  the two distrbutions `y0,z0`
into some comparaiable (by making them both have the same mean--
see the `yhat` and `zhat` distributions).  After that, we count how
often samples of the data  surprised us (i.e. we see something
larger than the `baseline`).

- If we often see something larger than the baseline.
- Then this test reports that the two lists of numbers are different.

