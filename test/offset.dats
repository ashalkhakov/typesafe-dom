
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
  val doc = get_document ()
  prval () = window_document_nonnull ()
  val div = getElementById (doc, "red")
  val () = assert (~domnoderef_is_null (div))
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType div))
  val () = assert (60.0 = offsetLeft div)
  val () = assert (60.0 = offsetTop div)
  val p = offsetParent div
  val () = assert (~domnoderef_is_null (p))
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType p))
  val () = assert ("BODY" = nodeName p)
  val () = dom_free p
  val () = dom_free div
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


