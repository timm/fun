#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"
@include "num"

#!class [Nums]1->2[Num], [note: v.fast comparison two Nums (assumes normal bell-shaped curves){bg:cornsilk}]

`Num` incrementally  maintains the mean and standard deviation of
the numbers seen in a column.

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
