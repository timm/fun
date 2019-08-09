---
title: someok.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# someok.fun

@include "[funny](funny)"<br>
@include "[some](some)"<br>
@include "[num](num)"<br>

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
