#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- --

<button class="button">Green</button>

[Experience suggests](/REFS#agrawal-2019)
that the twin technologies of
data mining and optimization are so closely connected 
that they can be usefully refactored.
such that
data miners can work as optimizers and vice versa. That refactored
code offers many design options, some of which could even contribute
to ethical goals (e.g. 
it is ethical to deliver transparent and reliable code;
rule learners help transparency; and 
mult-objective optimziation helps reliability).  

FUN is a work-on-progress with the goal
to build
a reference system that demonstrates all the above,
in one succinct code base.
Ideally, the reader looks here and says "I can do better than that", then rushes
off to refactor their own ethical code (in which case, all the code here
would become a spec for their implementation in  some other language).


FUN supports literate programming (with a few UML tricks); unit tests;
and object-like features.
FUN is a transpiled language.
 `xxx.fun` files are converted into:

- `xxx.awk` files (for scripting) and stored in `$HOME/opt/fun/awk`;
- `xxx.md` markdown files (for web display) and stored in `docs/`;
- `xxx` executable scripts (for standalone execution) and stored in `$HOME/opt/fun/bin`;

FUN  can be used as a notation to teach, say, data mining and optimization
concepts.
Given code written in a language they have never seen before (i.e. FUN), students
code up their own versions (in whatever langauge they like best).

But why transpile to gawk?

- Cause the simpler the  target language, the simpler the pre-transpiled source code;.
- Cause the simpler the source code, the easier it is to show students (the source is so succinct, its easy to show in lectures).
- After decades of coding in may langages[^note], I found that I kept using the same tricks in every languages (e.g.
  every file kmows it own dependancies and can be tested seperately from the rest; code has doco which is extracted to seperate
  markdown files; code has unit tests; etc).
  FUN codes all those tricks.
- Finally, full disclosure, my name is timm and I'm a language-a-holic. 
     - Give me a cool language[^note]
  and I use it. All of it. 
  High-order functions, unification, decorators, iterators,
  list comprehensions, metaclasses, macros
  and I will USE them to write code that no one else can undersrand.
[^note]: In Lisp, Prolog, Smalltalk, Python, Lua, Julia

## Installing Fun

Install gawk and bash.

Create a git repo with directories `root/src` `root/docs`.

Download [funny.fun](https://github.com/timm/fun/blob/master/src/funny.fun)
  and [funnyok.fun](https://github.com/timm/fun/blob/master/src/funnyok.fun) into `root/src`.

Download [fun](https://github.com/timm/fun/blob/master/fun) into `root/`. Then 

```
chmod +x  fun
cd src
../fun
./funnyok.fun
```

If that works, you should see something like:

```
#--- funny -----------------------
this one should fail
#TEST:  FAILED  _isnt   1       0
#TEST:  PASSED  _any    1       1
```

Optionally

-  Edit `fun` and find the `Lib` and `Bin` variables near the top. Set your `$PATH` and
$AWKPATH` to those variables in your `.bashrc` e.g
- Add the repo to Github, go to `Settings > Github  pages > Source`  and select "master branch /docs folder" (this will publish your `docs/*.md` files to the web).

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

- To update an object, write a Methods ending in "1". Usually, return the added thing
(it if is a string or number).  e.g.

function Num1(i, x) {
  i.sum += x
  i.n += 1
  i.mu = i.sum/i.n
  return x
}

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

function _any(f,   a,b,i) {
  split("a,b,c,d,e,f",a,",")
  for(i=1;i<=50;i++) b[i]=any(a)
  asort(b)
  is(f, b[1],1)
}

Unit test files for `x.fun` are stored in `xok.fun`.
In your unit test file, write a `BEGIN` statement that lists your unit tests. e.g. in `funny.fun` see

BEGIN { tests("funny", "_isnt,_any") }

### Fun with Variables

Call you local function variables with a leading lower case. Define your locals as extra argument funcions.
For example, here is the `tests` function used to call multiple unit tests. `what` and `all` are passed in and
`one,a,i,n` are locals.

function tests(what, all,   one,a,i,n) {
  n = split(all,a,",")
  print "\n#--- " what " -----------------------"
  for(i=1;i<=n;i++) { one = a[i]; @one(one) }
  rogues()
}

### Fun with Config

Do place all the magic control variables in one place ([the.fun](the.fun)). This allows for simpler hyperparameter optimization.

### Things that are not Fun

Its [not fun debugging polymorphsim](https://ieeexplore.ieee.org/document/676735), 
calls to super class methods, etc, etc. If you really 
need those, see Lua, Python, etc etc.


## Notes

