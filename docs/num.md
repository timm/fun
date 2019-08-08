---
title: num.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# num.fun
```awk
@include "funny"
@include "col"
```


The `Num` class incrementally  maintains the mean and standard
deviation of the numbers seen in a column.

```awk
function Num(i,c,v) {
  Col(i,c,v)
  i.n  = i.mu = i.m2 = i.sd = 0
  i.lo = 10^32 
  i.hi = -1*i.lo
  i.add ="Num1" 
}
function Num1(i,v,    d) {
  v += 0
  i.n++
  i.lo  = v < i.lo ? v : i.lo
  i.hi  = v > i.hi ? v : i.hi
  d     = v - i.mu
  i.mu += d/i.n
  i.m2 += d*(v - i.mu)
  i.sd  = NumSd0(i)
  return v
}
```

```awk
function NumSd0(i) {
  if (i.m2 < 0) return 0
  if (i.n < 2)  return 0
  return  (i.m2/(i.n - 1))^0.5
}
```

Also maintained is the lowest and highest number seen so far. With
that information we can normalize numbers zero to one.

```awk
function NumNorm(i,x) {
  return (x - i.lo) / (i.hi - i.lo + 10^-32)
}
```

If done carefully, it is also possible to incrementally decrement
these numbers.  Be wary of using the following when `i.n` is less
than, say, 5 to 10 and the total sum of the remaining numbers is small.

```awk
function NumLess(i,v, d) {
  if (i.n < 2) {i.sd=0; return v}
  i.n  -= 1
  d     = v - i.mu
  i.mu -= d/i.n
  i.m2 -= d*(v - i.mu)
  i.sd  = NumSd0(i)
  return v
}
```

To sample from `Num`, we assume that its numbers are like a 
a normal bell-shaped curve. If so,  then
the [Marsaglia function](https://people.maths.ox.ac.uk/gilesm/mc/mc/lec1.pdf)
can do the sampling:

```awk
function NumAny(i,  x) { 
  x=sqrt(-2*log(rand()))*cos(6.2831853*rand())
  return i.m + i.sd * x 
}
```



# 
# function Stats(i) {
#   new(i)
#   i.conf  = 95
#   i.small = 0.38 # 1.0 = medium
#   i.first = 3
#   i.last  = 98
#   # -- 95% --------------------------
#   i[95][ 3]= 3.182; i[95][ 6]= 2.447; 
#   i[95][12]= 2.179; i[95][24]= 2.064; 
#   i[95][48]= 2.011; i[95][98]= 1.985; 
#   # -- 99% --------------------------
#   i[99][ 3]= 5.841; i[99][ 6]= 3.707; 
#   i[99][12]= 3.055; i[99][24]= 2.797; 
#   i[99][48]= 2.682; i[99][98]= 2.625; 
# }
# function diff(x,y,      s) { 
#   Stats(s)
#   return hedges(x,y,s) && ttest(x,y,s)
# }
# function hedges(x,y,s,   nom,denom,sp,g,c) {
#   # from https://goo.gl/w62iIL
#   nom   = (x.n - 1)*x.sd^2 + (y.n - 1)*y.sd^2
#   denom = (x.n - 1)        + (y.n - 1)
#   sp    = sqrt( nom / denom )
#   g     = abs(x.mu - y.mu) / sp  
#   c     = 1 - 3.0 / (4*(x.n + y.n - 2) - 1)
#   return g * c > s.small
# }
# function ttest(x,y,s,    t,a,b,df,c) {
#   # debugged using https://goo.gl/CRl1Bz
#   t  = (x.mu - y.mu) / sqrt(max(10^-64,
#                                 x.sd^2/x.n + y.sd^2/y.n ))
#   a  = x.sd^2/x.n
#   b  = y.sd^2/y.n
#   df = (a + b)^2 / (10^-64 + a^2/(x.n-1) + b^2/(y.n - 1))
#   c  = ttest1(s, int( df + 0.5 ), s.conf)
#   return abs(t) > c
# }
# function ttest1(s,df,conf,   n1,n2,old,new,c) {
#   if (df < s.first) 
#     return s[conf][s.first]
#   for(n1 = s.first*2; n1 < s.last; n1 *= 2) {
#     n2 = n1*2
#     if (df >= n1 && df <= n2) {
#       old = s[conf][n1]
#       new = s[conf][n2]
#       return old + (new-old) * (df-n1)/(n2-n1)
#   }}
#   return s[conf][s.last]
# }
