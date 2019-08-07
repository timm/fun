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
function _div1(x,max) {
  if (x<=max*1/3) return 0
  if (x<=max*2/3) return rand()
  return 2*rand()
}
function _div(  lst,a,i,cuts,max) {
   srand(1)
   List(a)
   max=30000
   for(i=1;i<=max;i++) 
     pash2(a,"Xy",i*(1+rand()), _div1(i,max))
   sdiv(a,cuts)
   oo(cuts)
}
```


<em> &copy; 2019, Tim Menzies, http://menzies.us</em>
