---
title: row.fun
---

<button class="button button1"><a href="/fun/index">home</a></button>   <button class="button button2"><a href="/fun/INSTALL">install</a></button>   <button class="button button1"><a href="/fun/ABOUT">doc</a></button>   <button class="button button2"><a href="http://github.com/timm/fun/issues">discuss</a></button>    <button class="button button1"><a href="/fun/LICENSE">license</a></button> <br>



# row.fun


## Store rows of tables.

<img src="http://yuml.me/diagram/plain;dir:lr/class/[Tbl]++-1..*[Row|cells;cooked;dom = 0],[Row]-uses-[Col||Col1()]">

`Tbl` (tables) have `Row`s.

Uses:  "[funny](funny)"<br>
Uses:  "[the](the)"<br>
Uses:  "[tbl](tbl)"<br>
Uses:  "[col](col)"<br>

As `Row`s accept `cells`, it passes each cell to a table column
(so that column can update what it knows about that column).

```awk
   1.  function Row(i,t,cells,     c) {
   2.    Object(i)
   3.    has(i,"cells")
   4.    has(i,"cooked")
   5.    i.dom = 0
   6.    for(c in t.cols) 
   7.      i.cells[c] = Col1(t.cols[c],  cells[c]) 
   8.  }
```

## Scoring Rows

To assess the worth of a `Row`, we compare it to a random number
of other `Row`s.

```awk
   9.  function RowDoms(i,all,t,  j) {
  10.    i.dom = 0
  11.    for(j=1; j<=THE.row.doms; j++)
  12.      i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
  13.  }
```

`Row` "_i_" dominates row "_j_"  if "_i_"'s  goals are "better".
To compute this "better", we complain loudly about   the loss between
each goal (where "complaining" means, raise it a power of 10).  If
moving from "_i"_ to "_j_" shouts less than the other way around,
then "_i_" domiantes[^bdom].

```awk
  14.  function RowDom(i,j,t,   a,b,c,s1,s2,n) {
  15.    n = length(t.my.w)
  16.    for(c in t.my.w) {
  17.      a   = NumNorm( t.cols[c], i.cells[c] )
  18.      b   = NumNorm( t.cols[c], j.cells[c] )
  19.      s1 -= 10^( t.my.w[c] * (a-b)/n )
  20.      s2 -= 10^( t.my.w[c] * (b-a)/n )
  21.    }
  22.    return s1/n < s2/n
  23.  }
```

Here are some low-level trisk for sorting rows.  If the sort key
is numeric, sort on some cell of `Row`.  Else sort on some key of
the `Row` (outside of the cells).

```awk
  24.  function rcol(r,k) {
  25.    return (typeof(k) == "number")  ? r.cells[k] : r[k]
  26.  }
```

## Distance

First we have to decide what attributes to use for the distance calculation.
The default is to use all the standard independent variables (i.e. `xs`).

```awk
  27.  function RowDist(i,j,t,what) {
  28.    what = what ? what : "xs"
  29.    return _rowDist(i,j, t.my[what], t.my.syms, t.cols)
  30.  }
```

