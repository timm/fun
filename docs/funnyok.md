---
title: funnyok.fun
---
[HOME](http://menzies.us/fun/funnyok.fun)

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
