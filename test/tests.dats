
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"my_dynload"

(* ****** ****** *)

#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js/ATS2-0.3.2"

#include
"{$LIBATSCC2JS}/staloadall.hats"


#staload
"{$LIBATSCC2JS}/SATS/print.sats"

#staload
"./../src/SATS/dom.sats"
#include
"./../src/DATS/dom.dats"

(* ****** ****** *)
//
fun
highlight {d:agz;p:agz} (
  doc: !documentref(d), el1: !domnoderef1(Element, d, p), el2: !domnoderef1(Element, d, p)
): void = {
  val attr = createAttribute (doc, "class")
  val () = attr_setValue(attr, "highlight")
  val e = setAttributeNode (el1, attr)
  val () = dom_free(e)
  // val () = setAttributeNode (el2, attr) // runtime error <- does not type-check
}

fun nest {d0:agz} (
  d: !documentref(d0), n: int
): [c:cls | c <= Node] domnoderef1(c, d0, null) =
  if n = 0 then createTextNode (d, "The end")
  else let
    val v = createElement (d, "div")
    val v1 = nest (d, n-1)
    val e = appendChild (PC_EElement () | v, v1)
    val () = dom_free (e)
  in
    v
  end
//
(* ****** ****** *)
//
fun
testcase1 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  macdef myassert (x, e, t) = {
    val () = assert (~domnoderef_is_null (,(x)))
    val () = assert (nodeName ,(x) = ,(e))
    val () = assert (eq_NodeType_NodeType (nodeType ,(x), ,(t)))
  }
  val () = set_innerHTML (d, "<a href=\"#\">Hi</a> <!-- this is a HTMLAnchorElement which inherits from... -->")
  val a = firstChild (d)
  val () = myassert (a, "A", ELEMENT_NODE)
  val b = nextSibling a
  val () = dom_free a
  val () = myassert (b, "#text", TEXT_NODE)
  val c = nextSibling b
  val () = dom_free (b)
  val () = myassert (c, "#comment", COMMENT_NODE)
  val () = dom_free (c)
}
fun
testcase2 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "hello")
  macdef myassert (d, t, v) = {
    val x = firstChild ,(d)
    val () = assert (~domnoderef_is_null (x))
    val () = assert (eq_NodeType_NodeType (nodeType (x), ,(t)))
    val () = assert (,(v) = nodeValue (x))
    val () = dom_free x
  }
  val () = myassert (d, TEXT_NODE, "hello")
  val () = set_innerHTML (d, "<!-- commentary -->")
  val () = myassert (d, COMMENT_NODE, " commentary ")
}
fun
testcase3 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {

  val () = set_innerHTML (d, "<p>Hi</p>")

  // create a blink element node and text node
  val elementNode = createElement (doc, "strong")
  val textNode = createTextNode(doc, " Dude")

  //append these nodes to the DOM
  val c = firstChild (d)
  val () = assert (~domnoderef_is_null (c))
  val elementNode = appendChild (PC_EElement () | c, elementNode)
  val textNode = appendChild (PC_ECData () | elementNode, textNode)

  val () = assert("<p>Hi<strong> Dude</strong></p>" = get_innerHTML(d))
  val () = dom_free (c)
  val () = dom_free (elementNode)
  val () = dom_free (textNode)

}
fun
testcase4 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<ul><li>2</li><li>3</li></ul>")

  // create a text node and li element node and append the text to the li
  val text1 = createTextNode (doc, "1")
  val li = createElement (doc, "li")
  val text1 = appendChild (PC_ECData () | li, text1)
  val () = dom_free text1

  // select the ul in the document
  val ul = firstChild (d)
  val () = assert (~domnoderef_is_null ul)

  // add the li element we created above to the DOM, notice I call on <ul> and pass reference to <li>2</li> using ul.firstChild
  val li2 = firstChild (ul)
  val () = assert (~domnoderef_is_null li2)
  val li = insertBefore (PC_EElement () | ul, li, li2)

  val () = assert ("<ul><li>1</li><li>2</li><li>3</li></ul>" = get_innerHTML d)
  val () = dom_free li
  val () = dom_free li2
  val () = dom_free ul
}
fun
testcase5 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<div id=\"A\">Hi</div><div id=\"B\">Dude</div>")

  //remove element node
  val divA = getElementById(doc, "A")
  val () = assert (~domnoderef_is_null divA)
  val p = parentNode divA
  val () = assert (~domnoderef_is_null p)
  val divA = removeChild (p, divA)
  val () = dom_free p
  val () = dom_free divA

  //remove text node
  val divB = getElementById(doc, "B")
  val () = assert (~domnoderef_is_null divB)
  val divBText = firstChild divB
  val () = assert (~domnoderef_is_null divBText)
  val divBText = removeChild (divB, divBText)
 
  val () = assert ("<div id=\"B\"></div>" = get_innerHTML d)
  val () = dom_free divB
  val () = dom_free divBText
}
fun
testcase6 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<div id=\"A\">Hi</div><div id=\"B\">Dude</div>")

  //replace element node
  val divA = getElementById (doc, "A")
  val () = assert (~domnoderef_is_null divA)
  val newSpan = createElement (doc, "span")
  val () = set_textContent (newSpan, "Howdy")
  val p = parentNode divA
  val () = assert (~domnoderef_is_null p)
  val newSpan = replaceChild (p, newSpan, divA)
  val () = dom_free p
  val () = dom_free newSpan

  //replace text node
  val divB = getElementById (doc, "B")
  val () = assert (~domnoderef_is_null divB)
  val divBText = firstChild divB
  val () = assert (~domnoderef_is_null divBText)
  val newText = createTextNode(doc, "buddy")
  val newText = replaceChild (divB, newText, divBText)
  val () = dom_free newText
  val () = dom_free divB

  val () = assert ("<span>Howdy</span><div id=\"B\">buddy</div>" = get_innerHTML d)
}
fun
testcase7 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<ul>\
  <li>Hi</li>\
  <li>there</li>\
