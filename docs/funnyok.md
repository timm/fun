---
title: funnyok.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# funnyok.fun
@include "[funny](funny)"<br>

```awk
   1.  BEGIN { tests("funny", "_isnt,_any") }
```

```awk
   2.  function _isnt(f) {
   3.    print "this one should fail"
   4.    is(f, 0,1)
   5.  }
```

```awk
   6.  function _any(f,   a,b,i) {
   7.    split("a,b,c,d,e,f",a,",")
   8.    for(i=1;i<=50;i++) b[i]=any(a)
   9.    asort(b)
  10.    is(f, b[1],1)
  11.  }
```
