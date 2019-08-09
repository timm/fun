---
title: skok.fun
---

 [about](/fun/ABOUT) |   [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE)<br>



# skok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[sk](sk)"<br>
Uses:  "[num](num)"<br>

```awk
   1.  BEGIN { tests("skok", "_sk,_cd1,_cd2,_cd3") }
```

```awk
   2.  function _sample(fun,   w,a,b,x,max) {
   3.     print ""
   4.     srand(1)
   5.     for(w=1;w<1.5;w+=0.05) {
   6.       List(a)
   7.       List(b)
   8.       max=500
   9.       for(x=1;x<=max;x++) {
  10.         a[x] = rand()
  11.         b[x] = a[x]*w }
  12.       print fun,w,@fun(a,b)
  13.     }
  14.  }
```

```awk
  15.  function _sk(f) { _sample("bootstrap") }
  16.  function _cd1(f) { _sample("cdslow") }
  17.  function _cd2(f) { _sample("cliffsDelta") }
  18.  function _cd3(f) { _sample("distinct") }
```


```awk
  19.  function cdslow(a,b,   x,y,gt,lt,m) {
  20.    for(x in a) 
  21.     for(y in a) {
  22.        gt += a[x] > b[y]
  23.        lt += a[x] < b[y] }
  24.   m = length(a)*length(b)
  25.   return abs(gt - lt)/ m > 0.147
  26.  }
```
