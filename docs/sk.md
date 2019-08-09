---
title: sk.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# sk.fun
Uses:  "[funny](funny)"<br>
Uses:  "[nums](nums)"<br>

#/class [Array1]-.-[note: sk(){bg:cornsilk}]]-.-[Array2]

```awk
   1.  function testStatistic(i,j) { 
   2.     return (j.mu - i.mu) / (i.sd/i.n + j.sd/j.n)^0.5 }
   3.  
   4.  function sample(a,b,w) { for(w in a) b[w] = a[any(a)] }
   5.  
   6.  function bootstrap(y0,z0,   
   7.                    x,y,z,tobs,w,b,yhat,zhat,y1,z1,ynum,znum,big) {
   8.    nums(x,y0)
   9.    nums(x,z0)
  10.    nums(y,y0)
  11.    nums(z,z0)
  12.    tobs = testStatistic(y,z)
  13.    for(w in y0) yhat[w]= y0[w]- y.mu + x.mu 
  14.    for(w in z0) zhat[w]= z0[w]- z.mu + x.mu 
  15.    b = THE.sk.b
  16.    for(w=1; w<=b; w++) {
  17.      sample(yhat, y1) 
  18.      nums(ynum,   y1)
  19.      sample(zhat, z1) 
  20.      nums(znum,   z1)
  21.      big +=  testStatistic(ynum,znum) > tobs
  22.    }
  23.    print big,b,THE.sk.conf
  24.    return big / b < THE.sk.conf
  25.  }
```

```awk
  26.  function cliffsDelta(a1,a2,
  27.                       a3, m,n,j,x,lo,hi,lt,gt,k) {
  28.    n= asort(a2, a3)
  29.    for(k in a1) {
  30.      x= a1[k]
  31.      lo= hi= bsearch(a3,x,1)
  32.      while(lo >= 1 && a3[lo] >= x) lo--
  33.      while(hi <= n && a3[hi] <= x) hi++
  34.      lt += n - hi + 1
  35.      gt += lo 
  36.    }
  37.    m = length(a1)*length(a2)
  38.    return abs(gt - lt) / m > THE.sk.cliffs
  39.  }
```

```awk
  40.  BEGIN{rogues()}
```
