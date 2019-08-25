#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"


## Software project estimation and risk calculations


function Factors(i) {
  table(i,6,",   1,     2,   3,    4,    5,    6," \
			"em  ,    vl,     l,   n,    h,   vh,   xh," \
			"time,      ,     , 1.00, 1.11, 1.29, 1.63," \
			"stor,      ,     , 1.00, 1.05, 1.17, 1.46," \
			"data,      , 0.90, 1.00, 1.14, 1.28,     ," \
			"pvol,      , 0.87, 1.00, 1.15, 1.30,     ," \
			"ruse,  0.95, 1.00, 1.07, 1.15, 1.24,     ," \
			"rely,  0.82, 0.92, 1.00, 1.10, 1.26,     ," \
			"docu,  0.81, 0.91, 1.00, 1.11, 1.23,     ," \
			"acap,  1.42, 1.19, 1.00, 0.85, 0.71,     ," \
			"pcap,  1.34, 1.15, 1.00, 0.88, 0.76,     ," \
			"pcon,  1.29, 1.12, 1.00, 0.90, 0.81,     ," \
			"aexp,  1.22, 1.10, 1.00, 0.88, 0.81,     ," \
			"plex,  1.19, 1.09, 1.00, 0.91, 0.85,     ," \
			"ltex,  1.20, 1.09, 1.00, 0.91, 0.84,     ," \
			"tool,  1.17, 1.09, 1.00, 0.90, 0.78,     ," \
			"sced,  1.43, 1.14, 1.00, 1.00, 1.00,     ," \
			"cplx,  0.73, 0.87, 1.00, 1.17, 1.34, 1.74," \
			"site,  1.22, 1.09, 1.00, 0.93, 0.86, 0.80 " )
}
 
function table(t,m,s,   a,n,j,k) {
   n=split(s,a,/[ \t]*,[[ \t]*/)
   while(j<n) {
     j++
     key= a[j]
     for(k=1; k<=m; k++) {
       j++
       t[key][k-1] = a[j] ~ i.cocomo.num ? a[j]+0 : a[j]  }}}
}

function Effort(i) { return i.a* i.ksloc^(i.b + 0.01*sfs()) *  ems(i) }

function ems(i,    j,tmp) {
  tmp = 1
	for(j in i.em) tmp *= i.tune[ i.val.em[j] ]]
  return tmp
}

#tune()i)*rely(i)*Data(i)*Cplx(i)*\Ruse(i)*Docu(i)*Time(i)*\Stor(i)*Pvol(i)*Acap(i)*\Pcap(i)*Pcon(i)*Aexp(i)*\Plex(i)*Ltex(i)*Tool(i)*\Site(i);
}
function sfs(i,    j,tmp) { 
  for( j in i.sf ) tmp += i.tune[ i.val.sf[j] ]
  return tmp
}
