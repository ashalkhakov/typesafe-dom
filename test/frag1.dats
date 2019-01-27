
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
  val docFrag = createDocumentFragment (doc)

  macdef myop (e) = {
    val li = createElement (doc, "li")
    val () = set_textContent (li, ,(e))
    val x = appendChild (PC_DFElement () | docFrag, li)    
    val () = dom_free (x)
  }
  val () = myop "blue"
  val () = myop "green"
  val () = myop "red"
  val () = myop "blue"
  val () = myop "pink"
  val () = assert ("bluegreenredbluepink" = get_textContent docFrag)

  val ulElm = querySelector (doc, "ul")
  val () = assert (~domnoderef_is_null (ulElm))
  val () = assert (eq_NodeType_NodeType (ELEMENT_NODE, nodeType ulElm))
  val () = fragment_appendChild (ulElm, docFrag)
  val () = assert ("<li>blue</li><li>green</li><li>red</li><li>blue</li><li>pink</li>" = get_innerHTML ulElm) 
  val () = dom_free (ulElm)

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

