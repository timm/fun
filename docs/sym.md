---
title: sym.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# sym.fun
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

Entropy is a measure of the variety of a set of systems.
One way to build a learner is to find splits in the data that most reduces
that variety (and then to recursively split divide each split).
Entropy is minimal (zero) when all the symbols  are the same. Otherwise,
given symbols at probability P1, P2, etc then entropy is calcuated[^ent] as follows 

- _&sum;-Px*log2(Px)_ 

Note that the analog  of entropy for continuous distributions is Standard deviation
(discussed below).

[^ent]: For an approximate justification of  this formula,  consder a piece of string 10 meters long, stained in two places by a  meter of red and two metres of green. The probability of stumbling over those colors is Pr=0.1 and Pg=0.2, respectively. To measure the variety of the signal in that string, we record the effort associated with reconstructing it (i.e. finding all its parts).  To that end, for each color, we fold the string in half until one color is isolated (this needs approximately _log2(Px)_ folds). The  probability of doing those folds is  proportinal to the odds we'll look for that color. That is,  the total effort is _Px*log2(Px)_ (which must be repeated for all colors; i.e. _&sum;Px*log2(Px)_). Note that, by convention, we throw a minus sign around the summation (otherwise, we will be forever reporting negative values).

```awk
  16.  function SymEnt(i,   p,e,k) {
  17.    for(k in i.cnt) {
  18.      p  = i.cnt[k]/i.n
  19.      e -= p*log(p)/log(2)  # log(N)/log(2) is the same an log2(N)
  20.    }
  21.    return e
  22.  }
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
  23.  function SymAny(i,without,  r,k,m) {
  24.    r = rand()
  25.    for(k in i.cnt) {
  26.      m   = without ? i.n - i.cnt[k] : i.cnt[k]
  27.      r  -= m/i.n
  28.      if (r <= 0) return k
  29.    }
  30.    return k
  31.  }
```

## See also

- [Col](col)


## Notes
