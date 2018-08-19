
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
  val div = getElementById (doc, "d")
  val () = assert (~domnoderef_is_null (div))
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType div))
  val divStyle = get_style div

  // set
  val () = setProperty (divStyle, "background-color", "red", "")
  val () = setProperty (divStyle, "border", "1px solid black", "")
  val () = setProperty (divStyle, "width","100px", "")
  val () = setProperty (divStyle, "height", "100px", "")
  // get
  val () = assert ("red" = getPropertyValue (divStyle, "background-color"))
  val () = assert ("1px solid black" = getPropertyValue (divStyle, "border"))
  val () = assert ("100px" = getPropertyValue (divStyle, "width"))
  val () = assert ("100px" = getPropertyValue (divStyle, "height"))
  // remove
  val () = removeProperty (divStyle, "background-color")
  val () = removeProperty (divStyle, "border")
  val () = removeProperty (divStyle, "width")
  val () = removeProperty (divStyle, "height")

  val () = style_free divStyle
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
