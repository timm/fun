---
title: divok.fun
---

<img style="width:100%;" src="https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png">

| [code](http://github.com/timm/fun) | [discuss](http://github.com/timm/fun/issues) | [license](/fun/LICENSE) |

# divok.fun
#--------- --------- --------- --------- --------- ---------

```awk
@include "div"
```

```awk
BEGIN { tests("divok", "_div") }
```

```awk
function _div1(x) {
  if (x<=10) return 0
  if (x<=20) return 1
  return 2
}
function _div(  lst,a,i,cuts) {
   List(a)
   for(i=1;i<=30;i++) 
     pash2(a,"Xy",i, _div1(i))
   sdiv(a,cuts)
   oo(cuts)
}
```


<em> &copy; 2019, Tim Menzies, http://menzies.us</em>
