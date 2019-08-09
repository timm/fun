---
title: STYLE.fun
---

[home](/fun/index) | [about](/fun/ABOUT) |  [code](http://github.com/timm/fun) |  [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) <br>
<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png"><br><em> &copy; 2019 Tim Menzies. http://menzies.us</em>

# STYLE.fun

## Code

Never control the random number seed inside the code.

Always control the random seed inside the unit tests.

No globals (or, at least, very few). Always declare locals within
each function. 

Make you function lcoals all lower case.

File XX.fun needs XXok.fun (for unit tests).

If passing around a lot of similar parameters, 
make an object for the payload.


Write all config params to [the.fun](the.fun).

Files should be short. If more > 150 LOC then find a way to split.

Start each file with a  UML fragment. It does not have to be
complete... just enough detail to introduce the idea.

Arrays are (usually) _a,b,c..._.

Objects are (usually) _i,j,k..._.

Numbers are (usually) _m,n,o,_

Try not to use "_l"_ (hard to read).

Temporaries are _u,v,w,..._

## Markdown

Never had write anything in `docs/8` (it will get blasted a lot).
