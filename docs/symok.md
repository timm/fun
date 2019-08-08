---
title: symok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# symok.fun

```awk
@include "funny"
@include "sym"
```

```awk
BEGIN {  tests("colok","_sym,_syms") }
```

If we sample from a `Sym`, does it generate
items at the right frequency?

```awk
func _syms(f,   max,s,a,b,i,j,k) {
  max=256
  s="aaaabbc"
  Sym(i)
  Sym(j)
  split(s,a,"")
  for(k in a) Sym1(i, a[k]) # load "i"
  for(k=1; k<=max; k++) 
    Sym1(j,SymAny(i))  # sample "i" to load "j"
  is(f, SymEnt(i), SymEnt(j), 0.05)
}
```

Checkng some sample entropy counts:

```awk
function _sym(f) {
  is(f, _sym1("aaaabbc"), 1.37878) 
  is(f, _sym1("aaaaaaa"), 0)
}
```

```awk
func _sym1(s,   a,i,j) {
  Sym(i)
  split(s,a,"")
  for(j in a) 
    Sym1(i, a[j])
  return SymEnt(i)
}
```
