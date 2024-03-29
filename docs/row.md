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

- When we build a model, we are trying to summarize  some phenomenon.
- It is good practice to build
different models for different phenomena; i.e. before we model, we should seperate the data into regions of similar items.
- Hence, a relevant question to ask is "how large is the volume within which we need to search to find similar examples?".

Here, by "similar", we mean that
 the distance between them is "not large". 
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
  
There are several assumptions in the above poinbts and if you do
not like those, then we refer you back to the
V<sub>N</sub>(r)=V<sub>N-2</sub>2&pi;r<sup>2</sup>/N expression.
Either way, the lesson is clear:

- From [Wikipedia](https://en.wikipedia.org/wiki/Curse_of_dimensionality):  "When
the dimensionality increases, the volume of the space increases so
fast that the available data becomes sparse. This sparsity is
problematic for any method that requires statistical significance.
In order to obtain a statistically sound and reliable result, the
amount of data needed to support the result often grows exponentially
with the dimensionality." 

To put that another way,

- The more complex your model (the more dimensions it uses) the
harder it is to find data to support that model.


Method0: Do not build complex models. K.I.S.S.= Keep it simple, surely?

Method1: Do not use Euclidean distance.
[Aggarwal et al.](#aggarwal-2001) comment  that in the above code, _p=1_ might do better than _p=2_.
The actually best value of _p_ for data can be found via
 [automatic methods](#smotuned).

Method2:
only use
  the dimensions that (e.g.) most distinguish class values and explore those. FYI: if you repeat this process recursively,
then that is how you bilt decision/regression trees.

![](assets/img/tree201.png)


Method3: For text mining:
  when thate may be 100,000s of columns, only use the features that appear a lot, but only in a small number of documents. This is call TFidf (or term frequency inverse document
     frequency). 

- If there be `Words` number of document and each word `i` appears `Word[i]` number of times inside a set of Documents and if `Document[i]` be the documents containing `i`, 
- Then 
     `TFidf = Word[i]/Words*log(Documents/Document[i])`.
- A useful trick is to only use the top, say, 100 TFidf-ing scoring words.

Method4: Exploing the class/goal variables:
  - Before reasoning over numerous indeepdnent features (of which theyre may be many), first reason over the dependent features (which are usually very few). That is,
  - Group the data  using the goal/class variables
  - Ignore anything that has similar distributions in different groups.
    - And you'll need different tests for [numerics](nums.md) and [symbols](syms.md)


Method5: exploint the blessing of non-uniformity.

## The Blessing of Non-Uniformity ("Bulges" in the data)

A repeated result in data mining (and image processing and astronomy)  is that data expressed in `D` dimensions can be usefully approximated in some smaller set. 

- The [Johnson-Lindenstrauss](johnson-2004) lemma  states that if points in a vector space are of sufficiently high dimension, 
then they may be projected into a suitable lower-dimensional space in a way which approximately preserves the distances between the points. T
- According to [Levina and Bickel](#levina-2004):
    - "the only reason any methods work in very high dimensions is that, in fact, the data are not truly high-dimensional ... but can be efficiently summarized in a space of a much lower dimension". 

One way to find that lower dimnsionality is too look for "bulges" in the data.

- If all the data is spread uniformly across the space, then you cannot ignore some dimensions. 
- But  if there are many intra-conencted variables, then the data will "bulge out" in a just a few dimensions.
- If so, it is possible  to infer a smaller set of dimensions that better capture those "bulges" (the intra-connectivities). 

A traditional way to model the "bulges"  is principle components analysis (PCA), that explores the [Eigenvectors of the covariance  matrix](#pca). PCA can compute the dark arrows in the following
diagram (actually, PCA does find two arrows, but N orthogonal dimensions where the N+1 dimension "retires" the direction of greatest uncertainty left behind after then N-th dimension).

![](assets/img/pca.png)

 
Note that traditional PCA requires some (potentially) slow polynomial-time matrix multiplications. Also it is only defined only for numbers.
Once we have a distance metric defined for symbols and numbers, then we can deploy some analogs to PCA, that run much faster, and which handle symbols as well as numbers.
For example, here is a "random projections"  algorithm:

1. As data arrives, keep the first `M` items.
2. Once you get `M` items, then find a random projection; i.e. two _poles_, which are somewhat distant:
   - `N` times, pick two points at random and compute their seperation (use `N` more than 20).
   - Use the pair that are most distant
3. For those first `M` items, and then anything that follows after tha:
  - Divide the data according to which pole is closer;
  - For each division, goto step 1

_Note1_: This is a recursive clustering algorithm suitable for very large data sets. 

_Note2_: The few divisions found in this way  will only be approximate. However, after a couple of random projections seperate your data, it becomes likely that the points in one of
the 
sub-sub-sub-sub-sub-divisions are bulging the same way (and the items found in those 
sub-sub-sub-sub-sub divisions are truly similar).

![](assets/img/rp101.jpg)

A small variant of the above (that never recusrses) can visual points in N dimensions onto a 2D plane (which is useful for visualization and debugging):

- Let the poles be _east,west_, seperated by distance _c_.
- Let any other point _z_ have distance _a,b_ to _east,west_.
- By the cosine rule _x=(a<sup>2</sup> + c<sup>2</sup> - b<sup>2</sup>) / (2c)_
- Cap _x_ such that if x is above,below 0,1, set it to 0,1 (respectively).
- Let _y=sqrt(a<sup>2</sup> - x<sup>2</sup>)_
- Plot _z_ at _x,y_

![](assets/img/xy.png)

_WARNING:_ the dimensions found by PCA or random projections can capture the _bulges_ in the data BUT they introduce an explanation problem. If a business user asks "what have you learned"
and you show them the random projections, they will not see the raw dimensions that they are most familiar with. One (partial) solution to this is to:

- Use random projections to find data groupings
- Look at the distribution of variables at either poles of the bottom division
- Use some stats to prune variables that have the same distribution 
    - And you'll need different tests for [numerics](nums.md) and [symbols](syms.md)
- Build models using the remaining variables
- Only show the business users those generated models.

----

## References

### Aha 91

David W. Aha, Dennis Kibler, and Marc K. Albert. 1991. Instance-Based Learning Algorithms. Mach. Learn. 6, 1 (January 1991), 37-66. DOI: https://doi.org/10.1023/A:1022689900470

### Aggarwal 2001

Charu C. Aggarwal, Alexander Hinneburg, and Daniel A. Keim. 2001. On the Surprising Behavior of Distance Metrics in High Dimensional Spaces. In Proceedings of the 8th International Conference on Database Theory (ICDT '01), Jan Van den Bussche and Victor Vianu (Eds.). Springer-Verlag, Berlin, Heidelberg, 420-434.
https://bib.dbvis.de/uploadedFiles/155.pdf

### Johnson 2004

 Johnson, William B.; Lindenstrauss, Joram (1984). "Extensions of Lipschitz mappings into a Hilbert space". In Beals, Richard; Beck, Anatole; Bellow, Alexandra; et al. (eds.). Conference in modern analysis and probability (New Haven, Conn., 1982). Contemporary Mathematics. 26. Providence, RI: American Mathematical Society. pp. 189–206. doi:10.1090/conm/026/737400. ISBN 0-8218-5030-X. MR 0737400.


### Levina  2004

Elizaveta Levina and Peter J. Bickel. Maximum likelihood estimation of intrinsic dimension. In NIPS, 2004.

### PCA

For an step-by-step guide on how to do this, 
see Matt Brem's excellent article 
[A One-Stop Shop for Principal Component Analysis](https://towardsdatascience.com/a-one-stop-shop-for-principal-component-analysis-5582fb7e0a9c).

### Smotuned

See Table5 and Fig5c of https://arxiv.org/pdf/1705.03697.pdf.
 Amritanshu Agrawal and Tim Menzies. 2018. Is "better data" better than "better data miners"?: on the benefits of tuning SMOTE for defect prediction. In Proceedings of the 40th International Conference on Software Engineering (ICSE '18). ACM, New York, NY, USA, 1050-1061. DOI: https://doi.org/10.1145/3180155.3180197
