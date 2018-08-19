
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
  val div = getElementById (doc, "d")
  val () = assert (~domnoderef_is_null (div))
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType div))
  val r = getBoundingClientRect (div)
  val () = assert (125.0 = r.height)
  val () = assert (125.0 = r.width)
  // because 25px border + 25px padding + 25 content + 25 padding + 25 border = 125  
  val () = assert (r.height = offsetHeight div)
  val () = assert (r.width = offsetWidth div)
  // because 25px border + 25px padding + 25 content + 25 padding + 25 border = 125  
  val () = assert (75.0 = clientHeight div)
  val () = assert (75.0 = clientWidth div)
  // logs '75 75' because 25px padding + 25 content + 25 padding = 75  
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
