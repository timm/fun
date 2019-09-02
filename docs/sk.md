---
title: sk.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# sk.fun

## Non-parametric comparisons of numerics.

Uses:  "[funny](funny)"<br>
Uses:  "[nums](nums)"<br>

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Array1]-.-[note: sk(){bg:cornsilk}]]-.-[Array2]">

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

```awk
   1.  function distinct(lst1,lst2) {
   2.     return cliffsDelta(lst1,lst2) && bootstrap(lst1,lst2)
   3.  }
```

### Cliff's Delta

Cliff's delta tells us if numbers from one list are outliers in the other.
This is a non-parametric _effect size test_ that two distributions `a1,a2` are not trivially different.

```awk
   4.  function cliffsDelta(a1,a2,
   5.                       a3, m,n,j,x,lo,hi,lt,gt,k) {
   6.    n= asort(a2, a3)
   7.    for(k in a1) {
   8.      x= a1[k]
   9.      lo= hi= bsearch(a3,x,1)
  10.      while(lo >= 1 && a3[lo] >= x) lo--
  11.      while(hi <= n && a3[hi] <= x) hi++
  12.      lt += n - hi + 1
  13.      gt += lo 
  14.    }
  15.    m = length(a1)*length(a2)
  16.    return abs(gt - lt) / m > THE.sk.cliffs
  17.  }
```


From Chapter 16 of [Efron's text](REFS#efron-1993) on bootstrapping.

To determine if two distributions are different, first we define some
test statistic.

```awk
  18.  function testStatistic(i,j) { 
  19.     return abs(j.mu - i.mu) / (i.sd/i.n + j.sd/j.n )^0.5 }
  20.  
  21.  Then, many times, we see if this test statistic holds
  22.  across many samples of the two distributions.
  23.  Here's how we build one such sample (and note that this is "sample with replacement"; i.e
  24.  the same thing can come back multiple times):
  25.  
  26.  function sample(a,b,w) { for(w in a) b[w] = a[any(a)] }
  27.  
  28.  Here's the code that does the multiple sampling. Technical, this is known as a bootstrap test.
  29.  First we find a `baseline`; i.e. wahat does the test statistic look like for the two distributions.
  30.  Next, Efron recommends
  31.  transforming  the two distrbutions `y0,z0` into
  32.  some comparaiable (by making them both have the same mean-- see the `yhat` and `zhat` distributions).
  33.  After that, we count how often we are surprised (we see something larger than the `baseline`).
  34.  
  35.  
  36.  
  37.  function bootstrap(y0,z0,   
  38.                    x,y,z,baseline,w,b,yhat,zhat,y1,z1,ynum,znum,strange) {
  39.    nums(x,y0)
  40.    nums(x,z0)
  41.    nums(y,y0)
  42.    nums(z,z0)
  43.    baseline = testStatistic(y,z)
  44.    for(w in y0) yhat[w]= y0[w]- y.mu + x.mu 
  45.    for(w in z0) zhat[w]= z0[w]- z.mu + x.mu 
  46.    b = THE.sk.b
  47.    for(w=1; w<=b; w++) { 
  48.      sample(yhat, y1) 
  49.      nums(ynum,   y1)
  50.      sample(zhat, z1) 
  51.      nums(znum,   z1)
  52.      strange +=  testStatistic(ynum,znum) >=  baseline
  53.    }
  54.    return strange / b < THE.sk.conf / 100
  55.  }
```

```awk
  56.  BEGIN{rogues()}
```
