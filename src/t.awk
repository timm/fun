BEGIN {

l[1]["a"]=1
l[1]["b"]=2
l[1]["s"]=10

l[2]["a"]=10
l[2]["b"]=20
l[2]["s"]=20

l[3]["a"]=100
l[3]["b"]=200
l[3]["s"]=5

asort(l,tt,"rcompare")
l[1]["a"] = 10000
tt[1]["a"]= 200000
oo(l)
oo(tt)
}


function rcompare(i1,v1,i2,v2,  l,r) {
  l = v1["s"]
  r = v2["s"]
  if (l <  r) return  -1
  if (l == r) return   0
  return 1
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

