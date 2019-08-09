---
title: col.fun
---

[index](/fun/index) :: [about](/fun/ABOUT) ::  [code](http://github.com/timm/fun) ::  [discuss](http://github.com/timm/fun/issues) :: [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# col.fun
```awk
   1.  @include "funny"
```

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0; col; txt|Col1()]^-[Num|mu = 0; sd = 0|NumAny()],[Col]^-[Sym|mode|NumEnt();SymAny()],[Col]^-[Some||SomeMedian()|SomeIQR()|SomeAny()]">

`Num` and `Sym` and `Some` keep summary statistics on `Col`umns in tables. 

## Col

```awk
   2.  function Col(i,c,v) { 
   3.    Object(i)   
   4.    i.n=0
   5.    i.col=c
   6.    i.txt=v 
   7.  } 
```

The generic add function ignroes anything that is a `"?"`. 

```awk
   8.  BEGIN {IGNORE="\\?"}
   9.  function Col1(i,v,   add) {
  10.    if (v ~ IGNORE) return v
  11.    add = i.add
  12.    return @add(i,v)
  13.  } 
```

Sym and Num and Some track the central tendancies and variety  of the the columns they watch

- For `Sym`s, that is called mode and entropy (see `mode` and `NumEnt()`);
- For `Num`s, that is called mean and standard deviation (see `mu` and `sd`),
- For `Some`s, that is called median and IRQ (see `SomeMedian` and `SomeIQR`),

(The difference between `Num` and `Some` is that the latter assumes the values come from
some normal bell-shaped curve.)

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
