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

<img src="http://yuml.me/diagram/plain/class/[Col|n = 0; col; txt|Col1()]^-[Num|mu = 0; sd = 0],[Col]^-[Sym|mode|NumEnt()]">

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

Sym and Num track the central tendancies and variety  of the the columns they watch

- For `Num`s, that is called `mode` and `entropy`: see `mode` and `NumEnt()`;
- For `Sym`s, that is called `mean` and `standard deviation`; see `mu` and `sd`.

`Sym` and `Num` also know  how to "sample"; i.e. to generate numbers or symbols
at a frequency that is similiar to the data from which they learned their distributions.


