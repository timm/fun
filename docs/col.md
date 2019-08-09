---
title: col.fun
---

 [about](/fun/ABOUT) |   [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <hr><br>
<br>

# col.fun
Uses:  "[funny](funny)"<br>

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|n = 0; col; txt|Col1()]^-[Num|mu = 0; sd = 0|NumAny()],[Col]^-[Sym|mode|NumEnt();SymAny()],[Col]^-[Some||SomeMedian()|SomeIQR()|SomeAny()]">

`Num` and `Sym` and `Some` keep summary statistics on `Col`umns in tables. 

## Col

```awk
   1.  function Col(i,c,v) { 
   2.    Object(i)   
   3.    i.n=0
   4.    i.col=c
   5.    i.txt=v 
   6.  } 
```

The generic add function ignroes anything that is a `"?"`. 

```awk
   7.  BEGIN {IGNORE="\\?"}
   8.  function Col1(i,v,   add) {
   9.    if (v ~ IGNORE) return v
  10.    add = i.add
  11.    return @add(i,v)
  12.  } 
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
