#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- --

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
 The only treatment for excessive language-ism is to use simpler languages. With those, I soon run out
  net tricks to distract me (at which point, I can finally build useful stuff)

[^note]: In Lisp, Prolog, Python, Lua, Julia

How to have Fun?

- Install gawk and bash.
- Create a git repo with directories `root/src` `root/docs`.
- Download `[funny.fun](https://github.com/timm/fun/blob/master/src/funny.fun)`
  and `[funnyok.fun](https://github.com/timm/fun/blob/master/src/funnyok.fun)` into `root/src`.
- Download `[fun](https://github.com/timm/fun/blob/master/fun)` into `root/`. Then 

```
chmod +x  fun
cd src
../fun
./funnyok.fun
```

- If that works, you should see something like:

```
#--- funny -----------------------
this one should fail
#TEST:  FAILED  _isnt   1       0
#TEST:  PASSED  _any    1       1
```

- Optionally, edit `fun` and find the `Lib` and `Bin` variables near the top. Set your `$PATH` and
  `$AWKPATH` to those variables in your `.bashrc` e.g


## Rules of Fun
### Funwith Write Code, Comments, and Unit Tests

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

Documentation is fun. Write explanations of your code around your code. Fun treats anything that matches
the following as code (and the rest becomes markdown when the `docs/*.md` files are generated):

```
  /^@include/              
  /^(func|BEGIN|END).*}$/  
  /^(func|BEGIN|END)/,/^}/ 
```

Unit test functions all have to start with an `f` argument that says what file you are testing. Pass
that argument to the `is` function that checks if a test worked. e.g.

function _any(f,   a,b,i) {
  split("a,b,c,d,e,f",a,",")
  for(i=1;i<=50;i++) b[i]=any(a)
  asort(b)
  is(f, b[1],1)
}

In your unit test file, write a `BEGIN` statement that lists your unit tests. e.g. in `funny.fun` see

BEGIN { tests("funny", "_isnt,_any") }

### Fun with Objects

Call your objects `i`.

Access object attributes with a  " . ". Accessors can be nestedE.g. `i.num.sd`

- " . " is a reserved characters. Outside of numbers and accessors, if you need a " . " (e.g. in a filename)
  then use the `DOT` variable (which is a string containing " . ").

Use  function names  with leading uppercase letters to define methods.

Use metthod names with only one uppercase letter to define constructors e.g. `Num`.

Make constructors initialize themselves with superclass attributes by calling the super constructor; e.g.

#!class [Col|name;pos;n = 0]^-[Num|mu = 0;sum = 0]

function Col(i,name,pos) {
  i.n   = 0
  i.name= name
  i.pos = pos
}
function Num(i,name,pos) {
  Col(i,name,pos)  # call to super class constructor
  i.mu = i.sum = 0 
}

To update an object, write a Methods ending in "1". Usually, return the added thing
(it if is a string or number).  e.g.

function Num1(i, x) {
  i.sum += x
  i.n += 1
  i.mu = i.sum/i.n
  return x
}

## Things that are not Fun

Its [not fun debugging polymorphsim](https://ieeexplore.ieee.org/document/676735), 
calls to super class methods, etc, etc. If you really 
need those, see Lua, Python, etc etc.


## Notes

