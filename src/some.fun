#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- --


## Reservoir sampling (only get some of the data).

#!class [Col|n = 0]^-[Some|most = 256; sorted = 0|Some1(); SomeAny();SomeMedian();SomeIQR();SomeDiff();SomeKs();]


`Some` is a reservoir sampler; i.e. is a method for  randomly keep
a sample of items from a list containing items, where is either a
very large or unknown number.

@include "funny"
@include "the"

function Some(i,c,v,     most) {
  Col(i,c,v)
  i.most= most ? most : THE.some.most 
  has(i,"cache")             # i.cache holds the kept value
  i.sorted=0
  i.add="Some1"
}

When adding something, if full, replace anything at random.
Else, just add it. And if ever we add something, remember
that we may not be sorted anymore.

function Some1(i,v,    m) {
  i.n++
  m = length(i.cache)
  if (m < i.most) {  # the cache is not full, add something
    i.sorted = 0
    return push(i.cache,v)
  }
  if (rand() < m/i.n) {   # else, sometimes, add "v"
    i.sorted = 0
    return i.cache[ int(m*rand()) + 1 ] = v
  }
}

To sample from this distribution, just pull anything at random.

function SomeAny(i,  m) {
   m= length(i.cache)
   return i.cache[ int(m*rand()) + 1 ]
}

To compute median, ensure we are first sorted.

function SomeMedian(i) {
  if (!i.sorted) i.sorted = asort(i.cache)
  return median(i.cache)
}

IQR is the inter-quartile range and is the difference between the
75th and 25 percentile.

function SomeIQR(i,   m) {
  if (!i.sorted) i.sorted = asort(i.cache)
  m = int(length(i.cache)/4)
  return i.cache[3*m] - i.cache[m]
}   

## Compare two distributions

For normal distributions, we can test if they are different using
a [t-test](nums.md). For arbitary distributions, we cannot assume
normality and must compare distributions using another method.  The
Kolmogorov–Smirnov test is a nonparametric test of the equality of
two continuous one-dimensional probability distributions. We can
use it to compare two `Some`s by

- sorted the `cache` lists
- then using the two sorted lists as two probability distributions.


Intiatively, the KS compares  a cumulative distribution against
a reference distribution (in our case, a second distribution) and 
comments on the distance between them,

![](assets/img/ks101.png)

As to how that is computed, the following code comes from 
[Numerical Recipes in "C"](https://github.com/txt/ase19/blob/master/etc/img/NumericalRecipesinC.pdf),
section 14.3, pages 623 to 626.  The key variable here is the _supreme distance_ (denoted below as  `d`)
 which
is the largest y-value difference between the distributons found in `i.cache`
and `j.cache`.  
If the supreme distance is small, then the distributions are the same.

function SomeKS(i,j, 
               d,d1,d2,dt,ns,fn1,fn2,k1,k2,n1,n2) {
  if (!i.sorted) i.sorted = asort(i.cache)
  if (!j.sorted) j.sorted = asort(j.cache)
  n1= length(i.cache)
  n2= length(j.cache)   
  k1=k2=1
  while (k1 <= n1 && k2 <= n2) {
    if ((d1=i.cache[k1]) <= (d2=j.cache[k2])) {
      do {
        fn1=k1/n1;
        k1++
      } while (k1 <= n1 && d1 == i.cache[k1]);
    }
    if (d2 <= d1) {
      do  {
        fn2=k2/n2;
        k2++
      } while (k2 <= n2 && d2 == j.cache[k2]);
    }
    if ((dt=abs(fn2-fn1)) > d) d=dt;
  }
  ns=sqrt(n1*n2/(n1+n2));
  return _SomeProbks(2.718281828, 0.001, 10^-8,
           (ns+0.12+0.11/ns)*d) <= (1-THE.some.ks/100) 
}

The significance that `d` disproofs that the
distributions are the same is computed from the `SomeKS` function.
In the following, the _smaller_ the value returned from `SomeKS`,
the _more_ likely that the distributions are different.

function _SomeProbks(e,eps1,eps2,alam,    
                    a2,fac,sum,term,termbf,j) {
   fac=2   
   a2 = -2*alam*alam
   for(j=1;j<=100;j++) {
      term = fac*e^(a2*j*j)
      sum += term
      if (abs(term) <= eps1*termbf) return sum
      if (abs(term) <= eps2*sum)    return sum
      fac *= -1
      termbf = abs(term)
  }
  return 1
}
