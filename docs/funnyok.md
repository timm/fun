---
title: funnyok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/license">license</a></button> <br>



# funnyok.fun
Uses:  "[funny](funny)"<br>

```awk
   1.  BEGIN { tests("funny", "_isnt,_any") }
```

```awk
   2.  function _isnt(f) {
   3.    print "this one should fail"
   4.    is(f, 0,1)
   5.  }
```

```awk
   6.  function _any(f,   a,b,i) {
   7.    split("a,b,c,d,e,f",a,",")
   8.    for(i=1;i<=50;i++) b[i]=any(a)
   9.    asort(b)
  10.    is(f, b[1],1)
  11.  }
```
