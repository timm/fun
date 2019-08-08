---
title: numsok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# numsok.fun

```awk
@include "funny"
@include "nums"
```

```awk
BEGIN {  tests("numok","_nums") }
```

```awk
func _nums(f,     a,i,k) {
  srand()
  Config(THE)
  THE.nums.ttest = 95
  for(i=1;i<=100;i+= 1)  
    a[i] = rand()^2
  for(k=1; k<=1.5; k+=0.05) 
     _num1(a,k)
}
```

```awk
func _num1(a,k,    i,na,nk) {
  Num(na)
  Num(nk)
  for(i in a) {
    Num1(na, a[i])
    Num1(nk, a[i]*k)
  }
  print(k,diff(na,nk))
}
```
