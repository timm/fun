---
title: colok.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# colok.fun

@include "[funny](funny)"<br>
@include "[tbl](tbl)"<br>

```awk
   1.  BEGIN { tests("colok","_weather") }
```

```awk
   2.  func _weather(f,  n,i, sd,mu) { 
   3.    Num(n,"c","v")
   4.    for(i=1;i<=100;i+= 1) {
   5.      Num1(n,i)
   6.      if((i%10)==0) { sd[i]=n.sd; mu[i]=n.mu }
   7.    }
   8.    for(i=100;i>=1; i-= 1) {
   9.      print i
  10.      if((i%10)==0) print i, n.mu/mu[i], n.sd/sd[i] 
  11.      NumLess(n,i)
  12.    }
  13.  }
```
