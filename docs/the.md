---
title: the.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# the.fun

```awk
   1.  @include "funny"
```

```awk
   2.  func Config(i) {
   3.    Object(i)
   4.  
   5.    i.row.doms  =   64
   6.  
   7.    i.div.min   =    0.5
   8.    i.div.cohen =    0.3
   9.    i.div.trivial=   1.05
  10.    i.div.enough=  512
  11.    i.div.verbose=   1
  12.  
  13.    i.some.most  = 256
  14.    i.some.cliffs=   0.147 # small effect. From Romano 2006
  15.  
  16.    i.nums.hedges=   0.38 # small effect. Use 1.0 for medium effect
  17.    i.nums.ttest=   95 # selects thresholds for ttest
  18.  
  19.  }
```

```awk
  20.  BEGIN {Config(THE)}
```
