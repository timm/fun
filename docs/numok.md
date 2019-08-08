---
title: numok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# numok.fun

```awk
@include "funny"
@include "num"
```

```awk
BEGIN {  tests("colok","_num,_any") }
```

Walk up a list of random numbers, adding to a `Num`
counter. Then walk down, removing numbers. Check
that we get to the same mu and standard deviation
both ways.

```awk
func _num(f,     n,a,i,mu,sd) {
  srand()
  Num(n,"c","v")
  List(a)
  for(i=1;i<=100;i+= 1) 
    push(a,rand()^2) 
  for(i=1;i<=100;i+= 1) { 
    Num1(n,a[i])
    if((i%10)==0) { 
     sd[i]=n.sd
     mu[i]=n.mu }}
  for(i=100;i>=1; i-= 1) {
    if((i%10)==0) {
      is(f, n.mu, mu[i])
      is(f, n.sd, sd[i])  }
    NumLess(n,a[i]) }
}
```

```awk
func _any(f,     max,n,a,i,mu,sd,n0,n1) {
  srand(1)
  Num(n0)
  Num(n1)
  List(a)
  max=300
  for(i=1;i<=max;i+= 1) {
    x=sqrt(-2*log(rand()))*cos(6.2831853*rand())
    Num1(n0,x)
    push(a, x) 
  }
  for(i=1;i<=max;i+= 1) Num1(n1, NumAny(n0))
  oo(n0,"n0")
  oo(n1,"n1")
  print(n0.sd, n1.sd)
  print(n0.mu, n1.mu)
}
```
