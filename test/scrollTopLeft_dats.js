/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2019-1-27: 19h: 2m
**
*/

function
hello()
{
//
// knd = 0
  var tmp1
  var tmp2
  var tmp4
  var tmp5
  var tmp7
  var tmp8
  var tmp10
  var tmp11
  var tmp13
  var tmp14
  var tmp18
  var tmp19
  var tmp21
  var tmp22
  var tmplab, tmplab_js
//
  // __patsflab_hello
  tmp1 = get_document();
  tmp2 = getElementById(tmp1, "d");
  tmp5 = domnoderef_is_null(tmp2);
  tmp4 = ats2jspre_neg_bool1(tmp5);
  atspre_assert_bool1(tmp4);
  tmp8 = nodeType(tmp2);
  tmp7 = ats2jspre_eq_int1_int1(1, tmp8);
  atspre_assert_bool1(tmp7);
  tmp11 = get_scrollHeight(tmp2);
  tmp10 = ats2jspre_eq_double_double(1000.0, tmp11);
  atspre_assert_bool0(tmp10);
  tmp14 = get_scrollWidth(tmp2);
  tmp13 = ats2jspre_eq_double_double(1000.0, tmp14);
  atspre_assert_bool0(tmp13);
  set_scrollTop(tmp2, 750.0);
  set_scrollLeft(tmp2, 750.0);
  tmp19 = get_scrollTop(tmp2);
  tmp18 = ats2jspre_eq_double_double(750.0, tmp19);
  atspre_assert_bool0(tmp18);
  tmp22 = get_scrollLeft(tmp2);
  tmp21 = ats2jspre_eq_double_double(750.0, tmp22);
  atspre_assert_bool0(tmp21);
  tmp1;
  return/*_void*/;
} // end-of-function

// dynloadflag_minit
var _057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_scrollTopLeft_056_dats__dynloadflag = 0;

function
_057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_scrollTopLeft_056_dats__dynload()
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // ATSdynload()
  // ATSdynloadflag_sta(_057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_scrollTopLeft_056_dats__dynloadflag(59))
  if(ATSCKiseqz(_057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_scrollTopLeft_056_dats__dynloadflag)) {
    _057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_scrollTopLeft_056_dats__dynloadflag = 1 ; // flag is set
    hello();
  } // end-of-if
  return/*_void*/;
} // end-of-function


function
my_dynload()
{
//
// knd = 0
  var tmplab, tmplab_js
//
  _057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_scrollTopLeft_056_dats__dynload();
  return/*_void*/;
} // end-of-function


/* ATSextcode_beg() */

function domnodelist_length(dl) { return dl.length; }
function domnodelist_item(d,i) { return d[i]; }
function domnamednodemap_length(dm) { return dm.length; }
function domnamednodemap_getNamedItem (dm, s) { return dm.getNamedItem(s); }
function domnamednodemap_setNamedItem (dm, a) { return dm.setNamedItem(a); }
function domnamednodemap_removeNamedItem (dm, s) { return dm.removeNamedItem(s); }
function domnamednodemap_item (dm, i) { return dm[i]; }
function getElementById(d,id) { return d.getElementById(id); }
function getElementsByTagName(d,t) { return d.getElementsByTagName(t); }
function getElementsByClassName(d,c) { return d.getElementsByClassName(c); }
function querySelectorAll(d,s) { return d.querySelectorAll(s); }
function querySelector(d, s) { return d.querySelector(s); }
function domnoderef_is_null (d) { return d === null; }
function get_document () { return window.document; }
function createAttribute(doc, name) { return doc.createAttribute(name); }
function nodeType(d) { return d.nodeType; }
function nodeValue(d) { return d.nodeValue; }
function attributes (d) { return d.attributes; }
function children(d) { return d.children; }
function firstChild(d) { return d.firstChild; }
function lastChild(d) { return d.lastChild; }
function nextSibling(d) { return d.nextSibling; }
function previousSibling(d) { return d.previousSibling; }
function nodeName(d) { return d.nodeName; }
function parentNode(d) { return d.parentNode; }
function set_innerHTML (d, s) { return d.innerHTML = s; }
function get_innerHTML (d) { return d.innerHTML; }
function set_textContent (d, s) { return d.textContent = s; }
function get_textContent (d) { return d.textContent; }
function attr_setValue(a,v) { a.value = v; }
function attr_getValue(a) { return a.value; }
function setAttributeNode (elt, a) { return elt.setAttributeNode(a); }
function appendChild (node, s) { return node.appendChild(s); }
function insertBefore (node, s, b) { return node.insertBefore(s, b); }
function removeChild (node, s) { return node.removeChild(s); }
function replaceChild (node, n, c) { return node.replaceChild(n, c); }
function cloneNode(node, d) { return node.cloneNode(d); }
function createTextNode (doc, text) { return doc.createTextNode(text); }
function createElement (doc, name) { return doc.createElement(name); }
function createDocument (a, b, d) { return createDocument(a, b, d); }

