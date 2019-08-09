---
title: funnyok.fun
---

[about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# funnyok.fun
```awk
   1.  @include "funny"
```

```awk
   2.  BEGIN { tests("funny", "_isnt,_any") }
```

```awk
   3.  function _isnt(f) {
   4.    print "this one should fail"
   5.    is(f, 0,1)
   6.  }
```

```awk
   7.  function _any(f,   a,b,i) {
   8.    split("a,b,c,d,e,f",a,",")
   9.    for(i=1;i<=50;i++) b[i]=any(a)
  10.    asort(b)
  11.    is(f, b[1],1)
  12.  }
```
