---
title: funnyok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/license) |

<em> &copy; 2019, Tim Menzies, http://menzies.us</em>

# funnyok.fun
```awk
@include "funny"
```

```awk
BEGIN { tests("funny", "_isnt,_any") }
```

```awk
function _isnt(f) {
  print "this one should fail"
  is(f, 0,1)
}
```

```awk
function _any(f,   a,b,i) {
  split("a,b,c,d,e,f",a,",")
  for(i=1;i<=50;i++) b[i]=any(a)
  asort(b)
  is(f, b[1],1)
}
```
