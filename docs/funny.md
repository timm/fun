---
title: funny.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [index](/fun/index) | [about](/fun/ABOUT) | [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019 Tim Menzies. http://menzies.us</em>

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
  51.  function median(l,    m,n,l1) {
  52.    n = length(l)
  53.    m = int(n/2)
  54.    l1 = l[m+1]
  55.    return (n % 2) ? l1 : (l[m] + l1)/2
  56.  }
```

```awk
  57.  function push(x,i) { x[length(x)+1]=i; return i }
```

```awk
  58.  function pash(x,f)      { has(x,length(x)+1,f) }
  59.  function pash1(x,f,m)   { has1(x,length(x)+1,f,m) }
  60.  function pash2(x,f,m,n) { has2(x,length(x)+1,f,m,n) }
```

```awk
  61.  function become(b4,new,     i) {
  62.    List(new)
  63.    for(i in b4) new[i] = b4[i]
  64.  }
  65.  function ksort(lst,k) {
  66.    KSORT=k
  67.    asort(lst,lst,"kcompare")
  68.  }
  69.  function kcompare(i1,v1,i2,v2,  l,r) {
  70.    l = v1[KSORT] +0
  71.    r = v2[KSORT] +0
  72.    if (l < r) return -1
  73.    if (l == r) return 0
  74.    return 1
  75.  }  
```
# ---------------------------------
# testing
```awk
  76.  function rogues(    s) {
  77.    for(s in SYMTAB) if (s ~ /^[A-Z][a-z]/) print "Global " s
  78.    for(s in SYMTAB) if (s ~ /^[_a-z]/    ) print "Rogue: " s
  79.  }
```

```awk
  80.  function tests(what, all,   one,a,i,n) {
  81.    n = split(all,a,",")
  82.    print "\n#--- " what " -----------------------"
  83.    for(i=1;i<=n;i++) { one = a[i]; @one(one) }
  84.    rogues()
  85.  }
```

```awk
  86.  function is(f,got,want,   epsilon,     ok) {
  87.    if (typeof(want) == "number") {
  88.       epsilon = epsilon ? epsilon : 0.001
  89.       ok = abs(want - got)/(want + 10^-32)  < epsilon
  90.    } else
  91.       ok = want == got
  92.    if (ok) 
  93.      print "#TEST:\tPASSED\t" f "\t" want "\t" got 
  94.    else 
  95.      print "#TEST:\tFAILED\t" f "\t" want "\t" got 
  96.  }
```

# ---------------------------------
# object constructors
```awk
  97.  function List(i)         { split("",i,"") }
  98.  function zap(i,k)        { i[k][0]; List(i[k])} 
  99.  function Object(i)       { List(i); i["oid"]=++OID }
 100.  
 101.  function has( i,k,f)     { f=f?f:"List"; zap(i,k); @f(i[k]) }
 102.  function has1(i,k,f,m)   {               zap(i,k); @f(i[k],m) }
 103.  function has2(i,k,f,m,n) {               zap(i,k); @f(i[k],m,n) }
 104.  
```