</ul>")
  val ul = firstChild d
  val () = assert (~domnoderef_is_null ul)
  val cloneUL = cloneNode (ul, false)

  val () = assert ("" = get_innerHTML cloneUL)
  val () = dom_free ul
  val () = dom_free cloneUL
}
fun
testcase8 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<ul>\
  <li>Hi</li>\
  <li>there</li>\
</ul>")
  val ul = firstChild d
  val () = assert (~domnoderef_is_null ul)
  val cloneUL = cloneNode (ul, true)
  val () = assert ("\
  <li>Hi</li>\
  <li>there</li>" = get_innerHTML cloneUL)
  val () = dom_free ul
  val () = dom_free cloneUL
}
fun
testcase9 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<ul>\
  <li>Hi</li>\
  <li>there</li>\
</ul>")
  val ul = firstChild d
  val () = assert (~domnoderef_is_null ul)
  val ulElementChildNodes = children ul // childNodes
 
  val () = assert (2 = domnodelist_length ulElementChildNodes)
  val l1 = domnodelist_item (ulElementChildNodes, 0)
  val l2 = domnodelist_item (ulElementChildNodes, 1)

  val () = assert ("Hi" = get_textContent l1)
  val () = assert ("there" = get_textContent l2)

  val () = dom_free l1
  val () = dom_free l2
  val () = domnodelist_free ulElementChildNodes
  val () = dom_free ul
}
fun
testcase10 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<ul><!-- comment -->\
<li id=\"A\"></li>\
<li id=\"B\"></li>\
<!-- comment -->\
</ul>")

  //cache selection of the ul
  val ul = firstChild d
  val () = assert (~domnoderef_is_null ul)

  //What is the parentNode of the ul?
  val p = parentNode ul
  val () = assert (eq_Node_Node (p, d))
  val () = dom_free p

  //What is the first child of the ul?
  val ul_f = firstChild ul
  val () = assert (~domnoderef_is_null ul_f)
  val () = assert ("#comment" = nodeName ul_f)

  //What is the last child of the ul?
  val ul_l = lastChild ul
  val () = assert (~domnoderef_is_null ul_l)
  val () = assert ("#comment" = nodeName ul_l)

  //What is the nextSibling of the first li?
  val a = getElementById(doc, "A")
  val () = assert (~domnoderef_is_null a)
  val () = assert ("LI" = nodeName a)

  //What is the previousSibling of the last li?
  val b = getElementById(doc, "B")
  val () = assert (~domnoderef_is_null b)
  val ps = previousSibling b
  val () = assert (~domnoderef_is_null ps)
  val () = assert ("LI" = nodeName ps)
 
  val () = dom_free ul
  val () = dom_free ul_f
  val () = dom_free ul_l
  val () = dom_free a
  val () = dom_free b
  val () = dom_free ps
}
fun
testcase11 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<a href='#' title=\"title\" data-foo=\"dataFoo\" class=\"yes\" style=\"margin:0;\" foo=\"boo\"></a>")

  val a = firstChild d
  val () = assert (~domnoderef_is_null a)
 
  val atts = attributes a
  macdef myassert (x, v) = {
    val attribute = domnamednodemap_getNamedItem (atts, ,(x))
    val () = assert (~domnoderef_is_null attribute)
    val () = assert (,(v) = attr_getValue (attribute))
    val () = dom_free attribute
  }
  val () = assert (6 = domnamednodemap_length atts)
  val () = myassert ("href", "#")
  val () = myassert ("title", "title")
  val () = myassert ("data-foo", "dataFoo")
  val () = myassert ("class", "yes")
  val () = myassert ("style", "margin:0;")
  val () = myassert ("foo", "boo")
  val () = domnamednodemap_free atts
  val () = dom_free a
}
//
fun
testcase12 {p:addr}
(doc: !documentref (window_document), d: !domnoderef1(Element, window_document, p)): void = {
  val () = set_innerHTML (d, "<ul>\
<li class=\"liClass\">Hello</li>\
<li class=\"liClass\">big</li>\
<li class=\"liClass\">bad</li>\
<li class=\"liClass\">world</li>\
</ul>")

  val xs = querySelectorAll (d, "li")
  val ys = getElementsByTagName (d, "li")
  val zs = getElementsByClassName (d, "liClass")

  macdef myassert (xs, l) = {
    val () = assert (,(l) = domnodelist_length ,(xs))
    val () = domnodelist_free ,(xs)
  }
  val () = myassert (xs, 4)
  val () = myassert (ys, 4)
  val () = myassert (zs, 4)
}
//
extern
fun
hello(): void = "mac#"
implement
hello() = let

