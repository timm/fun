#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "fun"

function Abcd(i, data,rx)  {
  Object(i)
  has(i,"known")
  has(i,"a")
  has(i,"b")
  has(i,"c")
  has(i,"d")
  i.rx= rx==""? "rx" : rx
  i.date= date==""? "data" : data
  i.yes = i.no = 0
}

function Abcd1(i,want, got) {
  if (++i.known[want] == 1 ) i.a[want] = i.yes + i.no 
  if (++i.known[got]  == 1 ) i.a[got]  = i.yes + i.no 
  want == got ?  i.yes++ : i.no++ 
  for (x in i.known) {
    if (want == x) 
      want == got? i.d[x]++ : i.b[x]++
    else 
      got  == x  ? i.c[x]++ : i.a[x]++
}}

function AbcdReport(i,   out,pd,pf,pn,prec,g,f,acc,a,b,c,d) {
  p = " %3.2f"
  f = " %3s"
  s = "|"
  ds= "---"
  printf(f s f s "%5s" s f s f s f s f s f s f s f s f s f s f s "class\n",
        "db","rx","num","a","b","c","d","acc","pre","pd","pf","f","g")
  printf(f s f s "%5s" s f s f s f s f s f s f s f s f s f s f s "-----\n",
         ds,ds,"----",ds,ds,ds,ds,ds,ds,ds,ds,ds,ds)
  for (x in i.known) {
    pd = pf = pn = prec = g = f = acc = 0
    a = i.a[x]
    b = i.b[x]
    c = i.c[x]
    d = i.d[x]
    if (b+d > 0     ) pd   = d     / (b+d) 
    if (a+c > 0     ) pf   = c     / (a+c) 
    if (a+c > 0     ) pn   = (b+d) / (a+c) 
    if (c+d > 0     ) prec = d     / (c+d) 
    if (1-pf+pd > 0 ) g=2*(1-pf) * pd / (1-pf+pd) 
    if (prec+pd > 0 ) f=2*prec*pd / (prec + pd)   
    if (i.yes + i.no > 0 ) 
       acc  = i.yes / (i.yes + i.no) 
  printf(f s f s "%5s" s p s p s p s p s p s p s p s p s p s p s "%s\n",
         i.db,i.rx,num,a,b,c,d,acc,prec,pd,pf f,g,x)
}}

