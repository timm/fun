---
title: symok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# symok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[sym](sym)"<br>

```awk
   1.  BEGIN {  tests("colok","_like,_sym,_syms") }
```

```awk
   2.  function _like(f,  s,a,k) {
   3.    Sym(s)
   4.    split("aaaabbc",a,"")
   5.    for(k in a) Sym1(s,a[k])
   6.    print("a",SymLike(s,"a"))
   7.    print("b",SymLike(s,"b"))
   8.    print("c",SymLike(s,"c"))
   9.  }
```

If we sample from a `Sym`, does it generate
items at the right frequency?


```awk
  10.  func _syms(f,   max,s,a,b,i,j,k) {
  11.    max=256
  12.    s="aaaabbc"
  13.    Sym(i)
  14.    Sym(j)
  15.    split(s,a,"")
  16.    for(k in a) Sym1(i, a[k]) # load "i"
  17.    print(SymEnt(i))
  18.    for(k=1; k<=max; k++) 
  19.      Sym1(j,SymAny(i))  # sample "i" to load "j"
  20.    is(f, SymEnt(i), SymEnt(j), 0.05)
  21.  }
```

Checkng some sample entropy counts:

```awk
  22.  function _sym(f) {
  23.    is(f, _sym1("aaaabbc"), 1.37878) 
  24.    is(f, _sym1("aaaaaaa"), 0)
  25.  }
```

```awk
  26.  func _sym1(s,   a,i,j) {
  27.    Sym(i)
  28.    split(s,a,"")
  29.    for(j in a) 
  30.      Sym1(i, a[j])
  31.    return SymEnt(i)
  32.  }
```
