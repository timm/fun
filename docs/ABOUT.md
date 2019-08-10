---
title: ABOUT.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/license">license</a></button> <br>



# ABOUT.fun

FUN is a lightweight executable notation, used
here to describe various data mining and optimization
concepts.

FUN  can be used as a teaching tool.
Given code written in a language they have never seen before (i.e. FUN), students
code up their own versions (in whatever langauge they like best).

FUN supports literate programming (with a few UML tricks); unit tests;
and object-like features.
FUN is a transpiled language.
 `xxx.fun` files are converted into:

- `xxx.awk` files (for scripting) and stored in `$HOME/opt/fun/awk`;
- `xxx.md` markdown files (for web display) and stored in `docs/`;
- `xxx` executable scripts (for standalone execution) and stored in `$HOME/opt/fun/bin`;

FUN transpiles to GAWK since:

- The simpler the  target language, the simpler the pre-transpiled source code;.
- The simpler the source code, the easier it is to show students (the source is so succinct, its easy to show in lectures).
- If you want to test that you undestand something,
  code it if GAWK. If you are not clear what is going on,
  the code will be a mess. So while not clean code, recode in GAWK.
- After much coding in may langages[^note], I found that I kept using the same tricks in every languages (e.g.
  every file kmows it own dependancies and can be tested seperately from the rest; code has doco which is extracted to seperate
  markdown files; code has unit tests; etc).
  FUN codes all those tricks.
- Finally, FUN is therapy and treatment for my addiction to tricky langauge features[^addict].

[^addict]: My name is timm and I'm a language-a-holic.  Give me a cool language[^note] and I use it. All of it.  High-order functions, unification, decorators, iterators, list comprehensions, metaclasses, macros and I will USE them to write code that no one else can undersrand.
[^note]: In Lisp, Prolog, Smalltalk, Python, Lua, Julia

## Rules of Fun

### Fun wuth UML

See the class diagram, below? It was generated using the following like in the `.fun` file:

     #!class [Col|name;pos;n = 0]^-[Num|mu = 0;sum = 0]

For notes on that syntax, see [here](https://github.com/aklump/yuml-cheatsheet).

 
### Fun with Objects

- Call your objects `i`.
- Access object attributes with a  " . " (and accessors can be nestedE.g. `i.num.sd`);
   - " . " is a reserved characters. Outside of numbers and accessors, if you need a " . " (e.g. in a filename)
  then use the `DOT` variable (which is a string containing " . ").
- Use  function names  with leading uppercase letters to define methods.
- Use metthod names with only one uppercase letter to define constructors e.g. `Num`.
- Make constructors initialize themselves with superclass attributes by calling the super constructor; e.g.

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Col|name;pos;n = 0]^-[Num|mu = 0;sum = 0]">

```awk
   1.  function Col(i,name,pos) {
   2.    i.n   = 0
   3.    i.name= name
   4.    i.pos = pos
   5.  }
   6.  function Num(i,name,pos) {
   7.    Col(i,name,pos)  # call to super class constructor
   8.    i.mu = i.sum = 0 
   9.  }
```

- To update an object, write a Methods ending in "1". Usually, return the added thing
(it if is a string or number).  e.g.

```awk
  10.  function Num1(i, x) {
  11.    i.sum += x
  12.    i.n += 1
  13.    i.mu = i.sum/i.n
  14.    return x
  15.  }
```

### Fun with Source Code

Write source code into `src/x.fun` and unit tests for `x` into  `src/xok.fun`. 
Start all your files with

```
 #!/usr/bin/env ../fun
 # vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
 ---------- --------- --------- --------- --------- --

 @include "funny"
```

(That second line is only for Vim users. That thrid line is a guide telling you when soruce code
is getting too wide for web-based display.)

### Fun with Literate  Programming

Documentation is fun. Write explanations of your code around your code. Fun treats anything that matches
the following as code. Everything  becomes markdown when the `docs/*.md` files are generated.

```
  /^@include/              
  /^(func|BEGIN|END).*}[ \t]*$/  
  /^(func|BEGIN|END)/,/^}/ 
```

### Fun with Unit Tests

Unit test functions all have to start with an `f` argument that says what file you are testing. Pass
that argument to the `is` function that checks if a test worked. e.g.

```awk
  16.  function _any(f,   a,b,i) {
  17.    split("a,b,c,d,e,f",a,",")
  18.    for(i=1;i<=50;i++) b[i]=any(a)
  19.    asort(b)
  20.    is(f, b[1],1)
  21.  }
```

Unit test files for `x.fun` are stored in `xok.fun`.
In your unit test file, write a `BEGIN` statement that lists your unit tests. e.g. in `funny.fun` see

```awk
  22.  BEGIN { tests("funny", "_isnt,_any") }
```

### Fun with Variables

Call you local function variables with a leading lower case. Define your locals as extra argument funcions.
For example, here is the `tests` function used to call multiple unit tests. `what` and `all` are passed in and
`one,a,i,n` are locals.

```awk
  23.  function tests(what, all,   one,a,i,n) {
  24.    n = split(all,a,",")
  25.    print "\n#--- " what " -----------------------"
  26.    for(i=1;i<=n;i++) { one = a[i]; @one(one) }
  27.    rogues()
  28.  }
```

### Fun with Config

Do place all the magic control variables in one place ([the.fun](the.fun)). This allows for simpler hyperparameter optimization.

### Things that are not Fun

Its [not fun debugging polymorphsim](https://ieeexplore.ieee.org/document/676735), 
calls to super class methods, etc, etc. If you really 
need those, see Lua, Python, etc etc.


## Notes

