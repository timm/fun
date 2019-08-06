#!/usr/bin/env ./fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :

# ---------------------------------
# misc

BEGIN{  DOT=sprintf("%c",46)}

function trim(s) {
  gsub(/^[ \t\r]*/,"",s)
  gsub(/[ \t\r]*$/,"",s)
  return s
}
function lines(i,update,f,sep,  r,line,lst,com) {
  f   = f ? f : "/dev/stdin"
  sep = sep ? sep : "[ \t]*,[ \t]*"
  com = "#"DOT"*"
  while((getline line < f) > 0) {
    sub(com,"",line)
    line=trim(line)
    if (line) {
      split(line,lst,sep)
      @update(i,++r,lst) }
  }
  close(f)
} 
function flat(x,  cols, s,i,sep) {
  ooSortOrder(x)
  if (isarray(cols)) 
    for(i in cols) {s= s sep x[i]; sep="\t"}
  else
    for(i in x) {s= s sep x[i]; sep="\t"}
  return s
}
function oo(x,p,pre, i,txt) {
  txt = pre ? pre : (p DOT)
  ooSortOrder(x)
  for(i in x)  {
    if (isarray(x[i]))   {
      print(txt i"" )
      oo(x[i],"","|  " pre)
    } else
      print(txt i (x[i]==""?"": ": " x[i]))
}}

function ooSortOrder(x, i) {
  for (i in x)
    return PROCINFO["sorted_in"] =\
      typeof(i+1)=="number" ? "@ind_num_asc" : "@ind_str_asc"
}
# ---------------------------------
function any(x)  { return 1+int(rand()*length(x)) }

function become(x,y,     i) {
  List(x)
  for(i in y) x[i] = y[i]
}
function ksort(lst,k) {
  KSORT=k
  asort(lst,lst,"kcompare")
}
function kcompare(i1,v1,i2,v2,  l,r) {
  l = v1[KSORT]
  r = v2[KSORT]
  if (l < r) return -1
  if (l == r) return 0
  return 1
}  
# ---------------------------------
# testing
function rogues(    s) {
  for(s in SYMTAB) if (s ~ /^[A-Z][a-z]/) print "Global " s
  for(s in SYMTAB) if (s ~ /^[_a-z]/    ) print "Rogue: " s
}

function tests(what, all,   one,a,i,n) {
  n = split(all,a,",")
  print "\n#--- " what " -----------------------"
  for(i=1;i<=n;i++) { one = a[i]; @one(one) }
  rogues()
}

function is(f,got,want) {
  if (want == got) 
    print "#TEST:\tPASSED\t" f "\t" want "\t" got 
  else 
    print "#TEST:\tFAILED\t" f "\t" want "\t" got 
}

# ---------------------------------
# object constructors
function List(i)         { split("",i,"") }
function zap(i,k)        { i[k][0]; List(i[k])} 
function Object(i)       { List(i); i["oid"]=++OID }

function has( i,k,f)     { f=f?f:"List"; zap(i,k); @f(i[k]) }
function has1(i,k,f,m)   {               zap(i,k); @f(i[k],m) }
function has2(i,k,f,m,n) {               zap(i,k); @f(i[k],m,n) }

