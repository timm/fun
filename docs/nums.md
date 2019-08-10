---
title: nums.fun
---

<button class="button"><a href="/fun/ABOUT">about></a></button>   <button class="button1"><a href="http://github.com/timm/fun/issues">discuss></a></button>    <button class="button2"><a href="/fun/license">license</a></button> <br>



# nums.fun
Uses:  "[funny](funny)"<br>
Uses:  "[num](num)"<br>
Uses:  "[the](the)"<br>

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Nums]1-2[Num],[Nums]-.-[note: v.fast comparison two Nums (assumes normal bell-shaped curves){bg:cornsilk}]">

To test if two distributions are different, there are some methods
that are somewhat slow, but very thorough (and these methods are
"nonparametric"; i.e. they do not make any (potentially silly)
assumptions about the shaper of the data).  If you are going to
publish results (say, in the SE literature), you need to use those
thorough methods to check your final conclusions[^slow].

[^slow]: There are many such methods but I recommend Scott-Knot with bootstrapping and Cliff's Delta.

That said, deep in guts of an inference procedure, you often need
a fast heuristic peek at a distribution  to quickly decide if they
seem difference. This page describes two such methods (and it recommended that you use this both
as a conjunction):

- The  ttest for significant differences in distributions;
- The hedges test for small effects.

Using these tests, two distributions "_x_" and "_y_" are different
if they are not significantly different and have differences larger
than a small effect.

```awk
   1.  function diff(x,y,      s) { 
   2.    Nums(s)
   3.    return ttest(x,y,s) && hedges(x,y,s)  
   4.  }
```

First, some theory. Consider the following two normal bell-shaped
curves. The wider curve has a larger standard deviation. Their mean
values occur at different places so, at first glance, they look
different.

![](https://miro.medium.com/max/700/1*knCUJJjFHW92ec8d8iq4kQ.png)

But if we picked one value from each distribution, what are the
odds that we will _not_ the same value (i.e.  that the value is not
found in both distributions).  If there was no overlap in the two
distibutions, then those odds are zero. But these curves overlap
so we need some rules to decide those odds.  Given two `Num` objects
"_x_" and "_y_" then:

- _MeanFX_ = the mean effect.
  The larger the mean difference, the higher the odds 
  that the distrbutions are different.
- _SdFX_ = the standard deviation effect.
  The larger the standard deviations, the lower those 
  odds (since there is more overlap). Note that the _SdFx_
  interacts with the enxt effect.
- _SampleFX_ = the sample size effect.
   The largeer the sampel size, the less worried we are 
   that the standard deviation will confuse us. So
   large sample sizes mitigate for _SdFX_.

The standard way to apply these rules is the following ttest test
for significant differences. Note thats Othe _MeanFx_
is in the numerator (top part of the fraction) so large increases
in the mean difference makes "different" more likely. Also, the
_SdFX_ effect, mitigated by the _SampleFX_, are where they should be;
i.e. in  the denominator
(bottom part of the fraction).

- Other= `(abs(x.mu-y.mu) / sqrt(x.sd^2/s.n+y.sd^2/y.n) >  T` 

where  "_T_" is some threshold that we show how to calculate, below.
In this equation, "other" is more likely the larger
the mean difference or the larger the sample size.  Also, larger
standard deviations will reduce that likelihood (since it is on the
bottom of the fraction).

The ttest just reports the odds that the distributions are different.
But what if that difference is trivially small?

- To gaurd against spurious decisions, it is good practice
  to pair a ttest with some test for small effects. 
- Once again, there are slow and thorough ways to test
  for small effects and there are faster ways that cheat 
  (a lot) and assume a normal bell-shaped curve.
- For example, the following code offers the "hedges" 
  test that uses `Num` objects to impelement a very fast
  test for small effects. 
- For an even faster, and much less thorough test,
  use Cohen's rule which says anything smaller
  that 30 percent of the  standard deviation is small effect.

The comparison process is controlled by a `Nums` object that defines
a set of tthresholds. Increasing the `conf`idence
from 95 to 99 makes it harder to prove things are different (and
95 is the usual conference level).

```awk
   5.  function Nums(i) {
   6.    Object(i)
   7.    i.conf  = THE.nums.ttest  # selects the threshold for ttest
   8.    i.small = THE.nums.hedges # threshold for effect size test. 
   9.    # Thresholds for ttests at two different confidence levels
  10.    # -- 95% --------------------------
  11.    i[95][ 3]= 3.182; i[95][ 6]= 2.447; 
  12.    i[95][12]= 2.179; i[95][24]= 2.064; 
  13.    i[95][48]= 2.011; i[95][96]= 1.985; 
  14.    # -- 99% --------------------------
  15.    i[99][ 3]= 5.841; i[99][ 6]= 3.707; 
  16.    i[99][12]= 3.055; i[99][24]= 2.797; 
  17.    i[99][48]= 2.682; i[99][96]= 2.625; 
  18.    i.first = 3  # must be the smallest index of the above arrays
  19.    i.last  = 96 # must be the last     index of the above arrays
  20.  }
```

Here's the test for "larger than a small effect":

```awk
  21.  function hedges(x,y,s,   nom,denom,sp,g,c) {
  22.    # from http://tiny.cc/fxsize
  23.    nom   = (x.n - 1)*x.sd^2 + (y.n - 1)*y.sd^2
  24.    denom = (x.n - 1)        + (y.n - 1)
  25.    sp    = sqrt( nom / denom )
  26.    g     = abs(x.mu - y.mu) / sp  
  27.    c     = 1 - 3.0 / (4*(x.n + y.n - 2) - 1)
  28.    return g * c > s.small
  29.  }
```

Here's the test for significanct difference:

```awk
  30.  function ttest(x,y,s,    t,a,b,df,c) {
  31.    # debugged using https://goo.gl/CRl1Bz
  32.    t  = abs(x.mu - y.mu) / sqrt(max(10^-64,
  33.                                  x.sd^2/x.n + y.sd^2/y.n ))
  34.    a  = x.sd^2/x.n
  35.    b  = y.sd^2/y.n
  36.    df = (a + b)^2 / (10^-64 + a^2/(x.n-1) + b^2/(y.n - 1))
  37.    c  = ttest1(s, int( df + 0.5 ), s.conf)
  38.    return abs(t) > c
  39.  }
```

The following is a minor detail. It  is a 
worker function that extrapolates threshold
values for the test based on degrees of freedom `df` and the specificed
confidence level. 

```awk
  40.  function ttest1(s,df,conf,   n1,n2,old,new,c) {
  41.    if (df < s.first) 
  42.      return s[conf][s.first]
  43.    for(n1 = s.first*2; n1 < s.last; n1 *= 2) {
  44.      n2 = n1*2
  45.      if (df >= n1 && df <= n2) {
  46.        old = s[conf][n1]
  47.        new = s[conf][n2]
  48.        return old + (new-old) * (df-n1)/(n2-n1)
  49.    }}
  50.    return s[conf][s.last]
  51.  }
```

## Further Reading:

The above Hedges test (and its thresholds) come from 
[Kampenes el al.](REFS#kampenes-2007).

For more thorough methods to test if distrbutions are different,
or to check for large effect sizes, see bootstrapping and Cliff's
Delta (discussed later).


## Notes

