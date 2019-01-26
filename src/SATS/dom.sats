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
// dataset

absvtype strmap (p:addr) = ptr

fun
get_dataset {d,l,p:addr | l > null} (
  !domnoderef(Element, d, l, p)
): strmap (l) = "mac#get_dataset"
castfn
strmap_free {l:addr} (strmap l): void

fun strmap_get {p:addr} (
  s: !strmap(p), k: string
): Option_vt string = "mac#strmap_get"
fun strmap_delete {p:addr} (
  s: !strmap(p), k: string
): void = "mac#strmap_delete"
fun strmap_set {p:addr} (
  s: !strmap(p), k: string, v: string
): void = "mac#strmap_set"

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

classdec Event
classdec UIEvent : Event
classdec MouseEvent : UIEvent
classdec TouchEvent : UIEvent
classdec FocusEvent : UIEvent
classdec KeyboardEvent : UIEvent
classdec WheelEvent : UIEvent
classdec InputEvent : UIEvent

absvtype event(cls, addr) = ptr

(* string ids for events, e.g. onload, and the type of events handled *)
(* NOTE: c is a subtype of Event! *)
abstype eventid(cls) = ptr
fun
eq_eventid_eventid {c1,c2:cls} (
  eventid(c1), eventid(c2)
): [c:cls] bool (c1 <= c && c2 <= c) = "mac#ats2jspre_eq_string_string"
fun
ne_eventid_eventid {c1,c2:cls} (
  eventid(c1), eventid(c2)
): [c:cls] bool (~(c1 <= c && c2 <= c)) = "mac#ats2jspre_ne_string_string"

macdef scroll = $extval (eventid(UIEvent), "'scroll'")
macdef load = $extval (eventid(UIEvent), "'load'")
macdef unload = $extval (eventid(UIEvent), "'unload'")

macdef click = $extval (eventid(MouseEvent), "'click'")
macdef dblclick = $extval (eventid(MouseEvent), "'dblclick'")
macdef mousedown = $extval (eventid(MouseEvent), "'mousedown'")
macdef mouseenter = $extval (eventid(MouseEvent), "'mouseenter'")
macdef mouseleave = $extval (eventid(MouseEvent), "'mouseleave'")
macdef mousemove = $extval (eventid(MouseEvent), "'mousemove'")
macdef mouseout = $extval (eventid(MouseEvent), "'mouseout'")
macdef mouseup = $extval (eventid(MouseEvent), "'mouseup'")
macdef mouseover = $extval (eventid(MouseEvent), "'mouseover'")

// TODO: form events (change, reset, submit, select, input)
// TODO: drag events (drag, dragstart, dragend, dragenter, dragleave, dragover, drop)

macdef focus = $extval (eventid(FocusEvent), "'focus'")
macdef blur = $extval (eventid(FocusEvent), "'blur'")
macdef focusin = $extval (eventid(FocusEvent), "'focusin'")
macdef focusout = $extval (eventid(FocusEvent), "'focusout'")

macdef keydown = $extval (eventid(KeyboardEvent), "'keydown'")
macdef keypress = $extval (eventid(KeyboardEvent), "'keypress'")
macdef keyup = $extval (eventid(KeyboardEvent), "'keyup'")

macdef wheel = $extval (eventid(WheelEvent), "'wheel'")

typedef event_prop (c:cls, r:t0p) = {c1:cls;d:addr | c1 <= c} (!event(c1, d)) -> r
typedef event_prop1 (c:cls, a:t0p, r:t0p) = {c1:cls;d:addr | c1 <= c} (!event(c1, d), a) -> r

fun ev_bubbles : event_prop (Event, bool) = "mac#ev_bubbles"
fun ev_cancelable : event_prop (Event, bool) = "mac#ev_cancelable"
(* TODO: investigate if can we change/unlink these elements in the handler?
TODO: investigate if these can be null?
 *)
fun ev_currentTarget : {d:addr} (!event(Event, d)) -> [c:cls] domnoderef1D (c, d)(*readonly*)
fun ev_target : {d:addr} (!event(Event, d)) -> [c:cls] domnoderef1D (c, d)(*readonly*)
fun ev_defaultPrevented : event_prop (Event, bool) = "mac#defaultPrevented"

// https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
fun ev_eventPhase : event_prop (Event, string) = "mac#ev_eventPhase"
fun ev_type : {c:cls;d:addr} (!event(c, d)) -> eventid(c) = "mac#ev_type"
fun ev_timeStamp : event_prop (Event, int) = "mac#ev_timeStamp"

fun ev_preventDefault : event_prop (Event, void) = "mac#ev_preventDefault"
fun ev_stopPropagation : event_prop (Event, void) = "mac#ev_stopPropagation"

