---
title: skok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# skok.fun

```awk
   1.  @include "funny"
   2.  @include "sk"
```

```awk
   3.  BEGIN { tests("skok", "_sk") }
```

```awk
   4.  function _sk(f,   w,a,b,x,max) {
   5.     srand(1)
   6.     for(w=1;w<=1.5;w+=0.05) {
   7.       List(a)
   8.       List(b)
   9.       max=10^2
  10.       for(x=1;x<=max;x++) {
  11.         a[x] = x
  12.         b[x] = x*w }
  13.       print w,bootstrap(a,b)
  14.     }
  15.  }
```
