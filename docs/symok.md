---
title: symok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button1"><a href="/fun/INSTALL">install</a></button>   <button class="button button2"><a href="/fun/ABOUT">doc</a></button>   <button class="button button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button2"><a href="/fun/license">license</a></button> <br>



# symok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[sym](sym)"<br>

```awk
   1.  BEGIN {  tests("colok","_sym,_syms") }
```

If we sample from a `Sym`, does it generate
items at the right frequency?

```awk
   2.  func _syms(f,   max,s,a,b,i,j,k) {
   3.    max=256
   4.    s="aaaabbc"
   5.    Sym(i)
   6.    Sym(j)
   7.    split(s,a,"")
   8.    for(k in a) Sym1(i, a[k]) # load "i"
   9.    for(k=1; k<=max; k++) 
  10.      Sym1(j,SymAny(i))  # sample "i" to load "j"
  11.    is(f, SymEnt(i), SymEnt(j), 0.05)
  12.  }
```

Checkng some sample entropy counts:

```awk
  13.  function _sym(f) {
  14.    is(f, _sym1("aaaabbc"), 1.37878) 
  15.    is(f, _sym1("aaaaaaa"), 0)
  16.  }
```

```awk
  17.  func _sym1(s,   a,i,j) {
  18.    Sym(i)
  19.    split(s,a,"")
  20.    for(j in a) 
  21.      Sym1(i, a[j])
  22.    return SymEnt(i)
  23.  }
```
