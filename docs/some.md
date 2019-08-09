---
title: some.fun
---

[index](/fun/index) :: [about](/fun/ABOUT) ::  [code](http://github.com/timm/fun) ::  [discuss](http://github.com/timm/fun/issues) :: [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# some.fun


<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0]^-[Some|most = 256; sorted = 0|Some1(); SomeAny();SomeMedian();SomeIQR();SomeDiff();]">


`Some` is a reservoir sampler; i.e. is a method for  randomly keep
a sample of items from a list containing items, where is either a
very large or unknown number.

```awk
   1.  @include "funny"
   2.  @include "the"
```

```awk
   3.  function Some(i,c,v,     most) {
   4.    Col(i,c,v)
   5.    i.most= most ? most : THE.some.most 
   6.    has(i,"cache")             # i.cache holds the kept value
   7.    i.sorted=0
   8.    i.add="Some1"
   9.  }
```

When adding something, if full, replace anything at random.
Else, just add it. And if ever we add something, remember
that we may not be sorted anymore.

```awk
  10.  function Some1(i,v,    m) {
  11.    i.n++
  12.    m = length(i.cache)
  13.    if (m < i.most) {  # the cache is not full, add something
  14.      i.sorted = 0
  15.      return push(i.cache,v)
  16.    }
  17.    if (rand() < m/i.n) {   # else, sometimes, add "v"
  18.      i.sorted = 0
  19.      return i.cache[ int(m*rand()) + 1 ] = v
  20.    }
  21.  }
```

To sample from this distribution, just pull anything at random.

```awk
  22.  function SomeAny(i,  m) {
  23.     m= length(i.cache)
  24.     return i.cache[ int(m*rand()) + 1 ]
  25.  }
```

To compute median, ensure we are first sorted.

```awk
  26.  function SomeMedian(i) {
  27.    if (!i.sorted) i.sorted = asort(i.cache)
  28.    return median(i.cache)
  29.  }
```

IQR is the inter-quartile range and is the difference between the
75th and 25 percentile.

```awk
  30.  function SomeIQR(i,   m) {
  31.    if (!i.sorted) i.sorted = asort(i.cache)
  32.    m = int(length(i.cache)/4)
  33.    return i.cache[3*m] - i.cache[m]
  34.  }   
```


