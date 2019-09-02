#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "fun"
@include "abcd"

BEGIN { tests("abcd", "_abcd") }

=== Confusion Matrix ===
a b c   <-- classified as
6 0 0 | a = yes
0 2 0 | b = no
0 1 5 | c = maybe

function _abcd(f,i,j) {
  Abcd(i)
  for(j=1; j<=6; j++) Abcd1(i,"yes", "yes")
  for(j=1; j<=2; j++) Abcd1(i,"no",  "no")
  for(j=1; j<=5; j++) Abcd1(i,"maybe",  "maybe")
  Abcd1(i, "maybe","no")
  AbcdReport(i)
}

=== Detailed Accuracy By Class ===
                TP Rate   FP Rate   Precision   Recall  F-Measure   ROC Area  Class
                  1         0          1         1         1          1        yes
                  1         0.083      0.667     1         0.8        0.938    no
                  0.833     0          1         0.833     0.909      0.875    maybe
Weighted Avg.    0.929     0.012      0.952     0.929     0.932      0.938


