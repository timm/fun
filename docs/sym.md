---
title: sym.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# sym.fun

## Summarize symbolic columns.

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0; col; txt|Col1()]^-[Sym|mode|Sym1(); SymEnt();SymAny()],[Sym]-.-[note: 'SymAny' implements 'sampling'{bg:cornsilk}]">

Uses:  "[funny](funny)"<br>
Uses:  "[col](col)"<br>

The `Sym` class incrementally counts of the symbols seen in a column
as well as the most frequently seen symbol (which is called the  `mode`).


## Sym

```awk
   1.  function Sym(i,c,v) { 
   2.    Col(i,c,v)
   3.    i.mode=""
   4.    i.most=0
   5.    has(i,"cnt") 
   6.    i.add ="Sym1" 
   7.  }
   8.  function Sym1(i,v,  tmp) {
   9.    i.n++
  10.    tmp = ++i.cnt[v]
  11.    if (tmp > i.most) {
  12.      i.most = tmp
  13.      i.mode = v }
  14.    return v
  15.  }
```

```awk
  16.  function SymVariety(i) { return SymEnt(i) }
```

```awk
  17.  function SymXpect(i,j, n) {
  18.    n = i.n + j.n
  19.    return SymEnt(i) * i.n/n + SymEnt(j) * j.n/n 
  20.  }
```

Entropy is a measure of the variety of a set of systems.
One way to build a learner is to find splits in the data that most reduces
that variety (and then to recursively split divide each split).
Entropy is minimal (zero) when all the symbols  are the same. Otherwise,
given symbols at probability P1, P2, etc then entropy is calcuated[^ent] as follows 

- _&sum;-Px*log2(Px)_ 

Note that the analog  of entropy for continuous distributions is Standard deviation
(discussed below).

[^ent]: For an approximate justification of  this formula,  consider a piece of string 10 meters long, stained in two places by a  meter of red and two metres of green. The probability of stumbling over those colors is Pr=0.1 and Pg=0.2, respectively. To measure the variety of the signal in that string, we record the effort associated with reconstructing it (i.e. finding all its parts).  To that end, for each color, we fold the string in half until one color is isolated (this needs approximately _log2(Px)_ folds). The  probability of doing those folds is  proportinal to the odds we'll look for that color. That is,  the total effort is _Px*log2(Px)_ (which must be repeated for all colors; i.e. _&sum;Px*log2(Px)_). Note that, by convention, we throw a minus sign around the summation (otherwise, we will be forever reporting negative values).

```awk
  21.  function SymEnt(i,   p,e,k) {
  22.    for(k in i.cnt) {
  23.      p  = i.cnt[k]/i.n
  24.      e -= p*log(p)/log(2)  # log(N)/log(2) is the same an log2(N)
  25.    }
  26.    return e
  27.  }
```

To sample symbols from this distribution, (1) pick a random number;
then (2) let every entry "eat" some portion of it; and (3) return
the symbols found where there is nothing left to eat. 

- Note that for distributions with many numbers, it is useful to
sort the ditionary of symbol counts in descending order (since, usually, the first items in that sort will be selected most often).
But for non-large distribtuions, the following does quite nicely.
- Also note the optional "without" argument. If set then we select
from the _opposite_ of this distribution. This is useful if this
distribution is loaded up with things we want to avoid.

```awk
  28.  function SymAny(i,without,  r,k,m) {
  29.    r = rand()
  30.    for(k in i.cnt) {
  31.      m   = without ? i.n - i.cnt[k] : i.cnt[k]
  32.      r  -= m/i.n
  33.      if (r <= 0) return k
  34.    }
  35.    return k
  36.  }
```

### Like

`Sym`s can also report how much they "like" some symbol. If `x` occours
at frequency `f` then it is liked at `f/i.n`. The `m` param is added
to handle low frequency cases (in the manner recommeded in Section 3.1 of [Yang et al.](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.72.8235&rep=rep1&type=pdf). 
In the following, `m` defaults to zero but if you want to be smarter,
a typical values for `m` is 2.

```awk
  37.  function SymLike(i,x,prior,m,   f) {
  38.    f = x in i.cnt ? i.cnt[x] : 0
  39.    return (f + m*prior)/(i.n + m)
  40.  }
```
