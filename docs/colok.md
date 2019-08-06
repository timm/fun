---
title: colok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

|[home](http://menzies.us/fun) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/LICENSE) |

# colok.fun
#--------- --------- --------- --------- --------- ---------

```awk
@include "funny"
@include "tbl"
```

```awk
BEGIN { tests("colok","_weather") }
```

```awk
func _weather(f,  n,i, sd,mu) { 
  Num(n,"c","v")
  for(i=1;i<=100;i+= 1) {
    Num1(n,i)
    if((i%10)==0) { sd[i]=n.sd; mu[i]=n.mu }
  }
  for(i=100;i>=1; i-= 1) {
    print i
    if((i%10)==0) print i, n.mu/mu[i], n.sd/sd[i] 
    NumLess(n,i)
  }
}
```


<em> &copy; 2019, Tim Menzies, http://menzies.us</em>
