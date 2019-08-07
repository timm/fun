#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- --

## Rules of Fun

Objects are called `i`.

Object attributes are accessed with a ".". Accessors can be nestedE.g. `i.num.sd`

- "." is a reserved characters. Outside of numbers and accessors, if you need a "." (e.g. in a filename)
  then use the `DOT` variable (which is a string containing ".").

Functions with leading uppercase letters are methods.

Methods with only one uppercase letter are constructors e.g. `Num`.

Constructors initialize themselves with superclass attributes by calling the supper; e.g.

#!class [Col|name;pos;n = 0]^-[Num|mu = 0;sum=0]

function Col(i,name,pos) {
  i.n   = 0
  i.name= name
  i.pos = pos
}
function Num(i,name,pos) {
  Col(i,name,pos)
  i.mu = i.sum = 0 
}

Methods ending in "1" are for adding one new thing into an object and, usually, return the added thing
(it if is a string or number).  e.g.

function Num1(i, x) {
  i.sum += x
  i.n += 1
  i.mu = i.sum/i.n
  return x
}


