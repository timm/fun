---
title: treeok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# treeok.fun


Uses:  "[funny](funny)"<br>
Uses:  "[tree](tree)"<br>
Uses:  "[tbl](tbl)"<br>

```awk
   1.  BEGIN { tests("treeok", "_tree") }
```

```awk
   2.  function  _tree(f,  i,t,c) {
   3.    Tbl(t)
   4.    lines(t,"Tbl1",DOT DOT "/data/weathernom" DOT "csv")
   5.    #for(c in t.xnums) TreeNum(i,t,'$playHours',c)
   6.    for(c in t.my.xsyms)
   7.       TreeSym(i,t,t.my.class,c)
   8.  }
```
