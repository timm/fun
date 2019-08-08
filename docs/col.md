---
title: col.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# col.fun
```awk
@include "funny"
```

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0; col; txt|Col1()]^-[Num|mu = 0; sd = 0|NumAny()],[Col]^-[Sym|mode|NumEnt();SymAny()],[Col]^-[Some||SomeMedian()|SomeIQR()|SomeAny()]">

`Num` and `Sym` and `Some` keep summary statistics on `Col`umns in tables. 

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

Sym and Num and Some track the central tendancies and variety  of the the columns they watch

- For `Num`s, that is called mode and entropy (see `mode` and `NumEnt()`);
- For `Sym`s, that is called mean and standard deviation (see `mu` and `sd`),
- For `Some`s, that is called median and IRQ (see `SomeMedian` and `SomeIQR`),

All these classes also know  how to "sample"; i.e. to generate
numbers or symbols at a frequency that is similiar to the data from
which they learned their distributions (see the `*Any()` functions).

`Num` implementes that sampling using a very fast process that makes
certain parametric assumptions (that the data conforms to a normal
bell-shapred curve).
 `Some` needs to sort its
contents first-- so it is slower. But its sampling works for any
shaped distribution.

## See also

- [Num](num)
- [Sym](sym)
- [Some](some)
