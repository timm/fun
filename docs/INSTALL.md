---
title: INSTALL.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/license">license</a></button> <br>



# INSTALL.fun

## Download and installation instruction

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

