---
title: about.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

<em> &copy; 2019, Tim Menzies, http://menzies.us</em>

# about.fun

## F.A.Q.

Why Fun?

- Why not? Inventing your own language with transpilers is fun!
     - (Hint: if possible, keep the same
line numbers in the output so errors there can be easily traced abck to your source code.)
- I teach a lot of computer science. The best teaching trick I know is to give
   students a working solution, in a language they've never seen before,
  and ask them to code it up for themselves (in any other language they like).

Why transpiler to gawk?

- Cause the source is so succinct, its easy to show in lectures.
- My name is timm and I'm a language-a-holic. Give me a cool language[^note]
  and I use it. All of it. 
  High-order functions, unification, decorators, iterators,
  list comprehensions, metaclasses, macros
  and I will USE and ABUSE them for days and days and days and ...
 The result is beautiful clever code (IMHO), that no one else can understand  or use.
 The only treatment I know for my language-ism is to use simpler languages. With those, I soon run out
  net tricks to distract me (at which point, I can finally build useful stuff)

[^note]: In Lisp, Prolog, Python, Lua, Julia

## Rules of Fun

Its [not fun debugging polymorphsim](https://ieeexplore.ieee.org/document/676735), 
calls to super class methods, etc, etc. If you really 
need those, see Lua, Python, etc etc.

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
  Col(i,name,pos)  # call to super class constructor
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

## Notes

