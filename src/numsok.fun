#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "nums"

BEGIN {  tests("numok","_nums") }

func _nums(f,     a,i,k) {
  srand(1)
  for(i=1;i<=100;i+= 1)  
    a[i] = rand()
  for(k=1; k<=1.5; k+=0.05) 
     _num1(a,k)
}

func _num1(a,k,    i,na,nk,s) {
  Num(na)
  Num(nk)
  for(i in a) 
     Num1(nk, 
          k * Num1(na, a[i]))
  Nums(s)
  print("k",k,
         "\tsigDifferent",ttest(na,nk,s),
         "notSmallEffect",hedges(na,nk,s), 
         "and", diff(na,nk))
}
