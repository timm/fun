---
title: div1ok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# div1ok.fun

```awk
   1.  @include "div1"
```

```awk
   2.  BEGIN { tests("divok", "_div") }
```

```awk
   3.  function _div1(x,max) {
   4.    if (x<=max*1/3) return 0
   5.    if (x<=max*2/3) return rand()
   6.    return 2*rand()
   7.  }
   8.  function _div(f,    s, lst,a,i,cuts,max) {
   9.     srand(1)
  10.     List(a)
  11.     max=i=10^4
  12.     for(i=1;i<=max;i++) {
  13.       a[i].x = i
  14.       a[i].y = _div1(i,max) }
  15.     Sdiv(s,a)
  16.     oo(s.cuts)
  17.  }
```
