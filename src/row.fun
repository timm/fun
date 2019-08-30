#!/usr/bin/env ../fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
---------- --------- --------- --------- --------- --


## Store rows of tables.

#!class [Tbl]++-1..*[Row|cells;cooked;dom = 0],[Row]-uses-[Col||Col1()]

`Tbl` (tables) have `Row`s.

@include "funny"
@include "the"
@include "tbl"
@include "col"

As `Row`s accept `cells`, it passes each cell to a table column
(so that column can update what it knows about that column).

function Row(i,t,cells,     c) {
  Object(i)
  has(i,"cells")
  has(i,"cooked")
  i.dom = 0
  for(c in t.cols) 
    i.cells[c] = Col1(t.cols[c],  cells[c]) 
}

## Scoring Rows

To assess the worth of a `Row`, we compare it to a random number
of other `Row`s.

function RowDoms(i,all,t,  j) {
  i.dom = 0
  for(j=1; j<=THE.row.doms; j++)
    i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
}

`Row` "_i_" dominates row "_j_"  if "_i_"'s  goals are "better".
To compute this "better", we complain loudly about   the loss between
each goal (where "complaining" means, raise it a power of 10).  If
moving from "_i"_ to "_j_" shouts less than the other way around,
then "_i_" domiantes[^bdom].

function RowDom(i,j,t,   a,b,c,s1,s2,n) {
  n = length(t.my.w)
  for(c in t.my.w) {
    a   = NumNorm( t.cols[c], i.cells[c] )
    b   = NumNorm( t.cols[c], j.cells[c] )
    s1 -= 10^( t.my.w[c] * (a-b)/n )
    s2 -= 10^( t.my.w[c] * (b-a)/n )
  }
  return s1/n < s2/n
}

Here are some low-level trisk for sorting rows.  If the sort key
is numeric, sort on some cell of `Row`.  Else sort on some key of
the `Row` (outside of the cells).

function rcol(r,k) {
  return (typeof(k) == "number")  ? r.cells[k] : r[k]
}

## Distance

First we have to decide what attributes to use for the distance calculation.
The default is to use all the standard independent variables (i.e. `xs`).

function RowDist(i,j,t,what) {
  what = what ? what : "xs"
  return _rowDist(i,j, t.my[what], t.my.syms, t.cols)
}

