---
title: someok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

[index](/fun/index) :: [about](/fun/ABOUT) ::  [code](http://github.com/timm/fun) ::  [discuss](http://github.com/timm/fun/issues) :: [license](/fun/LICENSE) 

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# someok.fun

```awk
   1.  @include "funny"
   2.  @include "some"
   3.  @include "num"
```

```awk
   4.  BEGIN {  tests("someof","_some") }
```

`s` are `Some` of some random numbers. `n0` is
the distribution seen from those numbers. It should have
(nearly) the same mean and standard deviations
as `n1`, a
the distribution drawn from `SomeAny(s)`. 

```awk
   5.  func _some(f,     n0,n1,s,a,max,x,i) {
   6.    max = 3000
   7.    srand(1)
   8.    Num(n0)
   9.    Num(n1)
  10.    Some(s)
  11.    List(a)
  12.    for(i=1;i<=max;i+= 1) {
  13.      x = push(a, rand()) 
  14.      Num1(n0,x)
  15.      Some1(s,x)
  16.    }
  17.    for(i=1;i<=max;i+= 1) 
  18.      Num1(n1, SomeAny(s))
  19.    is(f,n0.sd, n1.sd, 0.01)
  20.    is(f,n0.mu, n1.mu, 0.01)
  21.  }
```
