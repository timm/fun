---
title: numok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# numok.fun

```awk
   1.  @include "funny"
   2.  @include "num"
```

```awk
   3.  BEGIN {  tests("colok","_num,_any") }
```

Walk up a list of random numbers, adding to a `Num`
counter. Then walk down, removing numbers. Check
that we get to the same mu and standard deviation
both ways.

```awk
   4.  func _num(f,     n,a,i,mu,sd) {
   5.    srand()
   6.    Num(n,"c","v")
   7.    List(a)
   8.    for(i=1;i<=100;i+= 1) 
   9.      push(a,rand()^2) 
  10.    for(i=1;i<=100;i+= 1) { 
  11.      Num1(n,a[i])
  12.      if((i%10)==0) { 
  13.       sd[i]=n.sd
  14.       mu[i]=n.mu }}
  15.    for(i=100;i>=1; i-= 1) {
  16.      if((i%10)==0) {
  17.        is(f, n.mu, mu[i])
  18.        is(f, n.sd, sd[i])  }
  19.      NumLess(n,a[i]) }
  20.  }
```

```awk
  21.  func _any(f,     max,n,a,i,mu,sd,n0,n1) {
  22.    srand(1)
  23.    Num(n0)
  24.    Num(n1)
  25.    List(a)
  26.    max=300
  27.    for(i=1;i<=max;i+= 1) {
  28.      x=sqrt(-2*log(rand()))*cos(6.2831853*rand())
  29.      Num1(n0,x)
  30.      push(a, x) 
  31.    }
  32.    for(i=1;i<=max;i+= 1) Num1(n1, NumAny(n0))
  33.    oo(n0,"n0")
  34.    oo(n1,"n1")
  35.    print(n0.sd, n1.sd)
  36.    print(n0.mu, n1.mu)
  37.  }
```