Next, for a Euclidean distance measure, we have to compute the
square root of the sum of the square of the distances. This Euclidean
distance is just a general case of the [Minkoski
distance](https://en.wikipedia.org/wiki/Minkowski_distance) Give
some power factor "_p_" this distance is the  _p-th_ root of the
sum of the distances raised to the power "_p_". Formally, this is
known as a Note that, for SE data, [it  is known that it is useful
to tune "_p_" to values other than _p=2_](#smotuned)

function _rowDist(i,j,what,syms,cols,    p,c,n,d0,d) {
  p = THE.row.p
  for (c in what) {
    n  = n + 1 
    d0 = _rowDist1(i.cells[c], j.cells[c], cols[c], c in syms)
    d += d0^p
  }
  return (d/n)^(1/p)
}

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

function _rowDist1(x, y, col, symp,     no) {
  no = THE.row.skip
  if (x==no&&y==no) return 1 # Case1: assume max
  if (x==y)         return 0 # Case2: return min
  if (symp)         return 1 # Case3, Case4
  if (x==no)        {y=NumNorm(col,y); x=y>0.5 ? 0 : 1} # Case5
  else if (y==no)   {x=NumNorm(col,x); y=x>0.5 ? 0 : 1} # Case6
  else              {x=NumNorm(col,x); y=NumNorm(col,y)}
  return abs(x-y)   # Case7
}

## The Curse of Dimensionality

In case you missed it, the above distance function is defined for `N` dimensions:

-  If we are learning from some spreadsheet,
- and that spreadsheet has 100 columns, 
- and we are trying to predict for some binary class in the 101th column (say, `true` or `false`) 
- then those `true`s and `false`s are dots floating in a 100 dimensional space.

So congrats-- you have just left behing the dull 2D and 3D world and  entered multi-dimensional space!

Now multi-dimensional space gets... intersting.
For a really good discussion on this, see [Stats.stackexchange](https://stats.stackexchange.com/questions/99171/why-is-euclidean-distance-not-a-good-metric-in-high-dimensions), which is sumamrized (and extended a little), below.
Also [Aggarwal et al.](#aggarwal-2001) is a widely cited reference on this topic.

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

- For  the unit sphere (`r=1`) and `N = 7`, V<sub>7</sub>(r)=V<sub>N-2</sub>6.28/7.   
       That is, the volume of the 7 dimensional unit sphere is _smaller_
       than the 5 dimensional unit sphere. 
- And as `N` increases, spheres of larger and larger volume get smaller and smaller (by a factor of `6.28/N`).
- More generally, dimensionality decreases volume. 
     - After 20 dimensions, the volume of the unit sphere is effectively zero.

![](assets/img/sphere.png){:width="300px"}

If that seems wrong, then consider another way to show the same thing.

- When we build a model,we are sumamrizing some phenomenon.
- It is good practice to build
different models for different phenomena; i.e. before we model, we should seperate the data into regions of similar items.
- How large is the volume within which we need to search to find similar examples (here, by "similar", we mean that
 the distance between them is not large)? 

To answer that question,  we ask how close do things need to be in order to fall within a sphere of
some fixed radius? In the following, we  will say a radius of `r=1` but the following holds for any radius of constat size.

- Let the center of the sphere be (0,0,0,...).
- The radius is the Euclidean distance  from the center to  any point (x,y,z,...) i.e.
  `r=1=sqrt(x^2+y^2+z^2+...)`
- If all our points are spread out uniformally in `N` dimensions such that  `x=y=z` then
  -  `1=sqrt(N*x^2)` so
  - so `x=`&plusmn;`1/sqrt(N)` 
  -  since we use the absolute value for distances (i.e. no minuses) then
  `x=1/sqrt(N)`.
- From this expression we see that as `N` increases, the distance from the radius to any point must decrease. 
- To say that another way, the volume where we must search for similiar examples gets smaller and smaller and smaller.
  
There are several assumptions in the above poinbts and if you do not like those, then we refer you back to the  V<sub>N</sub>(r)=V<sub>N-2</sub>2&pi;r<sup>2</sup>/N expression. Either way, the lesson is clear:

- The more complex your model (the more dimensions it uses) the harder it is to find data to support that model.
  
More formally (from [Wikipedia](https://en.wikipedia.org/wiki/Curse_of_dimensionality):  "When the dimensionality increases, the volume of the space increases so fast that the available data becomes sparse. This sparsity is problematic for any method that requires statistical significance. In order to obtain a statistically sound and reliable result, the amount of data needed to support the result often grows exponentially with the dimensionality." 
)

Method1: Do not use Euclidean distance.
[Aggarwal et al.](#aggarwal-2001) comment  that in the above code, _p=1_ might do better than _p=2_ or even higher values.


Method2: Use simpler models. If high dimensions are a curse, the avoid the curse. 
Look for ways to reduce dimensionality:

If multiple dimensions are correlated, then seek an udnerlying set of dimensions that best capture the essence of the domensions.
.  There are so many ways to do this.

Sort the columns by their standard deviation and just use the ones that vary the most variance.

Use a different itnernal rpresetnations (sparse amtrixes)

For text mining, TFIDF

Dont use all dimensions. 

Invent better dimensions. PCA, SVM

Method2:
find 
  the dimensions that (e.g.) most distinguish class values and explore those. If you repeat this process recursively,
then that is how you bilt decision/regression trees.

![](assets/img/tree201.png)

 <MATH>&int;_a_^b^{f(x)<over>1+x} dx</MATH>

blessun

## References

### Aha 91

David W. Aha, Dennis Kibler, and Marc K. Albert. 1991. Instance-Based Learning Algorithms. Mach. Learn. 6, 1 (January 1991), 37-66. DOI: https://doi.org/10.1023/A:1022689900470

### Aggarwal 2001

Charu C. Aggarwal, Alexander Hinneburg, and Daniel A. Keim. 2001. On the Surprising Behavior of Distance Metrics in High Dimensional Spaces. In Proceedings of the 8th International Conference on Database Theory (ICDT '01), Jan Van den Bussche and Victor Vianu (Eds.). Springer-Verlag, Berlin, Heidelberg, 420-434.
https://bib.dbvis.de/uploadedFiles/155.pdf

### Smotuned

See Table5 and Fig5c of https://arxiv.org/pdf/1705.03697.pdf.
 Amritanshu Agrawal and Tim Menzies. 2018. Is "better data" better than "better data miners"?: on the benefits of tuning SMOTE for defect prediction. In Proceedings of the 40th International Conference on Software Engineering (ICSE '18). ACM, New York, NY, USA, 1050-1061. DOI: https://doi.org/10.1145/3180155.3180197
