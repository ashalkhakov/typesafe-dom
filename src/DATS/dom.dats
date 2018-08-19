%{$

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

%}
