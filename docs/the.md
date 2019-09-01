---
title: the.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# the.fun


## Configuration options.

Uses:  "[funny](funny)"<br>

Generates `THE`,  a global to store all the configuration settings.
The thing to note here is that a data miner/optimizer uses many,
many settings.  AI tools are needed to explore this very large space
of options.

```awk
   1.  function Config(i,   dot) {
   2.    dot = sprintf("%c",46)
   3.    i.row.doms   =   64
   4.    i.row.p      =    2
   5.    i.row.skip   =    "?"
   6.  
   7.    i.div.min    =    0.5
   8.    i.div.cohen  =    0.3
   9.    i.div.trivial=    1.05
  10.    i.div.enough =  512
  11.    i.div.verbose=    1
  12.  
  13.    i.some.most  =  256
  14.    i.some.ks    =   95
  15.  
  16.    i.sk.cliffs  =    0.147 # small effect. From Romano 2006
  17.    i.sk.b       =  200 
  18.    i.sk.conf    =   99
  19.  
  20.    i.nums.hedges=    0.38 # small effect. Use 1.0 for medium effect
  21.    i.nums.ttest =   95 # selects thresholds for ttest
  22.  
  23.    i.cocomo.num = "[+-]?([0-9]+["dot"]?[0-9]*|["dot"][0-9]+)([eE][+-]?[0-9]+)?"
  24.  
  25.  
  26.  }
```

```awk
  27.  BEGIN {Config(THE)}
```
