# What is this?

ATSCC2JS bindings to the DOM. We also provide additional type safety.

The design is loosely based on [Types and Analysis for Scripting
Languages: Part 4, A Type-Safe DOM
API](http://cs.ioc.ee/~tarmo/tasl08/tasl4.pdf).

We aim to express invariants in the types to guarantee absence of
certain runtime errors by type soundness of
[ATS](https://www.ats-lang.org/) type system.

# Why?

* DOM manipulation is typically tricky and error prone
* ATSCC2JS does not provide comprehensive low-level DOM access
* higher-level libraries can be built on top of this interface

# What *static* guarantees are provided?

1. linked nodes must belong to the same document
2. nonsensical parent/child node type combinations are rejected
3. nodes must form a tree: a node must have at most one parent, and
   the graph must be acyclic
4. out-of-bounds accesses into `NodeList`
