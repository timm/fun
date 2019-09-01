#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- --


## Reservoir sampling (only get some of the data).

#!class [Col|n = 0]^-[Some|most = 256; sorted = 0|Some1(); SomeAny();SomeMedian();SomeIQR();SomeDiff();]


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

The 

function SomeKS(i,j, 
               d,d1,d2,dt,en1,en2,en,fn1,fn2,k1,k2,n1,n2) {
  if (!i.sorted) i.sorted = asort(i.cache)
  if (!j.sorted) j.sorted = asort(j.cache)
  n1= length(i.cache)
  n2= length(j.cache)   
  en1=n1;
  en2=n2;
  d=0.0;
  k1=k2=1
  while (k1 <= n1 && k2 <= n2) {
    if ((d1=i.cache[k1]) <= (d2=j.cache[k2])) {
      do {
        fn1=k1/en1;
        k1++
      } while (k1 <= n1 && d1 == i.cache[k1]);
    }
    if (d2 <= d1) {
      do  {
        fn2=k2/en2;
        k2++
      } while (k2 <= n2 && d2 == j.cache[k2]);
    }
    if ((dt=abs(fn2-fn1)) > d) d=dt;
  }
  en=sqrt(en1*en2/(en1+en2));
  return SomeProbks(2.718281828, 0.001, 10^-8,
                    (en+0.12+0.11/en)*d) <= (1-THE.some.ks/100)
}

function SomeProbks(e,eps1,eps2,alam,    a2,fac,sum,term,termbf,j) {
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
