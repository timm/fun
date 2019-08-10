---
title: sk.fun
---

<<button class="button button1"><a href="/fun/index">index</a></button>   button class="button button2"><a href="/fun/ABOUT">about</a></button>   <button class="button button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button2"><a href="/fun/license">license</a></button> <br>



# sk.fun
Uses:  "[funny](funny)"<br>
Uses:  "[nums](nums)"<br>

#class [Array1]-.-[note: sk(){bg:cornsilk}]]-.-[Array2]

From Chapter 16 of [Efron's text](REFS#efron-1993) on bootstrapping.

```awk
   1.  function testStatistic(i,j) { 
   2.     return abs(j.mu - i.mu) / (i.sd/i.n + j.sd/j.n )^0.5 }
   3.  
   4.  function sample(a,b,w) { for(w in a) b[w] = a[any(a)] }
   5.  
   6.  function bootstrap(y0,z0,   
   7.                    x,y,z,baseline,w,b,yhat,zhat,y1,z1,ynum,znum,strange) {
   8.    nums(x,y0)
   9.    nums(x,z0)
  10.    nums(y,y0)
  11.    nums(z,z0)
  12.    baseline = testStatistic(y,z)
  13.    for(w in y0) yhat[w]= y0[w]- y.mu + x.mu 
  14.    for(w in z0) zhat[w]= z0[w]- z.mu + x.mu 
  15.    b = THE.sk.b
  16.    for(w=1; w<=b; w++) { 
  17.      sample(yhat, y1) 
  18.      nums(ynum,   y1)
  19.      sample(zhat, z1) 
  20.      nums(znum,   z1)
  21.      strange +=  testStatistic(ynum,znum) >=  baseline
  22.    }
  23.    return strange / b < THE.sk.conf / 100
  24.  }
```

```awk
  25.  function distinct(lst1,lst2) {
  26.     return cliffsDelta(lst1,lst2) && bootstrap(lst1,lst2)
  27.  }
  28.  function cliffsDelta(a1,a2,
  29.                       a3, m,n,j,x,lo,hi,lt,gt,k) {
  30.    n= asort(a2, a3)
  31.    for(k in a1) {
  32.      x= a1[k]
  33.      lo= hi= bsearch(a3,x,1)
  34.      while(lo >= 1 && a3[lo] >= x) lo--
  35.      while(hi <= n && a3[hi] <= x) hi++
  36.      lt += n - hi + 1
  37.      gt += lo 
  38.    }
  39.    m = length(a1)*length(a2)
  40.    return abs(gt - lt) / m > THE.sk.cliffs
  41.  }
```

```awk
  42.  BEGIN{rogues()}
```
