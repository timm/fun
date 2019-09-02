---
title: num.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# num.fun
## Summarize numeric columns.

Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>
Uses:  "[nums](nums)"<br>

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0]^-[Num|mu = 0; m2 = 0; lo; hi| Num1(); NumNorm();NumLess();NumAny()]">

`Num` incrementally  maintains the mean and standard deviation of
the numbers seen in a column.

```awk
   1.  function Num(i,c,v) {
   2.    Col(i,c,v)
   3.    i.n  = i.mu = i.m2 = i.sd = 0
   4.    i.lo = 10^32 
   5.    i.hi = -1*i.lo
   6.    i.add ="Num1" 
   7.  }
```

The slow way to compute standard deviation is to run over the data
in two passes. In pass1, we find the mean, then in pass2 you look
for the difference of everything else to the mean; i.e.
_sqrt(&sum;(x-&mu;)^2/(n-1))_.  The following code does the same
thing, in one pass using 
[Welford's on-line algorithm](https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm):

```awk
   8.  function Num1(i,v,    d) {
   9.    v += 0
  10.    i.n++
  11.    i.lo  = v < i.lo ? v : i.lo
  12.    i.hi  = v > i.hi ? v : i.hi
  13.    d     = v - i.mu
  14.    i.mu += d/i.n
  15.    i.m2 += d*(v - i.mu)
  16.    i.sd  = _NumSd(i)
  17.    return v
  18.  }
```

```awk
  19.  function _NumSd(i) {
  20.    if (i.m2 < 0) return 0
  21.    if (i.n < 2)  return 0
  22.    return  (i.m2/(i.n - 1))^0.5
  23.  }
```

`Num` also maintains is the lowest and highest number seen so far. With
that information we can normalize numbers zero to one.

```awk
  24.  function NumNorm(i,x) {
  25.    return (x - i.lo) / (i.hi - i.lo + 10^-32)
  26.  }
```

If done carefully, it is also possible to incrementally decrement
these numbers.  Be wary of using the following when `i.n` is less
than, say, 5 to 10 and the total sum of the remaining numbers is
small.

```awk
  27.  function NumLess(i,v, d) {
  28.    if (i.n < 2) {i.sd=0; return v}
  29.    i.n  -= 1
  30.    d     = v - i.mu
  31.    i.mu -= d/i.n
  32.    i.m2 -= d*(v - i.mu)
  33.    i.sd  = _NumSd(i)
  34.    return v
  35.  }
```

To sample from `Num`, we assume that its numbers are like a a normal
bell-shaped curve. If so,  then the [Box Muller
](https://people.maths.ox.ac.uk/gilesm/mc/mc/lec1.pdf) can do the
sampling:

```awk
  36.  function NumAny(i) { 
  37.    return i.m + i.sd * z()
  38.  }
```

```awk
  39.  function z() {
  40.    return sqrt(-2*log(rand()))*cos(6.2831853*rand())
  41.  
  42.  }
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

Here's a convenience function to load all the numbers of an array 
`a` into a `Num`. 

```awk
  49.  function nums(n,a,   x,    v,i) {
  50.    if (!isarray(n)) # if n is not already a Num..
  51.      Num(n)         # ... then make it a num
  52.    for(i in a)  {
  53.      v= x ? a[i][x] : a[i]
  54.      if (v != "?") Num1(n, v) }
  55.  }
```


`Num`s can also report how much they "like" some number `x`, by assuming it is drawn from some
normal bell-shapped curve (all we need do is report the height of that curve at `x`).

```awk
  56.  function NumLike(i,x,      var,denom,num) {
  57.    var   = i.sd^2
  58.    denom = (3.14159*2*var)^.5
  59.    num   =  2.71828^(-(x-i.mu)^2/(2*var))
  60.    return num/denom
  61.  }
```

