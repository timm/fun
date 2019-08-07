---
title: about.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

# about.fun

## Rules of Fun

Objects are called `i`.

Functions with leading uppercase letters are methods.

Methods with only one uppercase letter are constructors e.g. `Num`.

Constructors initialize themselves with superclass attributes by calling the supper; e.g.

#!/class [Col|name;pos;n = 0]^-[Num|mu = 0;sum=0]

```awk
function Col(i,name,pos) {
  i.n   = 0
  i.name= name
  i.pos = pos
}
function Num(i,name,pos) {
  Col(i,name,pos)
  i.mu = i.sum = 0 
}
```

Methods ending in "1" are for adding one new thing into an object and, usually, return the added thing
(it if is a string or number).  e.g.

```awk
function Num1(i, x) {
  i.sum += x
  i.n += 1
  i.mu = i.sum/i.n
  return x
}
```




<em> &copy; 2019, Tim Menzies, http://menzies.us</em>
