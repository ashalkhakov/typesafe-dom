
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME
"my_dynload"

(* ****** ****** *)

#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"

#include
"{$LIBATSCC2JS}/mylibies.hats"


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

  val div = querySelector (doc, "div")
  val () = assert (~domnoderef_is_null (div))
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType div))

  val cs = getComputedStyle div
  // logs rgb(0, 128, 0) or green, this is an inline element style
  val () = assert ("rgb(0, 128, 0)" = getPropertyValue (cs, "background-color"))

  // logs 1px solid rgb(128, 0, 128) or 1px solid purple, this is an inline element style
  // NOTE: firefox does not resolve shortcut property names! chrome does.
  val () = assert ("1px" = getPropertyValue (cs, "border-left-width"))
  val () = assert ("solid" = getPropertyValue (cs, "border-left-style"))
  val () = assert ("rgb(128, 0, 128)" = getPropertyValue (cs, "border-left-color"))

  // logs 100px, note this is not an inline element style
  val () = assert ("100px" = getPropertyValue (cs, "height"))

  // logs 100px, note this is not an inline element style
  val () = assert ("100px" = getPropertyValue (cs, "width"))

(*
  // type error!
  val () = setProperty (cs, "background-color", "red", "")
*)

  val () = style_free cs
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
