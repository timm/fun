---
title: numsok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/ABOUT">doc</a></button>   <button class="button button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button2"><a href="/fun/license">license</a></button> <br>



# numsok.fun

Uses:  "[funny](funny)"<br>
Uses:  "[nums](nums)"<br>

```awk
   1.  BEGIN {  tests("numok","_nums") }
```

```awk
   2.  func _nums(f,     a,i,k) {
   3.    srand(1)
   4.    for(i=1;i<=100;i+= 1)  
   5.      a[i] = rand()
   6.    for(k=1; k<=1.5; k+=0.05) 
   7.       _num1(a,k)
   8.  }
```

```awk
   9.  func _num1(a,k,    i,na,nk,s) {
  10.    Num(na)
  11.    Num(nk)
  12.    for(i in a) 
  13.       Num1(nk, 
  14.            k * Num1(na, a[i]))
  15.    Nums(s)
  16.    print("k",k,
  17.           "\tsigDifferent",ttest(na,nk,s),
  18.           "notSmallEffect",hedges(na,nk,s), 
  19.           "and", diff(na,nk))
  20.  }
```
