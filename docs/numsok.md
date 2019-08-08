---
title: numsok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

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
   5.    srand()
   6.    Config(THE)
   7.    THE.nums.ttest = 95
   8.    for(i=1;i<=100;i+= 1)  
   9.      a[i] = rand()^2
  10.    for(k=1; k<=1.5; k+=0.05) 
  11.       _num1(a,k)
  12.  }
```

```awk
  13.  func _num1(a,k,    i,na,nk) {
  14.    Num(na)
  15.    Num(nk)
  16.    for(i in a) {
  17.      Num1(na, a[i])
  18.      Num1(nk, a[i]*k)
  19.    }
  20.    print(k,diff(na,nk))
  21.  }
```
