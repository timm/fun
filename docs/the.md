---
title: the.fun
---

<button class="button"><a href="/fun/ABOUT">about</a></button>   <button class="button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button2"><a href="/fun/license">license</a></button> <br>



# the.fun

Uses:  "[funny](funny)"<br>

Generates `THE`,  a global to store all the configuration settings.
The thing to note here is that a data miner/optimizer uses many,
many settings.  AI tools are needed to explore this very large space
of options.

```awk
   1.  function Config(i) {
   2.    i.row.doms   =   64
   3.  
   4.    i.div.min    =    0.5
   5.    i.div.cohen  =    0.3
   6.    i.div.trivial=    1.05
   7.    i.div.enough =  512
   8.    i.div.verbose=    1
   9.  
  10.    i.some.most  =  256
  11.  
  12.    i.sk.cliffs  =    0.147 # small effect. From Romano 2006
  13.    i.sk.b       =  500 
  14.    i.sk.conf    =   95
  15.  
  16.    i.nums.hedges=    0.38 # small effect. Use 1.0 for medium effect
  17.    i.nums.ttest=    95 # selects thresholds for ttest
  18.  
  19.  }
```

```awk
  20.  BEGIN {Config(THE)}
```
