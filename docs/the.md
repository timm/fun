---
title: the.fun
---

[about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# the.fun

```awk
   1.  @include "funny"
```

```awk
   2.  func Config(i) {
   3.    Object(i)
   4.  
   5.    i.row.doms   =  64
   6.  
   7.    i.div.min    =   0.5
   8.    i.div.cohen  =   0.3
   9.    i.div.trivial=   1.05
  10.    i.div.enough =  512
  11.    i.div.verbose=    1
  12.  
  13.    i.some.most  =  256
  14.  
  15.    i.sk.cliffs  =    0.147 # small effect. From Romano 2006
  16.    i.sk.b       = 1000
  17.    i.sk.conf    = 0.01
  18.  
  19.    i.nums.hedges=   0.38 # small effect. Use 1.0 for medium effect
  20.    i.nums.ttest=   95 # selects thresholds for ttest
  21.  
  22.  }
```

```awk
  23.  BEGIN {Config(THE)}
```
