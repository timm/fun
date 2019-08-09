---
title: num.fun
---

[index](/fun/index) :: [about](/fun/ABOUT) ::  [code](http://github.com/timm/fun) ::  [discuss](http://github.com/timm/fun/issues) :: [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# num.fun
```awk
   1.  @include "funny"
   2.  @include "col"
   3.  @include "nums"
```

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0]^-[Num|mu = 0; m2 = 0; lo; hi| Num1(); NumNorm();NumLess();NumAny()]">

`Num` incrementally  maintains the mean and standard deviation of
the numbers seen in a column.

```awk
   4.  function Num(i,c,v) {
   5.    Col(i,c,v)
   6.    i.n  = i.mu = i.m2 = i.sd = 0
   7.    i.lo = 10^32 
   8.    i.hi = -1*i.lo
   9.    i.add ="Num1" 
  10.  }
```

The slow way to compute standard deviation is to run over the data
in two passes. In pass1, we find the mean, then in pass2 you look
for the difference of everything else to the mean; i.e.
_sqrt(&sum;(x-&mu;)^2/(n-1))_.  The following code does the same
thing, in one pass using 
[Welford's on-line algorithm](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm):

```awk
  11.  function Num1(i,v,    d) {
  12.    v += 0
  13.    i.n++
  14.    i.lo  = v < i.lo ? v : i.lo
  15.    i.hi  = v > i.hi ? v : i.hi
  16.    d     = v - i.mu
  17.    i.mu += d/i.n
  18.    i.m2 += d*(v - i.mu)
  19.    i.sd  = _NumSd(i)
  20.    return v
  21.  }
```

```awk
  22.  function _NumSd(i) {
  23.    if (i.m2 < 0) return 0
  24.    if (i.n < 2)  return 0
  25.    return  (i.m2/(i.n - 1))^0.5
  26.  }
```

`Num` also maintains is the lowest and highest number seen so far. With
that information we can normalize numbers zero to one.

```awk
  27.  function NumNorm(i,x) {
  28.    return (x - i.lo) / (i.hi - i.lo + 10^-32)
  29.  }
```

If done carefully, it is also possible to incrementally decrement
these numbers.  Be wary of using the following when `i.n` is less
than, say, 5 to 10 and the total sum of the remaining numbers is
small.

```awk
  30.  function NumLess(i,v, d) {
  31.    if (i.n < 2) {i.sd=0; return v}
  32.    i.n  -= 1
  33.    d     = v - i.mu
  34.    i.mu -= d/i.n
  35.    i.m2 -= d*(v - i.mu)
  36.    i.sd  = _NumSd(i)
  37.    return v
  38.  }
```

To sample from `Num`, we assume that its numbers are like a a normal
bell-shaped curve. If so,  then the [Box Muller
](https://people.maths.ox.ac.uk/gilesm/mc/mc/lec1.pdf) can do the
sampling:

```awk
  39.  function NumAny(i,  z) { 
  40.    z = sqrt(-2*log(rand()))*cos(6.2831853*rand())
  41.    return i.m + i.sd * z 
  42.  }
```

```awk
  43.  function NumAnyT(i) { # Another any, assumes a triangle distribution
  44.    return triangle(i.lo, i.mu, i.hi)
  45.  }
```

Here, we check if two `Num`s are significantly different
and differ by mroe than a small effect:

```awk
  46.  function NumDiff(i,j) {
  47.    return diff(i,j) # defined in "Nums"
  48.  }
```

Here's a convenience function to load all the numbers of an array into a `Num`.

```awk
  49.  function nums(n,a,    i) {
  50.    if (!isarray(n)) 
  51.     Num(n)
  52.    for(i in a)
  53.      if (a[i] != "?") 
  54.       Num1(n, a[i])
  55.  }
```


