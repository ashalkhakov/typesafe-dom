/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2018-8-18: 22h:22m
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
  var tmp9
  var tmp10
  var tmp12
  var tmp13
  var tmp14
  var tmp16
  var tmplab, tmplab_js
//
  // __patsflab_hello
  tmp1 = get_document();
  tmp2 = elementFromPoint(tmp1, 50.0, 50.0);
  tmp5 = domnoderef_is_null(tmp2);
  tmp4 = ats2jspre_neg_bool1(tmp5);
  atspre_assert_bool1(tmp4);
  tmp8 = nodeType(tmp2);
  tmp7 = ats2jspre_eq_int1_int1(1, tmp8);
  atspre_assert_bool1(tmp7);
  tmp9 = attributes(tmp2);
  tmp10 = domnamednodemap_getNamedItem(tmp9, "id");
  tmp13 = domnoderef_is_null(tmp10);
  tmp12 = ats2jspre_neg_bool1(tmp13);
  atspre_assert_bool1(tmp12);
  tmp14 = attr_getValue(tmp10);
  tmp16 = ats2jspre_eq_string_string("top", tmp14);
  atspre_assert_bool0(tmp16);
  tmp1;
  return/*_void*/;
} // end-of-function

// dynloadflag_minit
var _057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_efp_056_dats__dynloadflag = 0;

function
_057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_efp_056_dats__dynload()
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // ATSdynload()
  // ATSdynloadflag_sta(_057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_efp_056_dats__dynloadflag(49))
  if(ATSCKiseqz(_057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_efp_056_dats__dynloadflag)) {
    _057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_efp_056_dats__dynloadflag = 1 ; // flag is set
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
  _057_home_057_artyom_057_projects_057_typesafe_055_dom_057_test_057_efp_056_dats__dynload();
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
