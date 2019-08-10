[Experience suggests](/REFS#agrawal-2019) that the twin technologies
of data mining and optimization are so closely connected that 
data miners can work as
optimizers and vice versa. 
Once refactored in that way,
the new code offers many novel
design options,
some of which could even contribute to ethical goals. For example:

- It is ethical to deliver transparent and reliable code: rule learners help transparency;
  multi-objective optimization helps reliability);
- Inclusiveness is an ethical goal: inclusiveness is helped by transparency; also,
  active learners, that incrementally improve a system using just a few carefully selected questions
  help humans to be included in the development process).
- Explanation is another goal, that helped by transparency and inclusiveness.
  It is  also a 
  legal requirement for AI systems[^legal]: rule learners, and contrast sets learners, help explanation.
- Privacy is another ethical goals: prototype learners sub-sample the data, 
  thus making private anything outside the prototypes.
- etc.


FUN is a work-on-progress with the aim to build a reference system
that demonstrates all the above, in one succinct code base.  

Ideally, you do not like FUN. Ideally, 
you look here and says "I can do better than that", then
rushes off to refactor their own ethical code (in which case, all
the code here would become a spec for their implementation in  some
other language).

[^legal]: From the European Union General Data Protection Regulation (enacted 2016, taking effect 2018): "In any case, such processing should be subject to suitable safeguards, which should include specific information to the data subject and the right to obtain human intervention, to express his or her point of view, <b>to obtain an explanation of the decision reached</b> after such assessment and to challenge the decision."

