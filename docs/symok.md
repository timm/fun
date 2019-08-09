---
title: symok.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# symok.fun

```awk
   1.  @include "funny"
   2.  @include "sym"
```

```awk
   3.  BEGIN {  tests("colok","_sym,_syms") }
```

If we sample from a `Sym`, does it generate
items at the right frequency?

```awk
   4.  func _syms(f,   max,s,a,b,i,j,k) {
   5.    max=256
   6.    s="aaaabbc"
   7.    Sym(i)
   8.    Sym(j)
   9.    split(s,a,"")
  10.    for(k in a) Sym1(i, a[k]) # load "i"
  11.    for(k=1; k<=max; k++) 
  12.      Sym1(j,SymAny(i))  # sample "i" to load "j"
  13.    is(f, SymEnt(i), SymEnt(j), 0.05)
  14.  }
```

Checkng some sample entropy counts:

```awk
  15.  function _sym(f) {
  16.    is(f, _sym1("aaaabbc"), 1.37878) 
  17.    is(f, _sym1("aaaaaaa"), 0)
  18.  }
```

```awk
  19.  func _sym1(s,   a,i,j) {
  20.    Sym(i)
  21.    split(s,a,"")
  22.    for(j in a) 
  23.      Sym1(i, a[j])
  24.    return SymEnt(i)
  25.  }
```
