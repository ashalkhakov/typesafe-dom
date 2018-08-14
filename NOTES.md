# current iteration

http://domenlightenment.com/#1.2

DONE: node types
DONE: reflecting the node types back to the class decs
DONE: node methods
DONE: node properties
TODO: class and data-* attributes
TODO: 4.2,4.4 querySelector, querySelectorAll, getElementsByTagName, getElementsByClassName
TODO: section 5, properties for elements
TODO: section 6, style
TODO: section 7, text node methods
TODO: sec 7, document fragments
TODO: 11, event handling! now this makes it all worth it! after this, integrate into my very own custom expression editor!
TODO: more working programs to see if the current style is OK or not (especially with cycles and stuff)

# references

http://cs.ioc.ee/~tarmo/tasl08/tasl4.pdf

lots of exisitng work.
easy to embed in ATS!

https://github.com/raquo/scala-dom-types/blob/master/shared/src/main/scala/com/raquo/domtypes/generic/keys/Style.scala
similar stuff.

https://sci-hub.tw/http://link.springer.com/10.1007/11601524_11
the only way to get it

we can type the DOM API such that:
- it is safe to use
- it is high-performance and makes ATS almost a first-class citizen to the browser
- new libraries can be formed that use it to implement higher-level abstractions

the hierarchy of node types: node_type (with a "subtype" relation, e.g. all Documents are Nodes)
Node
- Document
- Element
- Attr
- DocumentType
- Notation
- Entity
- EntityReference
- ProcessingInstruction
- CharacterData
  - Comment
  - Text
    - CDataSection
*)

(*
// text/comment nodes

appendData(
  CharacterData(n) >> CharacterData(n+m), data: string(m)
): void
insert{i<n}(CharacterData(n), offset:int(i), string data)
deleteData{i+j<n}(CharacterData(n), offset:int(i), count:int(j))
replaceData{i+j<n}(
  CharacterData(n) >> CharacterData(n-j+m)
, offset(i), count(j), data:string(m)
)
*)
