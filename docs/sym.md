---
title: sym.fun
---

<small>

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# sym.fun
<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0; col; txt|Col1()]^-[Sym|mode|Sym1(); SymEnt();SymAny()],[Sym]-[note: 'SymAny' implements 'sampling'{bg:cornsilk}]">

```awk
@include "funny"
@include "col"
```

The `Sym` class incrementally counts of the symbols seen in a column
as well as the most frequently seen symbol (which is called the  `mode`).


## Sym

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

[^ent]: For an approximate justification of  this formula,  consder a piece of string 10 meters long, stained in two places by a  meter of red and two metres of green. The probability of stumbling over those colors is Pr=0.1 and Pg=0.2, respectively. To measure the variety of the signal in that string, we record the effort associated with reconstructing it (i.e. finding all its parts).  To that end, for each color, we fold the string in half until one color is isolated (this needs approximately _log2(Px)_ folds). The  probability of doing those folds is  proportinal to the odds we'll look for that color. That is,  the total effort is _Px*log2(Px)_ (which must be repeated for all colors; i.e. _&sum;Px*log2(Px)_). Note that, by convention, we throw a minus sign around the summation (otherwise, we will be forever reporting negative values).

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


## See also

- [Col](col)


## Notes


</small>
