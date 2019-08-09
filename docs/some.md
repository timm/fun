---
title: some.fun
---

 [about](/fun/ABOUT) |   [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<br>

# some.fun


<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0]^-[Some|most = 256; sorted = 0|Some1(); SomeAny();SomeMedian();SomeIQR();SomeDiff();]">


`Some` is a reservoir sampler; i.e. is a method for  randomly keep
a sample of items from a list containing items, where is either a
very large or unknown number.

Uses:  "[funny](funny)"<br>
Uses:  "[the](the)"<br>

```awk
   1.  function Some(i,c,v,     most) {
   2.    Col(i,c,v)
   3.    i.most= most ? most : THE.some.most 
   4.    has(i,"cache")             # i.cache holds the kept value
   5.    i.sorted=0
   6.    i.add="Some1"
   7.  }
```

When adding something, if full, replace anything at random.
Else, just add it. And if ever we add something, remember
that we may not be sorted anymore.

```awk
   8.  function Some1(i,v,    m) {
   9.    i.n++
  10.    m = length(i.cache)
  11.    if (m < i.most) {  # the cache is not full, add something
  12.      i.sorted = 0
  13.      return push(i.cache,v)
  14.    }
  15.    if (rand() < m/i.n) {   # else, sometimes, add "v"
  16.      i.sorted = 0
  17.      return i.cache[ int(m*rand()) + 1 ] = v
  18.    }
  19.  }
```

To sample from this distribution, just pull anything at random.

```awk
  20.  function SomeAny(i,  m) {
  21.     m= length(i.cache)
  22.     return i.cache[ int(m*rand()) + 1 ]
  23.  }
```

To compute median, ensure we are first sorted.

```awk
  24.  function SomeMedian(i) {
  25.    if (!i.sorted) i.sorted = asort(i.cache)
  26.    return median(i.cache)
  27.  }
```

IQR is the inter-quartile range and is the difference between the
75th and 25 percentile.

```awk
  28.  function SomeIQR(i,   m) {
  29.    if (!i.sorted) i.sorted = asort(i.cache)
  30.    m = int(length(i.cache)/4)
  31.    return i.cache[3*m] - i.cache[m]
  32.  }   
```