absvtype eventlistener(cls) = ptr
fun eventlistener_obj {v:vtype} {d:addr} {c:cls} (
  state: v
, et: eventid(c)
, handler: (v, !event(c, d)) -> v
, free: (v) -> void
): eventlistener(c) = "mac#eventlistener_obj"
fun eventlistener_fun {d:addr} {c:cls} (
  et: eventid(c)
, handler: (!event(c, d)) -> void
): eventlistener(c) = "mac#eventlistener_fun"
fun eventlistener_free {c:cls} (eventlistener(c)): void = "mac#eventlistener_free"
// NOTE: there doesn't seem to be any provision about event listener lifetime in the DOM!
castfn
eventlistener_leak {c:cls} (eventlistener(c)): void

dataprop EventTarget (cls) =
  | ETdoc (Document)
  | ETelem (Element)

typedef event_options = $extype_struct "EventOptions" of {
  capture= bool
, once= bool
, passive= bool
}
fun event_options (capture: bool, once: bool, passive: bool) : event_options = "mac#event_options"

fun
addEventListener {e,c:cls;d,l,p:addr | l > null} (
  EventTarget(c)
| !domnoderef (c, d, l, p)
, etype: eventid(e)
, listener: !eventlistener(e)
, options: event_options
): void = "mac#addEventListener"
fun
removeEventListener {e,c:cls;d,l,p:addr | l > null} (
  EventTarget(c)
| !domnoderef (c, d, l, p)
, etype: eventid(e)
, listener: !eventlistener(e)
, options: event_options
): void = "mac#removeEventListener"

(* TODO: with https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
fun
dispatchEvent {e,c:cls;d:addr} (
  EventTarget(c)
| !domnoderef1D(c, d)
, !event(e, d) // must be an instance of CustomEvent
): bool(*NOT cancelled*)
*)

abstype KeyboardEvent_key = string
// FIXME: what to do with it?

fun mouse_altKey : event_prop (MouseEvent, bool) = "mac#mouse_altKey"
fun mouse_button : event_prop (MouseEvent, intBtw(0, 4)) = "mac#mouse_button"
fun mouse_buttons : event_prop (MouseEvent, intBtw(0, 4)) = "mac#mouse_buttons"
fun mouse_clientX : event_prop (MouseEvent, double) = "mac#mouse_clientX"
fun mouse_clientY : event_prop (MouseEvent, double) = "mac#mouse_clientY"
fun mouse_ctrlKey : event_prop (MouseEvent, bool) = "mac#mouse_ctrlKey"
fun mouse_metaKey : event_prop (MouseEvent, bool) = "mac#mouse_metaKey"
fun mouse_movementX : event_prop (MouseEvent, double) = "mac#mouse_movementX"
fun mouse_movementY : event_prop (MouseEvent, double) = "mac#mouse_movementY"
fun mouse_screenX : event_prop (MouseEvent, double) = "mac#mouse_screenX"
fun mouse_screenY : event_prop (MouseEvent, double) = "mac#mouse_screenY"
fun mouse_shiftKey : event_prop (MouseEvent, bool) = "mac#mouse_shiftKey"
fun mouse_getModifierState : event_prop1 (MouseEvent, KeyboardEvent_key, bool) = "mac#mouse_getModifierState"

(*
// TODO: TouchEvent
altKey: bool
changedTouches: TouchList
ctrlKey: bool
metaKey: bool
shiftKey: bool
targetTouches: TouchList
touches: TouchList
*)

fun focus_relatedTarget {e:cls;d:addr} (
  !event(FocusEvent, d)
): [p:addr;e:cls] (EventTarget (e) | domnoderef0(e, d, p)) = "mac#focus_relatedTarget"

fun keyboard_getModifierState : event_prop1 (KeyboardEvent, KeyboardEvent_key, bool) = "mac#keyboard_getModifierState"
fun keyboard_altKey : event_prop (KeyboardEvent, bool) = "mac#keyboard_altKey"
//  charCode : int // deprecated
// some code: https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
fun keyboard_code : event_prop (KeyboardEvent, string) = "mac#keyboard_code"
fun keyboard_ctrlKey : event_prop (KeyboardEvent, bool) = "mac#keyboard_ctrlKey"
fun keyboard_key : event_prop (KeyboardEvent, KeyboardEvent_key) = "mac#keyboard_key"
fun keyboard_metaKey : event_prop (KeyboardEvent, bool) = "mac#keyboard_metaKey"
fun keyboard_repeat : event_prop (KeyboardEvent, bool) = "mac#keyboard_repeat"
fun keyboard_shiftKey : event_prop (KeyboardEvent, bool) = "mac#keyboard_shiftKey"

fun wheel_deltaX : event_prop (WheelEvent, double) = "mac#wheel_deltaX"
fun wheel_deltaY : event_prop (WheelEvent, double) = "mac#wheel_deltaY"
fun wheel_deltaZ : event_prop (WheelEvent, double) = "mac#wheel_deltaZ"
// DOM_DELTA_PIXEL=0x00, DOM_DELTA_LINE=0X01, DOM_DELTA_PAGE=0x02
fun wheel_deltaMode : event_prop (WheelEvent, int) = "mac#wheel_deltaMode"
