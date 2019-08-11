---
title: funny.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# funny.fun
## Misc utilities.

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
  15.    print("f",f,"sep",sep,"com",com)
  16.    while((getline line < f) > 0) {
  17.      sub(com,"",line)
  18.      line=trim(line)
  19.      if (line) { 
  20.        split(line,lst,sep)
  21.        @update(i,++r,lst) }
  22.    }
  23.    close(f)
  24.  } 
  25.  function flat(x,  cols, s,i,sep) {
  26.    ooSortOrder(x)
  27.    if (isarray(cols)) 
  28.      for(i in cols) {s= s sep x[i]; sep="\t"}
  29.    else
  30.      for(i in x) {s= s sep x[i]; sep="\t"}
  31.    return s
  32.  }
  33.  function oo(x,p,pre, i,txt) {
  34.    txt = pre ? pre : (p DOT)
  35.    ooSortOrder(x)
  36.    for(i in x)  {
  37.      if (isarray(x[i]))   {
  38.        print(txt i"" )
  39.        oo(x[i],"","|  " pre)
  40.      } else
  41.        print(txt i (x[i]==""?"": ": " x[i]))
  42.  }}
  43.  function ooSortOrder(x, i) {
  44.    for (i in x)
  45.      return PROCINFO["sorted_in"] =\
  46.        typeof(i+1)=="number" ? "@ind_num_asc" : "@ind_str_asc"
  47.  }
```
# ---------------------------------
```awk
  48.  function abs(x)  { return x < 0 ? -1*x : x }
  49.  function any(x)  { return 1+int(rand()*length(x)) }
```

```awk
  50.  function max(x,y) { return x>y ? x : y }
  51.  function min(x,y) { return x<y ? x : y }
```

```awk
  52.  function gt(x,y)  { return x > y }
  53.  function lt(x,y)  { return x < y }
```

```awk
  54.  function median(l,    m,n,l1) {
  55.    n = length(l)
  56.    m = int(n/2)
  57.    l1 = l[m+1]
  58.    return (n % 2) ? l1 : (l[m] + l1)/2
  59.  }
```

```awk
  60.  function triangle(a,c,b,   u) {
  61.    u = rand()
  62.    if (u < (c-a)/(b-a))
  63.      return a + (    u*(b-a)*(c-a))^0.5
  64.    else
  65.      return b - ((1-u)*(b-a)*(b-c))^0.5
  66.  }
  67.  function bsearch(lst,x,approx,lt,gt,
  68.                   lo,mid,hi,val) {
  69.    lo = 1
  70.    hi = length(lst)
  71.    lt = lt ? lt : "lt"
  72.    gt = gt ? gt : "gt"
  73.    while (lo <= hi) {
  74.      mid = int(lo + (hi - lo) / 2)
  75.      val = lst[mid]
  76.      if     (@gt(val,x)) hi = mid - 1
  77.      else if(@lt(val,x)) lo = mid + 1
  78.      else return mid
  79.    }
  80.    return approx ? mid : notFound()
  81.  }
```


```awk
  82.  function push(x,i) { x[length(x)+1]=i; return i }
```

```awk
  83.  function pash(x,f)      { has(x,length(x)+1,f) }
  84.  function pash1(x,f,m)   { has1(x,length(x)+1,f,m) }
  85.  function pash2(x,f,m,n) { has2(x,length(x)+1,f,m,n) }
```

```awk
  86.  function become(b4,new,     i) {
  87.    List(new)
  88.    for(i in b4) new[i] = b4[i]
  89.  }
  90.  function ksort(lst,k) {
  91.    KSORT=k
  92.    asort(lst,lst,"kcompare")
  93.  }
  94.  function kcompare(i1,v1,i2,v2,  l,r) {
  95.    l = v1[KSORT] +0
  96.    r = v2[KSORT] +0
  97.    if (l < r) return -1
  98.    if (l == r) return 0
  99.    return 1
 100.  }  
```
# ---------------------------------
# testing
```awk
 101.  function rogues(    s) {
 102.    for(s in SYMTAB) if (s ~ /^[A-Z][a-z]/) print "Global " s
 103.    for(s in SYMTAB) if (s ~ /^[_a-z]/    ) print "Rogue: " s
 104.  }
```

```awk
 105.  function tests(what, all,   one,a,i,n) {
 106.    n = split(all,a,",")
 107.    print "\n#--- " what " -----------------------"
 108.    for(i=1;i<=n;i++) { one = a[i]; @one(one) }
 109.    rogues()
 110.  }
```

```awk
 111.  function is(f,got,want,   epsilon,     ok) {
 112.    if (typeof(want) == "number") {
 113.       epsilon = epsilon ? epsilon : 0.001
 114.       ok = abs(want - got)/(want + 10^-32)  < epsilon
 115.    } else
 116.       ok = want == got
 117.    if (ok) 
 118.      print "#TEST:\tPASSED\t" f "\t" want "\t" got 
 119.    else 
 120.      print "#TEST:\tFAILED\t" f "\t" want "\t" got 
 121.  }
```

# ---------------------------------
# object constructors
```awk
 122.  function List(i)         { split("",i,"") }
 123.  function zap(i,k)        { i[k][0]; List(i[k])} 
 124.  function Object(i)       { List(i); i["oid"]=++OID }
 125.  
 126.  function has( i,k,f)     { f=f?f:"List"; zap(i,k); @f(i[k]) }
 127.  function has1(i,k,f,m)   {               zap(i,k); @f(i[k],m) }
 128.  function has2(i,k,f,m,n) {               zap(i,k); @f(i[k],m,n) }
 129.  
```
