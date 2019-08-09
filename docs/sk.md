---
title: sk.fun
---



| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# sk.fun
```awk
   1.  @include "funny"
   2.  @include "nums"
```

#/class [Array1]-.-[note: sk(){bg:cornsilk}]]-.-[Array2]

```awk
   3.  function testStatistic(i,j) { 
   4.     return (j.mu - i.mu) / (i.sd/i.n + j.sd/j.n)^0.5 }
   5.  
   6.  function sample(a,b,w) { for(w in a) b[w] = a[any(a)] }
   7.  
   8.  function bootstrap(y0,z0,   
   9.                    x,y,z,tobs,w,b,yhat,zhat,y1,z1,ynum,znum,big) {
  10.    nums(x,y0)
  11.    nums(x,z0)
  12.    nums(y,y0)
  13.    nums(z,z0)
  14.    tobs = testStatistic(y,z)
  15.    for(w in y0) yhat[w]= y0[w]- y.mu + x.mu 
  16.    for(w in z0) zhat[w]= z0[w]- z.mu + x.mu 
  17.    b = THE.sk.b
  18.    for(w=1; w<=b; w++) {
  19.      sample(yhat, y1) 
  20.      nums(ynum,   y1)
  21.      sample(zhat, z1) 
  22.      nums(znum,   z1)
  23.      big +=  testStatistic(ynum,znum) > tobs
  24.    }
  25.    print big,b,THE.sk.conf
  26.    return big / b < THE.sk.conf
  27.  }
```

```awk
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
