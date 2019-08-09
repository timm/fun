---
title: colok.fun
---

[index](/fun/index) :: [about](/fun/ABOUT) ::  [code](http://github.com/timm/fun) ::  [discuss](http://github.com/timm/fun/issues) :: [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# colok.fun

```awk
   1.  @include "funny"
   2.  @include "tbl"
```

```awk
   3.  BEGIN { tests("colok","_weather") }
```

```awk
   4.  func _weather(f,  n,i, sd,mu) { 
   5.    Num(n,"c","v")
   6.    for(i=1;i<=100;i+= 1) {
   7.      Num1(n,i)
   8.      if((i%10)==0) { sd[i]=n.sd; mu[i]=n.mu }
   9.    }
  10.    for(i=100;i>=1; i-= 1) {
  11.      print i
  12.      if((i%10)==0) print i, n.mu/mu[i], n.sd/sd[i] 
  13.      NumLess(n,i)
  14.    }
  15.  }
```
