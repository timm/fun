---
title: zeror.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# zeror.fun
## Zero-R Classifier

Uses:  "[funny](funny)"<br>
Uses:  "[tbl](tbl)"<br>

`ZeroR` classifies everything as belonging to the  most frequent
class.

Here is a `ZeroR` payload object, suitable for streaming over data.

```awk
   1.  function ZeroR(i) {
   2.    has(i,"tbl","Tbl") 
   3.  }
```

Here is the `ZeroR` training function, suitable for updating the
payload `i` from row number `r` 
(which contains the data found in `lst`).


```awk
   4.  function ZeroRTrain(i,r,lst) { 
   5.    Tbl1(i.tbl, r, lst) 
   6.  }
```

Here is the `ZeroR` classification function, that uses the payload
`i` to guess the class of row number `r`
(which contains the data found in `lst`).

```awk
   7.  function ZeroRClassify(i,r,lst,x) {
   8.    return  i.tbl.cols[ i.tbl.my.class ].mode
   9.  }
```


