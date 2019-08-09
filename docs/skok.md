---
title: skok.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# skok.fun

@include "[funny](funny)"<br>
@include "[sk](sk)"<br>

```awk
   1.  BEGIN { tests("skok", "_sk") }
```

```awk
   2.  function _sk(f,   w,a,b,x,max) {
   3.     srand(1)
   4.     for(w=1;w<=1.5;w+=0.05) {
   5.       List(a)
   6.       List(b)
   7.       max=10^2
   8.       for(x=1;x<=max;x++) {
   9.         a[x] = x
  10.         b[x] = x*w }
  11.       print w,bootstrap(a,b)
  12.     }
  13.  }
```
