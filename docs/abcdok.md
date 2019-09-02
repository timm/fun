---
title: abcdok.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# abcdok.fun
Uses:  "[fun](fun)"<br>
Uses:  "[abcd](abcd)"<br>

```awk
   1.  BEGIN { tests("abcd", "_abcd") }
```

=== Confusion Matrix ===
a b c   <-- classified as
6 0 0 | a = yes
0 2 0 | b = no
0 1 5 | c = maybe

```awk
   2.  function _abcd(f,i,j) {
   3.    Abcd(i)
   4.    for(j=1; j<=6; j++) Abcd1(i,"yes", "yes")
   5.    for(j=1; j<=2; j++) Abcd1(i,"no",  "no")
   6.    for(j=1; j<=5; j++) Abcd1(i,"maybe",  "maybe")
   7.    Abcd1(i, "maybe","no")
   8.    AbcdReport(i)
   9.  }
```

=== Detailed Accuracy By Class ===
                TP Rate   FP Rate   Precision   Recall  F-Measure   ROC Area  Class
                  1         0          1         1         1          1        yes
                  1         0.083      0.667     1         0.8        0.938    no
                  0.833     0          1         0.833     0.909      0.875    maybe
Weighted Avg.    0.929     0.012      0.952     0.929     0.932      0.938


