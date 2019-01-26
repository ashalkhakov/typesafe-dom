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

(*
http://domenlightenment.com/#11
TODO: 11, event handling! now this makes it all worth it! after this, integrate into my very own custom expression editor!
https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener

https://developer.mozilla.org/en-US/docs/Web/API/Event
*)
extern
fun
hello(): void = "mac#"
implement
hello() = let
  macdef assertelem (doc, id) = let
    val x = getElementById (,(doc), ,(id))
    val () = assert (~domnoderef_is_null (x))
    val () = assert (eq_NodeType_NodeType (nodeType (x), ELEMENT_NODE))
  in
    x
  end

  val doc = get_document ()
  prval () = window_document_nonnull ()

  (* click on the button -> be greeted *)  
  val btn = assertelem (doc, "btn")
  val alerter = eventlistener_fun (click, lam (e) => alert "hi")
  val () = addEventListener (ETelem | btn, click, alerter, event_options (true, false, false))
  val () = eventlistener_leak alerter
  val () = dom_free btn
  
  (* counter you can increase/decrease *)
  val ctr = ref 0 : ref int
  fun render (x: int): void = {
    val doc = get_document ()
    prval () = window_document_nonnull ()
    val ctr_text = assertelem (doc, "ctr-text")
    val () = set_textContent (ctr_text, toString(x))
    val () = dom_free ctr_text
    val () = put_document (doc)
  }
  
  val ctr_inc = assertelem (doc, "ctr-inc")
  val finc = eventlistener_obj (ctr, click,
    lam {d:addr} (c : ref int, e : !event(MouseEvent, d)): ref int =>
      let
        val () = ev_preventDefault e
        val cc = c
        val x = succ(ref_get_elt{int} cc)
        val () = ref_set_elt{int} (cc, x)
        val () = render (x)
      in
        cc
      end,
    lam (c) =>
      let var c = c in
        topize{ref int}(c)
      end)
  val () = addEventListener (ETelem | ctr_inc, click, finc, event_options (true, false, false))
  val () = eventlistener_leak finc
  val () = dom_free ctr_inc

  val ctr_dec = assertelem (doc, "ctr-dec")
  val fdec = eventlistener_obj (ctr, click,
    lam {d:addr} (c : ref int, e : !event(MouseEvent, d)): ref int =>
      let
        val () = ev_preventDefault e
        val cc = c
        val x = pred(ref_get_elt{int} cc)
        val () = ref_set_elt{int} (cc, x)
        val () = render (x)
      in
        cc
      end,
    lam (c) =>
      let var c = c in
        topize{ref int}(c)
      end)
  val () = addEventListener (ETelem | ctr_dec, click, fdec, event_options (true, false, false))
  val () = eventlistener_leak fdec
  val () = dom_free ctr_dec
  
  val () = render (ref_get_elt{int} ctr)
  
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
