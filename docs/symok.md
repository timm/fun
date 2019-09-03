---
title: symok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



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
   9.    print(SymEnt(i))
  10.    for(k=1; k<=max; k++) 
  11.      Sym1(j,SymAny(i))  # sample "i" to load "j"
  12.    is(f, SymEnt(i), SymEnt(j), 0.05)
  13.  }
```

Checkng some sample entropy counts:

```awk
  14.  function _sym(f) {
  15.    is(f, _sym1("aaaabbc"), 1.37878) 
  16.    is(f, _sym1("aaaaaaa"), 0)
  17.  }
```

```awk
  18.  func _sym1(s,   a,i,j) {
  19.    Sym(i)
  20.    split(s,a,"")
  21.    for(j in a) 
  22.      Sym1(i, a[j])
  23.    return SymEnt(i)
  24.  }
```