function offsetLeft (e) { return e.offsetLeft; }
function offsetTop (e) { return e.offsetTop; }
function offsetParent (e) { return e.offsetParent; }
function offsetWidth (e) { return e.offsetWidth; }
function offsetHeight (e) { return e.offsetHeight; }
function clientWidth (e) { return e.clientWidth; }
function clientHeight (e) { return e.clientHeight; }
function getBoundingClientRect(d) { return d.getBoundingClientRect(); }
function elementFromPoint (d, x, y) { return d.elementFromPoint(x, y); }
function get_scrollWidth(e) { return e.scrollWidth; }
function get_scrollHeight(e) { return e.scrollHeight; }
function get_scrollTop(e) { return e.scrollTop; }
function set_scrollTop(e, v) { return e.scrollTop = v; }
function get_scrollLeft(e) { return e.scrollLeft; }
function set_scrollLeft(e, v) { return e.scrollLeft = v; }
function scrollIntoView(e, v) { return e.scrollIntoView(v); }

function get_style (d) { return d.style; }
function getPropertyValue (s, p) { return s.getPropertyValue(p); }
function removeProperty (s, p) { return s.removeProperty(p); }
function setProperty (s, p, v, r) { return s.setProperty(p, v, r); }
function window_getComputedStyle(e) { return window.getComputedStyle(e); }

function get_dataset(e) { return e.dataset; }
function strmap_get(e, k) { var tmp = e[k]; return tmp ? [tmp] : null; }
function strmap_delete(s, k) { delete s[k]; }
function strmap_set(e, k, v) { return e[k] = v; }

function cdata_length(e) { return e.length; }
function cdata_data(e) { return e.data; }
function cdata_appendData(d, t) { return d.appendData(t); }
function cdata_insertData(cd, o, d) { return cd.insertData(o, d); }
function cdata_deleteData(cd, o, c) { return cd.deleteData(o, c); }
function cdata_replaceData(cd, o, c, d) { return cd.replaceData(o, c, d); }

function createDocumentFragment(d) { return d.createDocumentFragment(); }
function fragment_appendChild (n, s) { return n.appendChild(s); }
function fragment_insertBefore (n, s, b) { return n.insertBefore(s, b); }

function ev_bubbles(ev) { return ev.bubbles; }
function ev_cancelable(ev) { return ev.cancelable; }
function ev_currentTarget(ev) { return ev.currentTarget; }
function ev_target(ev) { return ev.target; }
function ev_defaultPrevented(ev) { return ev.defaultPrevented; }
function ev_eventPhase(ev) { return ev.eventPhase; }
function ev_type(ev) { return ev.type; }
function ev_timeStamp(ev) { return ev.timeStamp; }
function ev_preventDefault(ev) { return ev.preventDefault(); }
function ev_stopPropagation(ev) { return ev.stopPropagation(); }

function eventlistener_obj(s,et,h,f) {
  var obj = {
    state: s,
    free: function() {
      if (!obj.freed) {
        f(obj.state);
        obj.freed = true;
      }
    },
    freed: false,
    handleEvent: function(e) {
      if (obj.freed) return;
      obj.state = h(obj.state, e);
    }
  };
  return obj;
}
function eventlistener_fun(et,h) {
  return eventlistener_obj(null, et,
    function(s, e) {
      h(e);
      return s;
    },
    function() {
    });
}
function eventlistener_free(et) {
  et.free();
}

function event_options (c, o, p) { return {capture: c, once: o, passive: p}; }

function addEventListener(d, t, l, o) { return d.addEventListener(t, l, o); }
function removeEventListener(d, t, l, o) { return d.removeEventlistener(t, l, o); }

function mouse_altKey(e) { return e.altKey; }
function mouse_button(e) { return e.button; }
function mouse_buttons(e) { return e.buttons; }
function mouse_clientX(e) { return e.clientX; }
function mouse_clientY(e) { return e.clientY; }
function mouse_ctrlKey(e) { return e.ctrlKey; }
function mouse_metaKey(e) { return e.metaKey; }
function mouse_movementX(e) { return e.movementX; }
function mouse_movementY(e) { return e.movementY; }
function mouse_screenX(e) { return e.screenX; }
function mouse_screenY(e) { return e.screenY; }
function mouse_shiftKey(e) { return e.shiftKey; }
function mouse_getModifierState(e, k) { return e.getModifierState(k); }

function focus_relatedTarget(e) { return e.relatedTarget; }

function keyboard_getModifierState(e, k) { return e.getModifierState(k); }
function keyboard_altKey(e) { return e.altKey; }
function keyboard_code(e) { return e.code; }
function keyboard_ctrlKey(e) { return e.ctrlKey; }
function keyboard_key(e) { return e.key; }
function keyboard_metaKey(e) { return e.metaKey; }
function keyboard_repeat(e) { return e.repeat; }
function keyboard_shiftKey(e) { return e.shiftKey; }

function wheel_deltaX(ev) { return ev.deltaX; }
function wheel_deltaY(ev) { return ev.deltaY; }
function wheel_deltaZ(ev) { return ev.deltaZ; }
function wheel_deltaMode(ev) { return ev.deltaMode; }

/* ATSextcode_end() */

/* ATSextcode_beg() */
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
/* ATSextcode_end() */

/* ****** ****** */

/* end-of-compilation-unit */
