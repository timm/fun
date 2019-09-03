#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

## Compute classifier  performance measures

@include "funny"

To use this code:

1. Create an `Abcd` object.
2. Run your classifier on a test suite. Take the `predicted` and `actual` classification and throw it a `Abcd1`.
3. After that, get  a report using `AbcdReport`.

For example suppose:

- Six times, `yes` objects are predicted to be `yes`;
- Twice, a `no` obect is rpedicted to be `no`;
- Five times, `maybe`s are called `maybe`s;
- And once, a `maybe` is called `no`.

After all that,  `AbcdReport` would print:

```
    db |    rx |   num |     a |     b |     c |     d |  acc |  pre |   pd |   pf |    f |    g | class
  ---- |  ---- |  ---- |  ---- |  ---- |  ---- |  ---- | ---- | ---- | ---- | ---- | ---- | ---- |-----
  data |    rx |    14 |    11 |       |     1 |     2 | 0.93 | 0.67 | 1.00 | 0.08 | 0.80 | 0.96 | no
  data |    rx |    14 |     8 |       |       |     6 | 0.93 | 1.00 | 1.00 | 0.00 | 1.00 | 1.00 | yes
  data |    rx |    14 |     8 |     1 |       |     5 | 0.93 | 1.00 | 0.83 | 0.00 | 0.91 | 0.91 | maybe
```

function Abcd(i, data,rx)  {
  Object(i)
  has(i,"known")
  has(i,"a")
  has(i,"b")
  has(i,"c")
  has(i,"d")
  i.rx   = rx==""? "rx" : rx
  i.data = data==""? "data" : data
  i.yes  = i.no = 0
}

function Abcd1(i,actual, predicted,   x) {
  if (++i.known[actual]    == 1) i.a[actual]   = i.yes + i.no 
  if (++i.known[predicted] == 1) i.a[predicted]= i.yes + i.no 
  actual == predicted ? i.yes++ : i.no++ 
  for (x in i.known) 
    if (actual == x) 
      actual == predicted ? i.d[x]++ : i.b[x]++
    else 
      predicted == x      ? i.c[x]++ : i.a[x]++
}

function AbcdReport(i,   
                    x,p,q,r,s,ds,pd,pf,
                    pn,prec,g,f,acc,a,b,c,d) {
  p = " %4.2f"
  q = " %4s"
  r = " %5s"
  s = " |"
  ds= "----"
  printf(r s r s r s r s r s r s r s q s q s q s q s q s q s " class\n",
        "db","rx","num","a","b","c","d","acc","pre","pd","pf","f","g")
  printf(r  s r s r s r s r s r s r s q s q s q s q s q s q s "-----\n",
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
  printf(r s    r s  r s        r s r s r s r s p s p s  p s p s p s p s  " %s\n",
         i.data,i.rx,i.yes+i.no,a,  b,  c,  d,  acc,prec,pd, pf, f,  g,  x)
}}

