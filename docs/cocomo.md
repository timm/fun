---
title: cocomo.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# cocomo.fun
Uses:  "[funny](funny)"<br>


## Software project estimation and risk calculations


```awk
   1.  function Factors(i) {
   2.    table(i,6,",   1,     2,   3,    4,    5,    6," \
   3.  			"em  ,    vl,     l,   n,    h,   vh,   xh," \
   4.  			"time,      ,     , 1.00, 1.11, 1.29, 1.63," \
   5.  			"stor,      ,     , 1.00, 1.05, 1.17, 1.46," \
   6.  			"data,      , 0.90, 1.00, 1.14, 1.28,     ," \
   7.  			"pvol,      , 0.87, 1.00, 1.15, 1.30,     ," \
   8.  			"ruse,  0.95, 1.00, 1.07, 1.15, 1.24,     ," \
   9.  			"rely,  0.82, 0.92, 1.00, 1.10, 1.26,     ," \
  10.  			"docu,  0.81, 0.91, 1.00, 1.11, 1.23,     ," \
  11.  			"acap,  1.42, 1.19, 1.00, 0.85, 0.71,     ," \
  12.  			"pcap,  1.34, 1.15, 1.00, 0.88, 0.76,     ," \
  13.  			"pcon,  1.29, 1.12, 1.00, 0.90, 0.81,     ," \
  14.  			"aexp,  1.22, 1.10, 1.00, 0.88, 0.81,     ," \
  15.  			"plex,  1.19, 1.09, 1.00, 0.91, 0.85,     ," \
  16.  			"ltex,  1.20, 1.09, 1.00, 0.91, 0.84,     ," \
  17.  			"tool,  1.17, 1.09, 1.00, 0.90, 0.78,     ," \
  18.  			"sced,  1.43, 1.14, 1.00, 1.00, 1.00,     ," \
  19.  			"cplx,  0.73, 0.87, 1.00, 1.17, 1.34, 1.74," \
  20.  			"site,  1.22, 1.09, 1.00, 0.93, 0.86, 0.80 " )
  21.  }
```
 
```awk
  22.  function table(t,m,s,   a,n,j,k) {
  23.     n=split(s,a,/[ \t]*,[[ \t]*/)
  24.     while(j<n) {
  25.       j++
  26.       key= a[j]
  27.       for(k=1; k<=m; k++) {
  28.         j++
  29.         t[key][k-1] = a[j] ~ i.cocomo.num ? a[j]+0 : a[j]  }}}
  30.  }
```

```awk
  31.  function Effort(i) { return i.a* i.ksloc^(i.b + 0.01*sfs()) *  ems(i) }
```

```awk
  32.  function ems(i,    j,tmp) {
  33.    tmp = 1
  34.  	for(j in i.em) tmp *= i.tune[ i.val.em[j] ]]
  35.    return tmp
  36.  }
```

#tune()i)*rely(i)*Data(i)*Cplx(i)*\Ruse(i)*Docu(i)*Time(i)*\Stor(i)*Pvol(i)*Acap(i)*\Pcap(i)*Pcon(i)*Aexp(i)*\Plex(i)*Ltex(i)*Tool(i)*\Site(i);
}
```awk
  37.  function sfs(i,    j,tmp) { 
  38.    for( j in i.sf ) tmp += i.tune[ i.val.sf[j] ]
  39.    return tmp
  40.  }
```
