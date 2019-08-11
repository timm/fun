---
title: colok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# colok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[tbl](tbl)"<br>
Uses:  "[num](num)"<br>

```awk
   1.  BEGIN { tests("colok","_weather") }
```

```awk
   2.  function _weather(f,  n,i, sd,mu) { 
   3.    Num(n,"c","v")
   4.    for(i=1;i<=100;i+= 1) {
   5.      Num1(n,i)
   6.      if((i%10)==0) { sd[i]=n.sd; mu[i]=n.mu }
   7.    }
   8.    for(i=100;i>=1; i-= 1) {
   9.      print i
  10.      if((i%10)==0) print i, n.mu/mu[i], n.sd/sd[i] 
  11.      NumLess(n,i)
  12.    }
  13.  }
```
