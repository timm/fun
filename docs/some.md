---
title: some.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# some.fun

#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0]^-[Some|most = 256; sorted = 0|Some1(); SomeAny();SomeMedian();SomeIQR()]">


`Some` is a reservoir sampler; i.e. is a method for  randomly keep
a sample of items from a list containing items, where is either a
very large or unknown number.

```awk
@include "funny"
@include "the"
```

```awk
function Some(i,c,v,     most) {
  Col(i,c,v)
  i.most= most ? most : THE.some.most 
  has(i,"cache")             # i.cache holds the kept value
  i.sorted=0
  i.add="Some1"
}
```

When adding something, if full, replace anything at random.
Else, just add it. And if ever we add something, remember
that we may not be sorted anymore.

```awk
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
```

To sample from this distribution, just pull anything at random.

```awk
function SomeAny(i,  m) {
   m= length(i.cache)
   return i.cache[ int(m*rand()) + 1 ]
}
```

To compute median, ensure we are first sorted.

```awk
function SomeMedian(i) {
  if (!i.sorted) i.sorted = asort(i.cache)
  return median(i.cache)
}
```

IQR is the inter-quartile range and is the difference between the
75th and 25 percentile.

```awk
function SomeIQR(i,   m) {
  if (!i.sorted) i.sorted = asort(i.cache)
  m = int(length(i.cache)/4)
  return i.cache[3*m] - i.cache[m]
}   
```
