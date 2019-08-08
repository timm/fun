#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "nums"

BEGIN {  tests("numok","_nums") }

func _nums(f,     a,i,k) {
  srand()
  Config(THE)
  THE.nums.ttest = 95
  for(i=1;i<=100;i+= 1)  
    a[i] = rand()^2
  for(k=1; k<=1.5; k+=0.05) 
     _num1(a,k)
}

func _num1(a,k,    i,na,nk) {
  Num(na)
  Num(nk)
  for(i in a) {
    Num1(na, a[i])
    Num1(nk, a[i]*k)
  }
  print(k,diff(na,nk))
}