Next, for a Euclidean distance measure, we have to compute the
square root of the sum of the square of the distances. This Euclidean
distance is just a general case of the [Minkoski
distance](https://en.wikipedia.org/wiki/Minkowski_distance) Give
some power factor "_p_" this distance is the  _p-th_ root of the
sum of the distances raised to the power "_p_". Formally, this is
known as a Note that, for SE data, [it  is known that it is useful
to tune "_p_" to values other than _p=2_](#smotuned)

```awk
  31.  function _rowDist(i,j,what,syms,cols,    p,c,n,d0,d) {
  32.    p = THE.row.p
  33.    for (c in what) {
  34.      n  = n + 1 
  35.      d0 = _rowDist1(i.cells[c], j.cells[c], cols[c], c in syms)
  36.      d += d0^p
  37.    }
  38.    return (d/n)^(1/p)
  39.  }
```

Finally, we compare two galues.
The following needs a little explaination. According to [Aha91](#aha-91):

- _Principle1_ : when doing distance calculations, normalize all distances for
   each attribte from zero to one (otherwise, one attribute can have an undue 
   influence, For example,  astronauts have age 0 to 120 but 
   fly at speeds 0 to 25,000. So before we compare to rows containing
   information and astronaut age and velocity, make all ranges 0..1, min..max.
   - For symbols, this is is easy: indentical symbols have distance 
     zero; otherwise, their distance is one.
   - For numerics, just normalize all values `x` via    
     `(x - lo)/(hi - lo`+&epsilon;`)`    
     where `x` comes from some column and `lo,hi` are the smallest and largest
     values in that colum, and &epsilon; is some tiny amout (`10^-32`) included
     to avoid divde-by-zero errirs).
- _Principle2_: when position are unknown, assume maximum. This heuristic
  assumes that unknown things can be anywhere which means, on average,
  they are not close by.

The following code applies these principles:

- _Case1_: randomly selected items can be very distant so if i
  there is uncertainty about both position, assume worst case.
- _Case2_: identical things are not seperated. 
- If a symbol then
    - _Case3_ if either is unknown, assume max distance=1;
    - _Case4_ else, if they are different, then distance=1;
    - _Case5_ else, if the same, then distance=0 (covered by _Case2_)
- If a number, then:
    - _Case6_ if one is unknown, make the assumptions that maximizies the distance
    - _Case7_: Finally, after normalizing the nuers zero to one, return
      the distance between them

```awk
  40.  function _rowDist1(x, y, col, symp,     no) {
  41.    no = THE.row.skip
  42.    if (x==no&&y==no) return 1 # Case1: assume max
  43.    if (x==y)         return 0 # Case2: return min
  44.    if (symp)         return 1 # Case3, Case4
  45.    if (x==no)        {y=NumNorm(col,y); x=y>0.5 ? 0 : 1} # Case5
  46.    else if (y==no)   {x=NumNorm(col,x); y=x>0.5 ? 0 : 1} # Case6
  47.    else              {x=NumNorm(col,x); y=NumNorm(col,y)}
  48.    return abs(x-y)   # Case7
  49.  }
```

## The Curse of Dimensionality

The above distance calculation has issues as dimensionality increases.
For a really good discussion on this, see [Stats.stackexchange](https://stats.stackexchange.com/questions/99171/why-is-euclidean-distance-not-a-good-metric-in-high-dimensions), which is sumamrized (and extended a little), below.

As pointed on in
 [A Few Useful Things to Know about Machine Learning](https://homes.cs.washington.edu/~pedrod/papers/cacm12.pdf),
Pedro Domingos comments:


- "Our intuitions, which come from a three-dimensional world, often
do not apply in high-dimensional ones. In high dimensions, most of
the mass of a multivariate Gaussian distribution is not near the
mean, but in an increasingly distant 'shell' around it; and most
of the volume of a high-dimensional orange is in the skin, not the
pulp. If a constant number of examples is distributed uniformly in
a high-dimensional hypercube, beyond some dimensionality most
examples are closer to a face of the hypercube than to their nearest
neighbor. And if we approximate a hypersphere by inscribing it in
a hypercube, in high dimensions almost all the volume of the hypercube
is outside the hypersphere. This is bad news for machine learning,
where shapes of one type are often approximated by shapes of another."

If you want to get a sense of the wierdness of higher dimensionalty, consider the volume of an N-dimensional sphere:

- for `N=2`, it is V<sub>2</sub>(r)=&pi;r<sup>2</sup>
- for `N=3`, it is V<sub>3</sub>(r)=4/3&pi;r<sup>2</sup>
- for `N>3`, it is V<sub>N</sub>(r)=V<sub>N-2</sub>2&pi;r<sup>2</sup>/N.  
  That is, we compute the volume of a
  higher dimensional sphere by multiplyiung a lower dimensional sphere by some additional factor.

Now there is the wierd part:

![](https://upload.wikimedia.org/wikipedia/commons/6/6c/Hypersphere_volume_and_surface_area_graphs.svg) | width=400)

- 
  For  the unit sphere (`r=1`) and `N = 7`,   
  V<sub>7</sub>(r)=V<sub>N-2</sub>6.28/7.   That is, the volume of the 7 dimensional unit sphere is _smaller_
  than the 5 dimensional unit sphere.
- More generally, as the dimensions increase (over 6), the volume decreases

In summary, as the number of dimensions increase, look for ways to reduce them.  There are so many ways to do this.

Sort the columns by their standard deviation and just use the ones that vary the most variance.


## References

### Aha 91

David W. Aha, Dennis Kibler, and Marc K. Albert. 1991. Instance-Based Learning Algorithms. Mach. Learn. 6, 1 (January 1991), 37-66. DOI: https://doi.org/10.1023/A:1022689900470


### Smotuned

See Table5 and Fig5c of https://arxiv.org/pdf/1705.03697.pdf.
 Amritanshu Agrawal and Tim Menzies. 2018. Is "better data" better than "better data miners"?: on the benefits of tuning SMOTE for defect prediction. In Proceedings of the 40th International Conference on Software Engineering (ICSE '18). ACM, New York, NY, USA, 1050-1061. DOI: https://doi.org/10.1145/3180155.3180197
