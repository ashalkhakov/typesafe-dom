(*
** Hello, world!
*)

(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME\
/contrib/libatscc2js/ATS2-0.3.2"
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

classdec Node // super type
classdec Document : Node // subtype or subclass
classdec Element : Node
classdec Attr : Node
classdec DocumentType : Node
classdec Notation : Node
classdec Entity : Node
classdec EntityReference : Node
classdec ProcessingInstruction : Node
classdec CharacterData : Node
classdec Comment : CharacterData
classdec Text : CharacterData
classdec CDataSection : Text
classdec DocumentFragment : Node

abst@ype NodeType (cls) = int
macdef ELEMENT_NODE = $extval (NodeType (Element), "1")
macdef ATTRIBUTE_NODE = $extval (NodeType (Attr), "2")
macdef TEXT_NODE = $extval (NodeType(Text), "3")
macdef CDATA_SECTION_NODE = $extval (NodeType(CDataSection), "4")
macdef ENTITY_REFERENCE_NODE = $extval (NodeType(EntityReference), "5")
macdef ENTITY_NODE = $extval (NodeType(Entity), "6")
macdef PROCESSING_INSTRUCTION_NODE = $extval (NodeType(ProcessingInstruction), "7")
macdef COMMENT_NODE = $extval (NodeType(Comment), "8")
macdef DOCUMENT_NODE = $extval (NodeType(Document), "9")
macdef DOCUMENT_TYPE_NODE = $extval (NodeType(DocumentType), "10")
macdef DOCUMENT_FRAGMENT_NODE = $extval (NodeType(DocumentFragment), "11")
macdef NOTATION_NODE = $extval (NodeType(Notation), "12")

fun
eq_NodeType_NodeType {c1,c2:cls} (NodeType(c1), NodeType(c2)): [c:cls] bool (c1 <= c && c2 <= c) = "mac#ats2jspre_eq_int1_int1"

fun
ne_NodeType_NodeType {c1,c2:cls} (NodeType(c1), NodeType(c2)): [c:cls] bool (~(c1 <= c && c2 <= c)) = "mac#ats2jspre_neq_int1_int1"

dataprop ParentChild (cls, cls) = // TODO: DOM 1.1.1 ?
  | PC_Document_Element (Document, Element)
  | PC_Document_ProcessingInstruction (Document, ProcessingInstruction)
  | PC_Document_Comment (Document, Comment)
  | PC_Document_DocumentType (Document, DocumentType)
  | PC_DFElement (DocumentFragment, Element)
  | PC_DFProcessingInstruction (DocumentFragment, ProcessingInstruction)
  | PC_DFCharacterData (DocumentFragment, CharacterData)
  // | DocumentFragment, EntityReference  
(*
EntityReference, Element
EntityReference, ProcessingInstruction
EntityReference, Comment
EntityReference, Text
EntityReference, CDATASection
EntityReference, EntityReference
*)
  | PC_EElement (Element, Element)
  | PC_ECData (Element, CharacterData)
  // | ParentChild_EER (Element, EntityReference)
  | PC_AText (Attr, Text)
  // | ParentChild_AER (Attr, EntityReference)
(*
Entity, Element
Entity, ProcessingInstruction
Entity, Comment
Entity, Text
Entity, CDATASection
Entity, EntityReference
*)

(* the classic ATS style, where we track addresses of each node.
makes programming hard due to having to match up a lot of indices to appease the
typechecker.
*)
// for each node, also: owner doc, parent pointer? that's 4 indices already. oh.
absvtype
domnoderef_vtype (c: cls, d:addr, l:addr, p:addr) = ptr
vtypedef
domnoderef (c:cls, d:addr, l:addr, p:addr) = domnoderef_vtype (c, d, l, p)
vtypedef
domnoderef0 (c:cls, d:addr, p:addr) = [l:agez] domnoderef (c, d, l, p)
vtypedef
domnoderef1 (c:cls, d:addr, p:addr) = [l:addr | l > null] domnoderef (c, d, l, p)

vtypedef domnode (d: addr, p:addr, l:addr) = [c:cls | c <= Node] domnoderef (c, d, l, p)

// class, document object, self object, parent object
vtypedef documentref (d:addr) = domnoderef (Document, d, d, null)
vtypedef
domnoderef1D (c:cls, d:addr) = [l:addr | l > null] domnoderef (c, d, l, null)
vtypedef
domnoderef1P (c:cls, d:addr, p:addr) = [l:addr | p > null; l > null] domnoderef (c, d, l, p)
(*
linear type for nodes:
N (node_type, owner_document, kinship_status, kinship_degree)

kinship_status: Attached, Detached or unknown(any)
kinship_degree: phi(unknown/any?), R (document root - no parent), F(f') - parent degree of f', f'+f'' - a choice/union of parent degrees between f' and f''
*)

fun
eq_Node_Node {c1,c2:cls;d,l1,l2,p1,p2:addr} (
  !domnoderef(c1, d, l1, p1), !domnoderef(c2, d, l2, p2)
): [c:cls] bool (c1 <= c && c2 <= c && l1 == l2 && p1 == p2) = "mac#ats2jspre_eq_int1_int1"

fun
ne_Node_Node {c1,c2:cls;d,l1,l2,p1,p2:addr} (!domnoderef(c1, d, l1, p1), !domnoderef(c2, d, l2, p2)):
  [c:cls] bool (~(c1 <= c && c2 <= c && l1 == l2 && p1 == p2)) = "mac#ats2jspre_neq_int1_int1"

absvtype domnodelist (addr, int) = ptr

prfun domnodelist_param_lemma {d:addr;n:int} (!domnodelist(d, n)): [n >= 0] void

fun domnodelist_length {d:addr;n:int}
  (!domnodelist(d, n)): int n
  = "mac#"

fun domnodelist_item {d:addr;n:pos;i:nat| i < n}
 (!domnodelist(d, n), int i)
  : [c:cls;p:addr | c <= Node] domnoderef1 (c, d, p)
  = "mac#"

castfn
domnodelist_free {d:addr;n:int}
 (domnodelist (d, n)): void

absvtype domnamednodemap (int, addr, addr) = ptr

prfun domnamednodemap_param_lemma {d,p:addr;n:int}
  (!domnamednodemap(n, d, p)): [n >= 0] void

fun
domnamednodemap_length {n:int;d,p:addr}
  (!domnamednodemap(n, d, p)): int n = "mac#"

fun
domnamednodemap_getNamedItem {n:int;d,p:addr}
  (!domnamednodemap(n, d, p), s: string): domnoderef0(Attr, d, p) = "mac#"

fun
domnamednodemap_setNamedItem {n:int;d,l,p,p1:addr | l > null}
  (!domnamednodemap(n, d, p), s: domnoderef (Attr, d, l, p1)): domnoderef(Attr, d, l, p) = "mac#"

fun
domnamednodemap_removeNamedItem {n:int;d,p:addr}
  (!domnamednodemap(n, d, p), s: string): domnoderef0 (Attr, d, p) = "mac#"

fun
domnamednodemap_item {n:pos;i:nat;d,p:addr | i < n}
  (!domnamednodemap(n, d, p), i: int i)
  : domnoderef1(Attr, d, p) = "mac#"

castfn
domnamednodemap_free {n:int;d,p:addr} (domnamednodemap(n,d,p)): void

fun getElementById
  {c:cls;d,p:addr | c <= Document || c <= Element || c <= DocumentFragment}
  (doc: !domnoderef1 (c, d, p), id: string):
  [p1:agz] domnoderef0 (Element, d, p1) = "mac#"

fun getElementsByTagName {c:cls;d,p:addr | c <= Document || c <= Element}
  (doc: !domnoderef1 (c, d, p), tagname: string):
  [n:int] domnodelist (d, n) = "mac#"

fun getElementsByClassName {c:cls;d,p:addr | c <= Document || c <= Element}
  (doc: !domnoderef1 (c, d, p), classname: string):
  [n:int] domnodelist (d, n) = "mac#"

fun querySelectorAll {c:cls;d,p:addr | c <= Document || c <= Element || c <= DocumentFragment}
  (doc: !domnoderef1 (c, d, p), selector: string):
  [n:int] domnodelist (d, n) = "mac#"

fun querySelector {c:cls;d,p:addr | c <= Document || c <= Element || c <= DocumentFragment}
  (doc: !domnoderef1 (c, d, p), selector: string):
  domnoderef0 (Element, d, p) = "mac#"

fun domnoderef_is_null {c:cls;d,l,p:addr} (!domnoderef (c, d, l, p))
  : bool (l == null) = "mac#"

(*
createAttribute {delta,kappa,phi}
(doc: Node(Document, delta, kappa, R), name: string) ->
Node(Attr, delta, D, phi)
*)

fun createAttribute {d:addr}
  (doc: !documentref(d), name: string): domnoderef1D (Attr, d) = "mac#"
(*
called on the root document node and
creates a detached attribute node
*)

fun attr_setValue {d,p:addr} (!domnoderef1(Attr, d, p), v: string): void = "mac#"

fun attr_getValue {d,p:addr} (!domnoderef1(Attr, d, p)): string = "mac#"

// node properties

fun attributes {c:cls;d,p:addr | c <= Element}
  (!domnoderef1(c, d, p)) : [n:int] domnamednodemap (n, d, p) = "mac#"


fun children {c:cls;d,p:addr | c <= Document || c <= Element || c <= DocumentFragment}
  (!domnoderef1(c, d, p)): [n:int] domnodelist (d, n) = "mac#"

fun firstChild {c:cls;d,l,p:addr | l > null}
  (!domnoderef(c, d, l, p)): [c':cls] domnoderef0(c', d, l) = "mac#"

fun lastChild {c:cls;d,l,p:addr | l > null}
  (!domnoderef(c, d, l, p)): [c':cls] domnoderef0(c', d, l) = "mac#"

fun nextSibling {c:cls;d,l,p:addr}
  (!domnoderef1(c, d, p)): [c':cls] domnoderef0(c', d, p) = "mac#"

fun previousSibling {c:cls;d,l,p:addr}
  (!domnoderef1(c, d, p)): [c':cls] domnoderef0(c', d, p) = "mac#"

fun nodeName {c:cls;d,p:addr}
  (!domnoderef1(c, d, p)): string = "mac#"

fun
nodeType {c:cls;d,p:addr} (!domnoderef1(c, d, p)): NodeType(c) = "mac#"

fun
nodeValue {c:cls;d,p:addr | c <= CharacterData} (!domnoderef1(c, d, p)): string = "mac#"

fun parentNode {c:cls;d,l,p:addr}
  (!domnoderef1(c, d, p)): [c':cls;p1:addr] domnoderef(c', d, p, p1) = "mac#"


fun set_innerHTML {c:cls;d,p:addr | c <= Document || c <= Element}
  (!domnoderef1(c, d, p), s: string): void = "mac#"

fun get_innerHTML {c:cls;d,p:addr | c <= Document || c <= Element}
  (!domnoderef1(c, d, p)): string = "mac#"

fun set_textContent {c:cls;d,p:addr | c <= Document || c <= Element || c <= DocumentFragment}
  (!domnoderef1(c, d, p), s: string): void = "mac#"

fun get_textContent {c:cls;d,p:addr | c <= Document || c <= Element || c <= DocumentFragment}
  (!domnoderef1(c, d, p)): string = "mac#"


// node methods

(*
setAttributeNode {delta,kappa,phi,phi'} (
Node(Element, delta, kappa, phi), Node(Attr,delta, D, F(phi))) ->
Node(Attr, delta, D, phi')
*)

fun setAttributeNode {d,p:addr}
  (elt: !domnoderef1P (Element, d, p), a: domnoderef1D (Attr, d))
  : domnoderef0 (Attr, d, p) = "mac#"
(*
takes a detached attribute
attaches to an element
returns previous (now detached) attribute of the same name
*)
(*
appendChild {delta,kappa, phi, gamma, gamma' | ParentChild(gamma,gamma')}
  (node: Node(gamma,delta,kappa, phi), s: Node(gamma', delta, D, F(phi))) ->
  Node(gamma',delta,A,F(phi))
*)

fun
appendChild {g,g',g1,g1':cls;d:addr;l0,l1:agz;p:addr | g1 <= g; g1' <= g'}
  (pf: ParentChild (g, g') | node: !domnoderef (g1, d, l0, p), s: domnoderef (g1', d, l1, null))
  : domnoderef (g', d, l1, l0) = "mac#"
(*
ParentChild: this defines if two node types can be in parent-child relationship
e.g. ParentChild Elem,Attr and ParentChild Elem,Elem but not
ParentChild Attr,Elem

if parent has kinship degree phi, then child must have kinship degree F(phi)
*)

fun
insertBefore {g,g',g'',g1,g1':cls;d:addr;l0,l1:agz;p:addr | g1 <= g; g1' <= g'}
  (pf: ParentChild (g, g') | node: !domnoderef (g1, d, l0, p), s: domnoderef (g1', d, l1, null), next: !domnoderef0 (g'', d, l0))
  : domnoderef (g', d, l1, l0) = "mac#"

fun
removeChild {g,g':cls;d,l,l0,p:addr | l0 > null; l > null} (node: !domnoderef (g, d, l0, p), s: domnoderef (g', d, l, l0))
  : domnoderef (g', d, l, null) = "mac#"

fun
replaceChild {g,g',g'':cls;d,l0,l1,l2,p:addr | l0 > null; l1 > null; l2 > null}
  (node: !domnoderef (g, d, l0, p), newChild: domnoderef (g', d, l1, null), oldChild: domnoderef (g'', d, l2, l0))
  : domnoderef (g'', d, l2, null) = "mac#"
(*
cloneNode {delta,kappa,phi,phi',gamma}
  (Node(gamma,delta,kappa,phi), deep: bool): Node(gamma,delta,O,phi)
*)

fun
cloneNode {g:cls;d,p:addr | g <= Node}
  (e: !domnoderef1(g, d, p), deep: bool): domnoderef1(g, d, null) = "mac#"
(*
clones a given node (deeply?)
as you can see, the return type indicates it is now Detached
and has the same kinship degree as the passed-in node (?)
*)
(*
createTextNode {d0,f0}
(doc: Node(Document,d0,O,R), text: string): Node(Text,d0,O,f0)
createElement {d0,f0}
(doc: Node(Document,d0,O,R), name: string): Node(Element,d0,O,f0)
*)

fun
createTextNode {d0:addr}
(doc: !documentref(d0), text: string): domnoderef1(Text, d0, null) = "mac#"

fun
createElement {d0:addr}
(doc: !documentref(d0), name: string): domnoderef1(Element, d0, null) = "mac#"
(*
both of these methods return nodes of specific types
such that:
- they are Orphaned, i.e. have no parent
- they belong to the same document as the one passed-in
- they have the same kinship status as passed-in(?)
*)
(*
createDocument {delta,phi}
(string, string, N(DocumentType,delta,O,phi)) ->
N(Document,delta,O,R)
*)

fun
createDocument {delta:addr}
(a: string, b: string, doctype: domnoderef1(DocumentType,delta,null)):
documentref(delta) = "mac#"
(*
they also note that delta is bound with a "nu" binder,
which is generative, so that it acts as existential BUT
every two abstracted identities are different (so, every
call to createDocument creates different docs!)
*)

(*

they say that the kinship status is affine
O may be split into O and P
P may be split into P and P
O may be discarded (oops)
it's an interesting take. they don't have to track actual identities of nodes!
also the father information is very curious. why is it correct???

can we encode all this straight in ATS?
- we could just track the detached/attached property in a dataview :)
- then we could add some proof functions to implement the splitting and the discarding :)
- then the node itself becomes non-linear, but it should contain some identifier
  to match it with its proof!
- v1: the classic ATS style. have a hole with the global acyclicity invariant.
  - have to figure out how authors use D and parent abstraction to make things easy.
- v2: ?

or we could just make all nodes linear. and keep their annotations intact.

note that the nodes are non-linear and YET! we have all the freedom we want.
and we can modify stuff and not break any invariants of acyclicity at all.

*)
(* ****** ****** *)

stacst window_document : addr

praxi window_document_nonnull : () -<prf> [window_document > null] void


castfn
dom_free {c:cls;d,l,p:addr} (e: domnoderef(c,d,l,p)): void

fun
get_document (): documentref (window_document) = "mac#"

castfn
put_document (documentref(window_document)): void = "mac#"

(* ****** ****** *)

fun
offsetLeft {d,p:addr} (
  elem: !domnoderef1 (Element, d, p)
): double = "mac#"
fun
offsetTop {d,p:addr} (
  elem: !domnoderef1 (Element, d, p)
): double = "mac#"
fun
offsetWidth {d,p:addr} (
  elem: !domnoderef1 (Element, d, p)
): double = "mac#"
fun
offsetHeight {d,p:addr} (
  elem: !domnoderef1 (Element, d, p)
): double = "mac#"
fun
offsetParent {d,p:addr} (
  elem: !domnoderef1 (Element, d, p)
): [p1:addr] domnoderef0 (Element, d, p1) = "mac#"

fun
clientWidth {d,p:addr} (
  elem: !domnoderef1 (Element, d, p)
): double = "mac#"
fun
clientHeight {d,p:addr} (
  elem: !domnoderef1 (Element, d, p)
): double = "mac#"

typedef domrect = $extype_struct "DOMRect" of {
  x= double, y= double
, width= double, height= double
, top= double, right= double, bottom= double, left= double
}

fun
getBoundingClientRect {d,p:addr} (
  elem: !domnoderef1 (Element, d, p)
): domrect = "mac#"

fun
elementFromPoint {d:addr} (
  doc: !documentref (d), left: double, top: double
): [p:addr] domnoderef0 (Element, d, p) = "mac#"

fun
get_scrollWidth {d,p:addr} (
  !domnoderef1(Element, d, p)
): double = "mac#"
fun
get_scrollHeight {d,p:addr} (
  !domnoderef1(Element, d, p)
): double = "mac#"

fun
set_scrollTop {d,p:addr} (
  !domnoderef1(Element, d, p), v: double
): void = "mac#"
fun
get_scrollTop {d,p:addr} (
  !domnoderef1(Element, d, p)
): double = "mac#"

fun
set_scrollLeft {d,p:addr} (
  !domnoderef1(Element, d, p), v: double
): void = "mac#"
fun
get_scrollLeft {d,p:addr} (
  !domnoderef1(Element, d, p)
): double = "mac#"

fun
scrollIntoView {d,p:addr} (
  !domnoderef1(Element, d, p)
, top: bool
): void = "mac#"

(* ****** ****** *)

absvtype
CSSStyleDeclaration (p:addr, writable: bool) = ptr
vtypedef CSSStyleDeclaration (p:addr) = [w:bool] CSSStyleDeclaration(p, w)

fun
get_style {d,l,p:addr | l > null} (
  !domnoderef(Element, d, l, p)
): CSSStyleDeclaration (l, true) = "mac#"
castfn
style_free {l:addr} (CSSStyleDeclaration l): void

fun
getPropertyValue {p:addr} (
  s: !CSSStyleDeclaration(p), p: string
): string = "mac#" // or null

fun
removeProperty {p:addr} (
  s: !CSSStyleDeclaration(p, true), p: string
): void = "mac#"

fun
setProperty {p:addr} (
  s: !CSSStyleDeclaration(p, true)
, p: string, v: string
, priorty: string
): void = "mac#"

fun
getComputedStyle {d,l,p:addr | l > null} (
  e: !domnoderef (Element, d, l, p)
): CSSStyleDeclaration (l, false) = "mac#window_getComputedStyle"

(* ****** ****** *)
// text/comment nodes

absvtype cdata(n:int,l:addr) = ptr
vtypedef cdata0 (l:addr) = [n:int] cdata (n, l)

prfun
dom2cdata : {c:cls;d,l,p:addr | l > null; c <= CharacterData}
  (!domnoderef(c, d, l, p) >> cdata0 (l)) -> ((!cdata0(l) >> domnoderef(c,d,l,p)) -<lin,prf> void)

fun
cdata_length {n:int;l:addr} (!cdata(n,l)): int(n) = "mac#cdata_length"
fun
cdata_data {n:int;l:addr} (!cdata(n,l)): string(n) = "mac#cdata_data"

fun
cdata_appendData {n,m:int;l:addr} (
  cd: !cdata (n,l) >> cdata(n+m,l)
, data: string(m)
): void = "mac#cdata_appendData"

fun
cdata_insertData {i,n,m:int;l:addr | i >= 0; i < n} (
  cd: !cdata(n,l) >> cdata(n+m,l)
, offset: int(i)
, data: string(m)
): void = "mac#cdata_insertData"

fun
cdata_deleteData {i,j,n:int;l:addr | i >= 0; j >= 0; i + j <= n} (
  cd: !cdata(n,l) >> cdata(n-j,l)
, offset: int(i)
, count: int(j)
): void = "mac#cdata_deleteData"

fun
cdata_replaceData {i,j,n,m:int;l:addr | i >= 0; j >= 0; i + j < n} (
  cd: !cdata(n,l) >> cdata(n - j + m,l)
, offset: int(i)
, count: int(j)
, data: string(m)
): void = "mac#cdata_replaceData"

(* ****** ****** *)

(*

TODO: do this or not?

Every fragment will have a parent node type it will get inserted into
(either by appending or by inserting before the other child).

fragment_type (c:cls, l:addr)

fun
createDocumentFragment {c:cls;d:addr}
  (d: !documentref1(d)): [l:agz] (
    fragment_parent_type (c, l)
  | domnoderef (DocumentFragment, d, l, null)
  )

when appending to the document fragment or inserting, the new child's
node type [n] MUST be allowable as a child of [c]!

next, when we mount the fragment onto the tree: 

- the [c] of the document fragment must be allowable as a child of the
node [n] that is to become a parent of the fragment!

- mounting a fragment also frees it

*)

fun
createDocumentFragment {d:addr}
  (doc: !documentref(d)): domnoderef1D (DocumentFragment, d) = "mac#"

fun
fragment_appendChild {g:cls;d:addr;l0:agz;p:addr}
  (node: !domnoderef (g, d, l0, p), s: domnoderef1D (DocumentFragment, d))
  : void = "mac#"
fun
fragment_insertBefore {g,g':cls;d:addr;l0:agz;p:addr}
  (node: !domnoderef (g, d, l0, p), s: domnoderef1D (DocumentFragment, d), next: !domnoderef0 (g', d, l0))
  : void = "mac#"

(* ****** ****** *)

absvtype Event (d:addr, c:cls) = ptr
(*
typedef Event (d:addr) = @{
  bubbles= bool
, cancelable= bool
, defaultPrevented= bool
, target= [c:cls] domnoderef1 (c, d)
, type= string
}
fun
preventDefault (!Event(d)): void
fun
stopPropagation (!Event(d)): void
*)
(*
hierarchy

Event
  UIEvent
    MouseEvent
    TouchEvent
    FocusEvent
    KeyboardEvent
    WheelEvent
    InputEvent

MouseEvent {
  altKey= bool,
  button= intBtw(0,4),
  buttons= intBtw(0,4),
  clientX= double, // also: x
  clientY= double, // also: y
  ctrlKey= bool,
  metaKey= bool,
  movementX= double,
  movementY= double,
  screenX= double,
  screenY= double,
  shiftKey= bool,
  getModifierState= (modifier) -> bool // modifier: as in keyboard event!
}
KeyboardEvent {
  getModifierState= (modifier) -> bool,
  altKey= bool,
  charCode= int, // deprecated
  code= string, // some code: https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
  ctrlKey= bool,
  key= string, // hmmm
  metaKey= bool,
  repeat= bool,
  shiftKey= bool,
}
WheelEvent {
  deltaX= double,
  deltaY= double,
  deltaZ= double,
  deltaMode = ulong // DOM_DELTA_PIXEL=0x00, DOM_DELTA_LINE=0X01, DOM_DELTA_PAGE=0x02
}

https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
// which DOM classes implement EventTarget???

EventTarget.addEventListener(type: string, listener : EventListener, options)

EventListener
- an object with method handleEvent(e: !Event): void
- or simply a function: (!Event) -> void
- what is the lifetime of event listener??? unspec'd

options:
- either a record:
  - capture: bool
  - once: bool
  - passive: bool (the handler will NEVER invoke preventDefault)
- or a boolean: useCapture
- or undefined

EventTarget.removeEventListener(type,listener,options)
- the values of arguments must match the corresponding addEventListener call!
*)
