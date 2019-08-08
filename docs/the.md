---
title: the.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# the.fun

```awk
@include "funny"
```

```awk
func Config(i) {
  Object(i)

  i.row.doms  =   64

  i.div.min   =    0.5
  i.div.cohen =    0.3
  i.div.trivial=   1.05
  i.div.enough=  512

  i.some.most  = 256

  i.nums.hedges=   0.38 # small effect. Use 1.0 for medium effect
  i.nums.ttest=   95 # selects thresholds for ttest

}
```

```awk
BEGIN {Config(THE)}
```
