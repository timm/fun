---
title: the.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# the.fun

See also:  "[funny](funny)"<br>

```awk
   1.  func Config(i) {
   2.    Object(i)
   3.  
   4.    i.row.doms   =  64
   5.  
   6.    i.div.min    =   0.5
   7.    i.div.cohen  =   0.3
   8.    i.div.trivial=   1.05
   9.    i.div.enough =  512
  10.    i.div.verbose=    1
  11.  
  12.    i.some.most  =  256
  13.  
  14.    i.sk.cliffs  =    0.147 # small effect. From Romano 2006
  15.    i.sk.b       = 1000
  16.    i.sk.conf    = 0.01
  17.  
  18.    i.nums.hedges=   0.38 # small effect. Use 1.0 for medium effect
  19.    i.nums.ttest=   95 # selects thresholds for ttest
  20.  
  21.  }
```

```awk
  22.  BEGIN {Config(THE)}
```