// some dom manipulation
val doc = get_document ()
prval () = window_document_nonnull ()
val () = {
  val x = getElementById(doc, "container")
  val () = assert_errmsg (~domnoderef_is_null x, "woops")
  val () = println!("1")
  val () = testcase1 (doc, x)
  val () = println!("2")
  val () = testcase2 (doc, x)
  val () = println!("3")
  val () = testcase3 (doc, x)
  val () = println!("4")
  val () = testcase4 (doc, x)
  val () = println!("5")
  val () = testcase5 (doc, x)
  val () = println!("6")
  val () = testcase6 (doc, x)
  val () = println!("7")
  val () = testcase7 (doc, x)
  val () = println!("8")
  val () = testcase8 (doc, x)
  val () = println!("9")
  val () = testcase9 (doc, x)
  val () = println!("10")
  val () = testcase10 (doc, x)
  val () = println!("11")
  val () = testcase11 (doc, x)
  val () = println!("12")
  val () = testcase12 (doc, x)
  val () = dom_free (x)
}
val () = {

val r = nest (doc, 4)
val x = getElementById(doc, "container")
val () = assert_errmsg (~domnoderef_is_null x, "woops")
val () = assert_errmsg (eq_NodeType_NodeType (ELEMENT_NODE, nodeType(x)), "wrong nodetype!")
val () = println!("appending!")
val r = appendChild (PC_EElement () | x, r)
val () = dom_free (x)
val () = dom_free (r)

}
(*
val () = {

// faulty! does not typecheck
val a = getElementById(doc, "container")
val () = assert_errmsg (~domnoderef_is_null a, "woops")
val b = getElementById(doc, "container")
val () = assert_errmsg (~domnoderef_is_null b, "woops")

// can try this:
val p = parentNode (b)
// val n = nextSibling (b)
// val b = removeChild (p, b) // b is now orphaned
// val r = appendChild (PC_EElement (), a, b) // perform the faulty appendChild!
// val () = insertBefore (parent, b, n)

val r = appendChild (PC_EElement () | a, b) // [b] must be orphan!
val () = dom_free (a)
val () = dom_free (r)
}
*)
(*
val () = {

// faulty! does not typecheck
val a = getElementById(doc, "container")
val () = assert_errmsg (~domnoderef_is_null a, "woops")
val b = getElementById(doc, "container")
val () = assert_errmsg (~domnoderef_is_null b, "woops")

// can try this:
// val p = parentNode (b)
// val n = nextSibling (b)
// val b = removeChild (p, b) // b is now orphaned
// val r = appendChild (PC_EElement (), a, b) // perform the faulty appendChild!
// val () = insertBefore (parent, b, n)

val r = appendChild (PC_EElement () | a, b) // [b] must be orphan!
val () = dom_free (a)
val () = dom_free (r)
}
*)
(*
// faulty! does not typecheck
val a = getElementById(doc, "container")
val () = assert_errmsg (~domnoderef_is_null a, "woops")
val r = appendChild (PC_EElement () | a, a) // double use prohibited, since [a] is linear
val () = dom_free (a)
val () = dom_free (r)
*)

val () = put_document (doc)

in
  print("Hello, world!")
end
//
(* ****** ****** *)
//
val () = hello()
//
(* ****** ****** *)

%{$
//
function
atspre_assert_bool0(x) {
  if (!x) { throw new"assert failed!"; }
}
function
atspre_assert_bool1(x) {
  if (!x) { throw "assert failed!"; }
}
//
ats2jspre_the_print_store_clear();
my_dynload();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]
