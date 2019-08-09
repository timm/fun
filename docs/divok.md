---
title: divok.fun
---

 [about](/fun/ABOUT) |   [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <hr><br>
<br>

# divok.fun

Uses:  "[div](div)"<br>

```awk
   1.  BEGIN { tests("divok", "_div1") }
```

```awk
   2.  function _div1(f) {
   3.     _div2(f,"_div1a")
   4.     _div2(f,"_div2a")
   5.     _div2(f,"_div3a")
   6.  }
   7.  function _div2(f,g,    s,lst,a,i,cuts,max) {
   8.     srand(1)
   9.     List(a)
  10.     max=i=10^4
  11.     for(i=1;i<=max;i++) {
  12.       a[i].x = i
  13.       a[i].y = @g(i,max) }
  14.     Sdiv(s,a)
  15.     oo(s.cuts,g)
  16.     print("")
  17.  }
```

```awk
  18.  function _div1a(x,max) {
  19.    if (x<=max*1/3) return 0
  20.    if (x<=max*2/3) return 1
  21.    return 2
  22.  }
  23.  function _div2a(x,max) {
  24.    if (x<=max*1/3) return 0
  25.    if (x<=max*2/3) return rand()
  26.    return 2*rand()
  27.  }
  28.  function _div3a(x,max) { return 0 }
```

