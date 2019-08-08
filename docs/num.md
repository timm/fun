---
title: num.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# num.fun
```awk
   1.  @include "funny"
   2.  @include "col"
```

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0]^-[Num|mu = 0; m2 = 0; lo; hi| Num1(); NumNorm();NumLess();NumAny()]">

`Num` incrementally  maintains the mean and standard deviation of
the numbers seen in a column.

```awk
   3.  function Num(i,c,v) {
   4.    Col(i,c,v)
   5.    i.n  = i.mu = i.m2 = i.sd = 0
   6.    i.lo = 10^32 
   7.    i.hi = -1*i.lo
   8.    i.add ="Num1" 
   9.  }
```

The slow way to compute standard deviation is to run over the data
in two passes. In pass1, we find the mean, then in pass2 you look
for the difference of everything else to the mean; i.e.
_sqrt(&sum;(x-&mu;)^2/(n-1))_.  The following code does the same
thing, in one pass using 
[Welford's on-line algorithm](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm):

```awk
  10.  function Num1(i,v,    d) {
  11.    v += 0
  12.    i.n++
  13.    i.lo  = v < i.lo ? v : i.lo
  14.    i.hi  = v > i.hi ? v : i.hi
  15.    d     = v - i.mu
  16.    i.mu += d/i.n
  17.    i.m2 += d*(v - i.mu)
  18.    i.sd  = _NumSd(i)
  19.    return v
  20.  }
```

```awk
  21.  function _NumSd(i) {
  22.    if (i.m2 < 0) return 0
  23.    if (i.n < 2)  return 0
  24.    return  (i.m2/(i.n - 1))^0.5
  25.  }
```

`Num` also maintains is the lowest and highest number seen so far. With
that information we can normalize numbers zero to one.

```awk
  26.  function NumNorm(i,x) {
  27.    return (x - i.lo) / (i.hi - i.lo + 10^-32)
  28.  }
```

If done carefully, it is also possible to incrementally decrement
these numbers.  Be wary of using the following when `i.n` is less
than, say, 5 to 10 and the total sum of the remaining numbers is
small.

```awk
  29.  function NumLess(i,v, d) {
  30.    if (i.n < 2) {i.sd=0; return v}
  31.    i.n  -= 1
  32.    d     = v - i.mu
  33.    i.mu -= d/i.n
  34.    i.m2 -= d*(v - i.mu)
  35.    i.sd  = _NumSd(i)
  36.    return v
  37.  }
```

To sample from `Num`, we assume that its numbers are like a a normal
bell-shaped curve. If so,  then the [Box Muller
](https://people.maths.ox.ac.uk/gilesm/mc/mc/lec1.pdf) can do the
sampling:

```awk
  38.  function NumAny(i,  z) { 
  39.    z = sqrt(-2*log(rand()))*cos(6.2831853*rand())
  40.    return i.m + i.sd * z 
  41.  }
```
