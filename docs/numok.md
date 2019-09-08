---
title: numok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# numok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[num](num)"<br>

```awk
   1.  BEGIN {  tests("colok","_like,_num,_any") }
```


```awk
   2.  function _like(f,  m,n) {
   3.    srand(1)
   4.    Num(n)
   5.    m=100
   6.    while(m--) Num1(n,rand())
   7.    for(m=0;m<=1;m+=0.1)  print(m,NumLike(n,m))
   8.  }
```

Walk up a list of random numbers, adding to a `Num`
counter. Then walk down, removing numbers. Check
that we get to the same mu and standard deviation
both ways.

```awk
   9.  function _num(f,     n,a,i,mu,sd) {
  10.    srand()
  11.    Num(n,"c","v")
  12.    List(a)
  13.    for(i=1;i<=100;i+= 1) 
  14.      push(a,rand()^2) 
  15.    for(i=1;i<=100;i+= 1) { 
  16.      Num1(n,a[i])
  17.      if((i%10)==0) { 
  18.       sd[i]=n.sd
  19.       mu[i]=n.mu }}
  20.    for(i=100;i>=1; i-= 1) {
  21.      if((i%10)==0) {
  22.        is(f, n.mu, mu[i])
  23.        is(f, n.sd, sd[i])  }
  24.      NumLess(n,a[i]) }
  25.  }
```

Check that it we pull from some initial gaussian distribution,
we can sample it to find the same means and standard deviation.

```awk
  26.  function _any(f,     max,n,a,i,mu,sd,n0,n1,x) {
  27.    srand(1)
  28.    Num(n0)
  29.    Num(n1)
  30.    List(a)
  31.    max=300
  32.    for(i=1;i<=max;i+= 1) {
  33.      x=sqrt(-2*log(rand()))*cos(6.2831853*rand())
  34.      Num1(n0,x)
  35.      push(a, x) 
  36.    }
  37.    for(i=1;i<=max;i+= 1) Num1(n1, NumAny(n0))
  38.    is(f,n0.sd, n1.sd,0.05)
  39.    is(f, (n0.mu-n1.mu)< 0.05,1 )
  40.  }
```
