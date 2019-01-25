
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


extern
fun
hello(): void = "mac#"
implement
hello() = let
  macdef myassert (x, e, t) = {
    val () = assert (~domnoderef_is_null (,(x)))
    val () = assert (nodeName ,(x) = ,(e))
    val () = assert (eq_NodeType_NodeType (nodeType ,(x), ,(t)))
  }
  val doc = get_document ()
  prval () = window_document_nonnull ()

  (* p1: no children *)
  val p1 = getElementById (doc, "p1")
  val () = assert (~domnoderef_is_null p1)
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType p1))
  val p1_text = firstChild (p1)
  val () = assert (domnoderef_is_null p1_text)
  val () = dom_free p1_text
  val () = dom_free p1
  
  (* p2: text node child *)
  val p2 = getElementById (doc, "p2")
  val () = assert (~domnoderef_is_null p2)
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType p2))
  val p2_text = firstChild (p2)
  val () = assert (~domnoderef_is_null p2_text)
  val () = assert (eq_NodeType_NodeType (TEXT_NODE, nodeType p2_text))

  prval fpf = dom2cdata p2_text
  val () = assert (1 = cdata_length p2_text)
  val () = assert (" " = cdata_data p2_text)
  prval () = fpf p2_text
  
  val () = dom_free p2_text
  val () = dom_free p2

  (* create and inject a new text node *)  
  val textNode = createTextNode(doc, "Hello")
  val p3 = getElementById (doc, "p3")
  val () = assert (~domnoderef_is_null p3)
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType p3))
  val textNode = appendChild (PC_ECData | p3, textNode)
  
  prval fpf = dom2cdata textNode
  val () = cdata_appendData (textNode, " ")
  val () = cdata_appendData (textNode, "user!")
  val () = assert (11 = cdata_length textNode)
  val () = cdata_insertData (textNode, 5, ",")
  val () = assert ("Hello, user!" = cdata_data textNode)
  val () = cdata_deleteData (textNode, 11, 1)
  val () = cdata_replaceData (textNode, 0, 6, "Hi")
  val () = assert ("Hi user" = cdata_data textNode)
  prval () = fpf textNode
  val () = dom_free textNode
  val () = dom_free p3

  val () = put_document (doc)
in
end

val () = hello ()
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
my_dynload();
//
%} // end of [%{$]
