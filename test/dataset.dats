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

  val d = getElementById (doc, "d")
  val () = assert (~domnoderef_is_null (d))
  val () = assert (eq_NodeType_NodeType (nodeType (d), ELEMENT_NODE))
  
  val ds = get_dataset d
  val-~Some_vt("foo") = strmap_get (ds, "xFoo")
  val-~Some_vt("bar") = strmap_get (ds, "xBar")
  val-~None_vt() = strmap_get (ds, "notPresent")
  val () = strmap_set (ds, "notPresent", "1")
  val-~Some_vt("1") = strmap_get (ds, "notPresent")
  val () = strmap_free ds
  val () = dom_free d  
  
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
