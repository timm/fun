---
title: nums.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# nums.fun
```awk
   1.  @include "funny"
   2.  @include "num"
   3.  @include "the"
```

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Nums]1-2[Num],[Nums]-.-[note: v.fast comparison two Nums (assumes normal bell-shaped curves){bg:cornsilk}]">

To test if two distributions are different, there are some methods
that are somewhat slow, but very thorough (and these methods are "nonparametric"; i.e. they do not make
any (potentially silly) assumptions about the shaper of the data).  If you are going to publish results
(say, in the SE literature), you need to use those thorough methods to check your final conclusions[^slow].

[^slow]: There are many such methods but I recommend Scott-Knot with bootstrapping and Cliff's Delta.

That said, deep in guts of an inference procedure, you often need a fast heuristic way to peek at
a distribution  to decide if they seem difference. This page describes two such methods:

- The  ttest for significant differences in distributions;
- The hedges test for small effects.

Using these tests, two distributions "_x_" and "_y_"
are different if they are not significantly different and
have differences larger than a small effect.

```awk
   4.  function diff(x,y,      s) { 
   5.    Nums(s)
   6.    return hedges(x,y,s) && ttest(x,y,s)
   7.  }
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
so we need some rules to decide those odds:

- _MeanFX_ = the mean effect.
  The larger the mean difference, the higher the odds 
  that the distrbutions are different;
- _SdFX_ = the standard deviation effect.
  The larger the standard deviations, the lower those 
  odds (since there is more overlap);
- _SampleFx_ = the sample size effect.
   If the sammple size is very large, then the 
  odds increase since we have more examples of these
  mean differences being actual differences.

The standard way to apply these rules is the following ttest test
for significant differences.
Given two `Num` objects "_x_" and "_y_" then:

        MeanFX           = abs(x.mu - y.mu)  
        SampleFX         = (x.n - 1) + (y.n - 1)        
        SdFX             = (x.n - 1)*x.sd^2 + (y.n - 1)*y.sd^2  
        TheyAreDifferent = MeanFX * sqrt(SampleFX/SdFX)  

In these equations, "they are different" is more certain the larger
the mean difference or the larger the sample size.  Also, larger
standard deviations will reduce that certainty (since it is on the
bottom of the fraction).

The ttest just reports the odds that the distributions are different.
But what if that difference is a trivially small amount?

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


The comparison process is controlled by a `Nums` object that holds
a whole bunch of magic variables. Increasing the `conf`idence
from 95 to 99 makes it harder to prove things are different (and
95 is the usual conference level).

```awk
   8.  function Nums(i) {
   9.    Object(i)
  10.    i.conf  = THE.nums.ttest  # selects the threshold for ttest
  11.    i.small = THE.nums.hedged # threshold for effect size test. 
  12.    # Thresholds for ttests at two different confidence levels
  13.    # -- 95% --------------------------
  14.    i[95][ 3]= 3.182; i[95][ 6]= 2.447; 
  15.    i[95][12]= 2.179; i[95][24]= 2.064; 
  16.    i[95][48]= 2.011; i[95][98]= 1.985; 
  17.    # -- 99% --------------------------
  18.    i[99][ 3]= 5.841; i[99][ 6]= 3.707; 
  19.    i[99][12]= 3.055; i[99][24]= 2.797; 
  20.    i[99][48]= 2.682; i[99][98]= 2.625; 
  21.    i.first = 3  # must be the smallest index of the above arrays
  22.    i.last  = 98 # must be the last     index of the above arrays
  23.  }
```

Here's the test for "larger than a small effect":

```awk
  24.  function hedges(x,y,s,   nom,denom,sp,g,c) {
  25.    # from http://tiny.cc/fxsize
  26.    nom   = (x.n - 1)*x.sd^2 + (y.n - 1)*y.sd^2
  27.    denom = (x.n - 1)        + (y.n - 1)
  28.    sp    = sqrt( nom / denom )
  29.    g     = abs(x.mu - y.mu) / sp  
  30.    c     = 1 - 3.0 / (4*(x.n + y.n - 2) - 1)
  31.    return g * c > s.small
  32.  }
```

Here's the test for significanct difference:

```awk
  33.  function ttest(x,y,s,    t,a,b,df,c) {
  34.    # debugged using https://goo.gl/CRl1Bz
  35.    t  = (x.mu - y.mu) / sqrt(max(10^-64,
  36.                                  x.sd^2/x.n + y.sd^2/y.n ))
  37.    a  = x.sd^2/x.n
  38.    b  = y.sd^2/y.n
  39.    df = (a + b)^2 / (10^-64 + a^2/(x.n-1) + b^2/(y.n - 1))
  40.    c  = ttest1(s, int( df + 0.5 ), s.conf)
  41.    print("c",c)
  42.    return abs(t) > c
  43.  }
```

The following is a minor detail. It  is a 
worker function that extrapolates threshold
values for the test based on degrees of freedom `df` and the specificed
confidence level. 

```awk
  44.  function ttest1(s,df,conf,   n1,n2,old,new,c) {
  45.    if (df < s.first) 
  46.      return s[conf][s.first]
  47.    for(n1 = s.first*2; n1 < s.last; n1 *= 2) {
  48.      n2 = n1*2
  49.      if (df >= n1 && df <= n2) {
  50.        old = s[conf][n1]
  51.        new = s[conf][n2]
  52.        return old + (new-old) * (df-n1)/(n2-n1)
  53.    }}
  54.    return s[conf][s.last]
  55.  }
```

## Further Reading:

The above Hedges test (and its thresholds) come from 
[Kampenes el al.](REFS#kampenes-2007).

For more thorough methods to test if distrbutions are different,
or to check for large effect sizes, see bootstrapping and Cliff's
Delta (discussed later).


## Notes

