---
title: someok.fun
---

<<button class="button button1"><a href="/fun/index">index</a></button>   button class="button button2"><a href="/fun/ABOUT">about</a></button>   <button class="button button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button2"><a href="/fun/license">license</a></button> <br>



# someok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[some](some)"<br>
Uses:  "[num](num)"<br>

```awk
   1.  BEGIN {  tests("someof","_some") }
```

`s` are `Some` of some random numbers. `n0` is
the distribution seen from those numbers. It should have
(nearly) the same mean and standard deviations
as `n1`, a
the distribution drawn from `SomeAny(s)`. 

```awk
   2.  func _some(f,     n0,n1,s,a,max,x,i) {
   3.    max = 3000
   4.    srand(1)
   5.    Num(n0)
   6.    Num(n1)
   7.    Some(s)
   8.    List(a)
   9.    for(i=1;i<=max;i+= 1) {
  10.      x = push(a, rand()) 
  11.      Num1(n0,x)
  12.      Some1(s,x)
  13.    }
  14.    for(i=1;i<=max;i+= 1) 
  15.      Num1(n1, SomeAny(s))
  16.    is(f,n0.sd, n1.sd, 0.01)
  17.    is(f,n0.mu, n1.mu, 0.01)
  18.  }
```
