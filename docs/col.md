---
title: col.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# col.fun
```awk
@include "funny"
```

<img src="http://yuml.me/diagram/plain/class/[Col|txr;col;n = 0|Col1()]^-[Num|mu = 0;m2 = 0;sd = 0;lo = 0; hi = 0],[Col]^-[Sym|mode;most = 0;cnt:List]">

`Num` and `Sym`s keep summary statistics on `Col`umns in tables. 

## Col

```awk
function Col(i,c,v) { 
  Object(i)   
  i.n=0
  i.col=c
  i.txt=v 
} 
```

The generic add function ignroes anything that is a `"?"`. 

```awk
BEGIN {IGNORE="\\?"}
function Col1(i,v,   add) {
  if (v ~ IGNORE) return v
  add = i.add
  return @add(i,v)
} 
```

## Sym

The `Sym` class incrementally counts of the symbols seen in a column
as well as the most frequently seen symbol (the `mode`).

```awk
function Sym(i,c,v) { 
  Col(i,c,v)
  i.mode=""
  i.most=0
  has(i,"cnt") 
  i.add ="Sym1" 
}
function Sym1(i,v,  tmp) {
  i.n++
  tmp = ++i.cnt[v]
  if (tmp > i.most) {
    i.most = tmp
    i.mode = v }
  return v
}
```

Entropy is a measure of the variety of a set of systems.
One way to build a learner is to find splits in the data that most reduces
that variety (and then to recursively split divide each split).
Entropy is minimal (zero) when all the symbols  are the same. Otherwise,
given symbols at probability P1, P2, etc then entropy is calcuated[^ent] as follows 

- _&sum;-Px*log2(Px)_ 

Note that the analog  of entropy for continuous distributions is Standard deviation
(discussed below).

[^ent]: For an approximate justification for this formula,  consder a piece of string 10 meters long, stained in two places by a  meter of red and two metres of green. The probability of stumbling over those colors is Pr=0.1 and Pg=0.2, respectively. To measure the variety of the signal in that string, we could record the effort associated with reconstructing it (i.e. finding all its parts).  To that end, for each color, fold the string in half till oen color is isolated (which requires a number of folds that is approximately _log2(Px)_). Wehn the  probability of doing tose folds is  proportinal to the odds we'll look for that color, then the total effort is _Px*log2(Px)_ (which is repeated for all colors). Finally, by convention, we throw a minus sign around the summation.

```awk
function SymEnt(i,   p,e,k) {
  for(k in i.cnt) {
    p  = i.cnt[k]/i.n
    e -= p*log(p)/log(2)  # log(N)/log(2) is the same an log2(N)
  }
  return e
}
```

To sample symbols from this distribution, (1) pick a random number;
then (2) let every entry "eat" some portion of it;
and (3)
return the symbols found where there is nothing left to eat. Note that for distributions with many numbers,
it is useful to sort the ditionary of symbol counts in descending order (since, usually, the first items in that sort
will be selected most often). But for non-large distribtuions, the following does quite nicely.

```awk
function SymAny(i,without,  r,k,m) {
  r = rand()
  for(k in i.cnt) {
    m   = without : i.n - i.cnt[k] : i.cnt[k]
    r  -= m/i.n
    if (r <= 0) return k
  }
  return k
}
```

## Num

The `Num` class incrementally  maintains the mean and standard
deviation of the numbers seen in a column.

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
  if (i.m2<0) return 0
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
these numbers.  Be wary of using the following when `i.m` is less
than, say, 5 to 10.

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

Assuming a distribution is a normal bell-shaped curve, 
then the `box_muller` function can sample from the distribution:

```awk
function NumAny(i) { return i.m + i.sd*box_muller() }
```

```awk
function box_muller(     w,x1,x2) {
   w=1;
   while (w >= 1) {
     x1= 2.0 * rand() - 1;
     x2= 2.0 * rand() - 1;
     w = x1*x1 + x2*x2 
   }
   w = sqrt((-2.0 * log(w))/w);
   return x1 * w;
}
```
