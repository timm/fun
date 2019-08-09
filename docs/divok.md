---
title: divok.fun
---

[index](/fun/index) :: [about](/fun/ABOUT) ::  [code](http://github.com/timm/fun) ::  [discuss](http://github.com/timm/fun/issues) :: [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# divok.fun

```awk
   1.  @include "div"
```

```awk
   2.  BEGIN { tests("divok", "_div1") }
```

```awk
   3.  function _div1(f) {
   4.     _div2(f,"_div1a")
   5.     _div2(f,"_div2a")
   6.     _div2(f,"_div3a")
   7.  }
   8.  function _div2(f,g,    s,lst,a,i,cuts,max) {
   9.     srand(1)
  10.     List(a)
  11.     max=i=10^4
  12.     for(i=1;i<=max;i++) {
  13.       a[i].x = i
  14.       a[i].y = @g(i,max) }
  15.     Sdiv(s,a)
  16.     oo(s.cuts,g)
  17.     print("")
  18.  }
```

```awk
  19.  function _div1a(x,max) {
  20.    if (x<=max*1/3) return 0
  21.    if (x<=max*2/3) return 1
  22.    return 2
  23.  }
  24.  function _div2a(x,max) {
  25.    if (x<=max*1/3) return 0
  26.    if (x<=max*2/3) return rand()
  27.    return 2*rand()
  28.  }
  29.  function _div3a(x,max) { return 0 }
```

