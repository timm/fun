---
title: numsok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# numsok.fun

```awk
   1.  @include "funny"
   2.  @include "nums"
```

```awk
   3.  BEGIN {  tests("numok","_nums") }
```

```awk
   4.  func _nums(f,     a,i,k) {
   5.    srand(1)
   6.    for(i=1;i<=100;i+= 1)  
   7.      a[i] = rand()
   8.    for(k=1; k<=1.5; k+=0.05) 
   9.       _num1(a,k)
  10.  }
```

```awk
  11.  func _num1(a,k,    i,na,nk,s) {
  12.    Num(na)
  13.    Num(nk)
  14.    for(i in a) 
  15.       Num1(nk, 
  16.            k * Num1(na, a[i]))
  17.    Nums(s)
  18.    print("k",k,
  19.           "\tsigDifferent",ttest(na,nk,s),
  20.           "notSmallEffect",hedges(na,nk,s), 
  21.           "and", diff(na,nk))
  22.  }
```
