---
title: numok.fun
---

<button class="button"><a href="/fun/ABOUT">about</a></button>   <button class="button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button2"><a href="/fun/license">license</a></button> <br>



# numok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[num](num)"<br>

```awk
   1.  BEGIN {  tests("colok","_num,_any") }
```

Walk up a list of random numbers, adding to a `Num`
counter. Then walk down, removing numbers. Check
that we get to the same mu and standard deviation
both ways.

```awk
   2.  func _num(f,     n,a,i,mu,sd) {
   3.    srand()
   4.    Num(n,"c","v")
   5.    List(a)
   6.    for(i=1;i<=100;i+= 1) 
   7.      push(a,rand()^2) 
   8.    for(i=1;i<=100;i+= 1) { 
   9.      Num1(n,a[i])
  10.      if((i%10)==0) { 
  11.       sd[i]=n.sd
  12.       mu[i]=n.mu }}
  13.    for(i=100;i>=1; i-= 1) {
  14.      if((i%10)==0) {
  15.        is(f, n.mu, mu[i])
  16.        is(f, n.sd, sd[i])  }
  17.      NumLess(n,a[i]) }
  18.  }
```

Check that it we pull from some initial gaussian distribution,
we can sample it to find the same means and standard deviation.

```awk
  19.  func _any(f,     max,n,a,i,mu,sd,n0,n1,x) {
  20.    srand(1)
  21.    Num(n0)
  22.    Num(n1)
  23.    List(a)
  24.    max=300
  25.    for(i=1;i<=max;i+= 1) {
  26.      x=sqrt(-2*log(rand()))*cos(6.2831853*rand())
  27.      Num1(n0,x)
  28.      push(a, x) 
  29.    }
  30.    for(i=1;i<=max;i+= 1) Num1(n1, NumAny(n0))
  31.    is(f,n0.sd, n1.sd,0.05)
  32.    is(f, (n0.mu-n1.mu)< 0.05,1 )
  33.  }
```
