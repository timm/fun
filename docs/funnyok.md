---
title: funnyok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

# funnyok.fun
```awk
@include "funny"
```

```awk
BEGIN { tests("lauk", "_lauk") }
```

```awk
func _lauk(f,   a,b,i) {
  split("a,b,c,d,e,f",a,",")
  for(i=1;i<=50;i++) b[i]=anyi(a)
  asort(b)
  flat(b,1)
}
```


<em> &copy; 2019, Tim Menzies, http://menzies.us</em>
