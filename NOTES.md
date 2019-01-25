# current iteration

http://domenlightenment.com/#1.2

* DONE: node types
* DONE: reflecting the node types back to the class decs
* DONE: node methods
* DONE: node properties
* TODO: class and data-* attributes
* DONE: 4.2,4.4 querySelector, querySelectorAll, getElementsByTagName,
  getElementsByClassName
* DONE: section 5, properties for elements
* DONE: section 6, style
* DONE: section 7, text node methods
* DONE: sec 8, document fragments
* TODO: 11, event handling! now this makes it all worth it! after
  this, integrate into my very own custom expression editor!
  * form events: submit, reset
  * view events: resize, scroll
  * keyboard events: keydown, keypress, keyup
  * mouse events: mouseenter, mouseover, mousemove, mousedown,
    mouseup, click, dblclick, mouseleave, mouseout, select
  * window events: close
  * touch events: cancel, end, enter, leave, move, start
  * standard events:
    * blur (FocusEvent), change (Event), click/dblclick (MouseEvent)
    * DOMActivate (UIEvent)
* TODO: more working programs to see if the current style is OK or not
  (especially with cycles and stuff)

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
