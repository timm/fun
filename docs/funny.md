---
title: funny.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button1"><a href="/fun/INSTALL">install</a></button>   <button class="button button2"><a href="/fun/ABOUT">doc</a></button>   <button class="button button1"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button2"><a href="/fun/license">license</a></button> <br>



# funny.fun
# ---------------------------------
# misc

```awk
   1.  BEGIN{  DOT=sprintf("%c",46)}
```

```awk
   2.  function Xy(i,x,y) {
   3.     i.x = x
   4.     i.y = y
   5.  }
   6.  function trim(s) {
   7.    gsub(/^[ \t\r]*/,"",s)
   8.    gsub(/[ \t\r]*$/,"",s)
   9.    return s
  10.  }
  11.  function lines(i,update,f,sep,  r,line,lst,com) {
  12.    f   = f ? f : "/dev/stdin"
  13.    sep = sep ? sep : "[ \t]*,[ \t]*"
  14.    com = "#"DOT"*"
  15.    while((getline line < f) > 0) {
  16.      sub(com,"",line)
  17.      line=trim(line)
  18.      if (line) { 
  19.        split(line,lst,sep)
  20.        @update(i,++r,lst) }
  21.    }
  22.    close(f)
  23.  } 
  24.  function flat(x,  cols, s,i,sep) {
  25.    ooSortOrder(x)
  26.    if (isarray(cols)) 
  27.      for(i in cols) {s= s sep x[i]; sep="\t"}
  28.    else
  29.      for(i in x) {s= s sep x[i]; sep="\t"}
  30.    return s
  31.  }
  32.  function oo(x,p,pre, i,txt) {
  33.    txt = pre ? pre : (p DOT)
  34.    ooSortOrder(x)
  35.    for(i in x)  {
  36.      if (isarray(x[i]))   {
  37.        print(txt i"" )
  38.        oo(x[i],"","|  " pre)
  39.      } else
  40.        print(txt i (x[i]==""?"": ": " x[i]))
  41.  }}
  42.  function ooSortOrder(x, i) {
  43.    for (i in x)
  44.      return PROCINFO["sorted_in"] =\
  45.        typeof(i+1)=="number" ? "@ind_num_asc" : "@ind_str_asc"
  46.  }
```
# ---------------------------------
```awk
  47.  function abs(x)  { return x < 0 ? -1*x : x }
  48.  function any(x)  { return 1+int(rand()*length(x)) }
```

```awk
  49.  function max(x,y) { return x>y ? x : y }
  50.  function min(x,y) { return x<y ? x : y }
```

```awk
  51.  function gt(x,y)  { return x > y }
  52.  function lt(x,y)  { return x < y }
```

```awk
  53.  function median(l,    m,n,l1) {
  54.    n = length(l)
  55.    m = int(n/2)
  56.    l1 = l[m+1]
  57.    return (n % 2) ? l1 : (l[m] + l1)/2
  58.  }
```

```awk
  59.  function triangle(a,c,b,   u) {
  60.    u = rand()
  61.    if (u < (c-a)/(b-a))
  62.      return a + (    u*(b-a)*(c-a))^0.5
  63.    else
  64.      return b - ((1-u)*(b-a)*(b-c))^0.5
  65.  }
  66.  function bsearch(lst,x,approx,lt,gt,
  67.                   lo,mid,hi,val) {
  68.    lo = 1
  69.    hi = length(lst)
  70.    lt = lt ? lt : "lt"
  71.    gt = gt ? gt : "gt"
  72.    while (lo <= hi) {
  73.      mid = int(lo + (hi - lo) / 2)
  74.      val = lst[mid]
  75.      if     (@gt(val,x)) hi = mid - 1
  76.      else if(@lt(val,x)) lo = mid + 1
  77.      else return mid
  78.    }
  79.    return approx ? mid : notFound()
  80.  }
```


```awk
  81.  function push(x,i) { x[length(x)+1]=i; return i }
```

```awk
  82.  function pash(x,f)      { has(x,length(x)+1,f) }
  83.  function pash1(x,f,m)   { has1(x,length(x)+1,f,m) }
  84.  function pash2(x,f,m,n) { has2(x,length(x)+1,f,m,n) }
```

```awk
  85.  function become(b4,new,     i) {
  86.    List(new)
  87.    for(i in b4) new[i] = b4[i]
  88.  }
  89.  function ksort(lst,k) {
  90.    KSORT=k
  91.    asort(lst,lst,"kcompare")
  92.  }
  93.  function kcompare(i1,v1,i2,v2,  l,r) {
  94.    l = v1[KSORT] +0
  95.    r = v2[KSORT] +0
  96.    if (l < r) return -1
  97.    if (l == r) return 0
  98.    return 1
  99.  }  
```
# ---------------------------------
# testing
```awk
 100.  function rogues(    s) {
 101.    for(s in SYMTAB) if (s ~ /^[A-Z][a-z]/) print "Global " s
 102.    for(s in SYMTAB) if (s ~ /^[_a-z]/    ) print "Rogue: " s
 103.  }
```

```awk
 104.  function tests(what, all,   one,a,i,n) {
 105.    n = split(all,a,",")
 106.    print "\n#--- " what " -----------------------"
 107.    for(i=1;i<=n;i++) { one = a[i]; @one(one) }
 108.    rogues()
 109.  }
```

```awk
 110.  function is(f,got,want,   epsilon,     ok) {
 111.    if (typeof(want) == "number") {
 112.       epsilon = epsilon ? epsilon : 0.001
 113.       ok = abs(want - got)/(want + 10^-32)  < epsilon
 114.    } else
 115.       ok = want == got
 116.    if (ok) 
 117.      print "#TEST:\tPASSED\t" f "\t" want "\t" got 
 118.    else 
 119.      print "#TEST:\tFAILED\t" f "\t" want "\t" got 
 120.  }
```

# ---------------------------------
# object constructors
```awk
 121.  function List(i)         { split("",i,"") }
 122.  function zap(i,k)        { i[k][0]; List(i[k])} 
 123.  function Object(i)       { List(i); i["oid"]=++OID }
 124.  
 125.  function has( i,k,f)     { f=f?f:"List"; zap(i,k); @f(i[k]) }
 126.  function has1(i,k,f,m)   {               zap(i,k); @f(i[k],m) }
 127.  function has2(i,k,f,m,n) {               zap(i,k); @f(i[k],m,n) }
 128.  
```
