---
title: zeror.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# zeror.fun
## Zero-R Classifier

Uses:  "[funny](funny)"<br>
Uses:  "[tbl](tbl)"<br>

```awk
   1.  function ZeroR(i) {
   2.    has(i,"tbl","Tbl") 
   3.  }
```

```awk
   4.  function ZeroRTrain(i,r,lst) { 
   5.    Tbl1(i.tbl, r, lst) 
   6.  }
   7.  function ZeroRClassify(i,r,lst,x) {
   8.    return  i.tbl.cols[ i.tbl.my.class ].mode
   9.  }
```
