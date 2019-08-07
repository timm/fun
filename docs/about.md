---
title: about.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

# about.fun

## F.A.Q.

Why Fun?

- Why not? Inventing your owne language with transpilers is fun!
(Hint: where possible, keep the same
line numbers in the output so errors there can be easily traced abck to your source code.)

Why transpiler to gawk?

- My name is timm and I'm a language-a-holic. Give me Lisp, Python, Prolog, Lua, Julia and I will use
  high-order fucntions, unification, decorators, iterators,
  list comprehensions, metaclasses, macros[^note]
  and I will USE and ABUSE them for days and days and days and ...
- The result is beautiful clever code (IMHO)... that no one else can understand  or use.
- The only treatment I know for my language-ism is to use simpler languages. With those, I soon run out
  net tricks to distract me (at which point, I can finally build useful stuff)

[^note]: In Lisp, Prolog, Python, Lua, Julia

## Rules of Fun

Objects are called `i`.

Object attributes are accessed with a " . ". Accessors can be nestedE.g. `i.num.sd`

- " . " is a reserved characters. Outside of numbers and accessors, if you need a " . " (e.g. in a filename)
  then use the `DOT` variable (which is a string containing " . ").

Functions with leading uppercase letters are methods.

Methods with only one uppercase letter are constructors e.g. `Num`.

Constructors initialize themselves with superclass attributes by calling the supper; e.g.

<img src="http://yuml.me/diagram/plain/class/[Col|name;pos;n = 0]^-[Num|mu = 0;sum = 0]">

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
