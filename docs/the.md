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
   4.  
   5.    i.div.min    =    0.5
   6.    i.div.cohen  =    0.3
   7.    i.div.trivial=    1.05
   8.    i.div.enough =  512
   9.    i.div.verbose=    1
  10.  
  11.    i.some.most  =  256
  12.  
  13.    i.sk.cliffs  =    0.147 # small effect. From Romano 2006
  14.    i.sk.b       =  200 
  15.    i.sk.conf    =   99
  16.  
  17.    i.nums.hedges=    0.38 # small effect. Use 1.0 for medium effect
  18.    i.nums.ttest=    95 # selects thresholds for ttest
  19.  
  20.    i.cocomo.num= "[+-]?([0-9]+["dot"]?[0-9]*|["dot"][0-9]+)([eE][+-]?[0-9]+)?"
  21.  
  22.  }
```

```awk
  23.  BEGIN {Config(THE)}
```
