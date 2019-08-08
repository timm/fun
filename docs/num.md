---
title: num.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# num.fun
```awk
@include "funny"
@include "col"
```

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0]^-[Num|mu = 0; m2 = 0; lo; hi| Num1(); NumNorm();NumLess();NumAny()]">

`Num` incrementally  maintains the mean and standard deviation of
the numbers seen in a column.

```awk
function Num(i,c,v) {
  Col(i,c,v)
  i.n  = i.mu = i.m2 = i.sd = 0
  i.lo = 10^32 
  i.hi = -1*i.lo
  i.add ="Num1" 
}
function Num1(i,v,    d) {
  v += 0
  i.n++
  i.lo  = v < i.lo ? v : i.lo
  i.hi  = v > i.hi ? v : i.hi
  d     = v - i.mu
  i.mu += d/i.n
  i.m2 += d*(v - i.mu)
  i.sd  = NumSd0(i)
  return v
}
```

```awk
function NumSd0(i) {
  if (i.m2 < 0) return 0
  if (i.n < 2)  return 0
  return  (i.m2/(i.n - 1))^0.5
}
```

Also maintained is the lowest and highest number seen so far. With
that information we can normalize numbers zero to one.

```awk
function NumNorm(i,x) {
  return (x - i.lo) / (i.hi - i.lo + 10^-32)
}
```

If done carefully, it is also possible to incrementally decrement
these numbers.  Be wary of using the following when `i.n` is less
than, say, 5 to 10 and the total sum of the remaining numbers is
small.

```awk
function NumLess(i,v, d) {
  if (i.n < 2) {i.sd=0; return v}
  i.n  -= 1
  d     = v - i.mu
  i.mu -= d/i.n
  i.m2 -= d*(v - i.mu)
  i.sd  = NumSd0(i)
  return v
}
```

To sample from `Num`, we assume that its numbers are like a a normal
bell-shaped curve. If so,  then the [Box Muller
](https://people.maths.ox.ac.uk/gilesm/mc/mc/lec1.pdf) can do the
sampling:

```awk
function NumAny(i,  z) { 
  z = sqrt(-2*log(rand()))*cos(6.2831853*rand())
  return i.m + i.sd * z 
}
```
