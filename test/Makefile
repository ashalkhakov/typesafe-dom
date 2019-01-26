######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
MYATSCC=$(PATSHOME)/bin/myatscc
ATSCC2JS=$(PATSHOME)/bin/atscc2js

######

all::

######

all:: \
tests_dats.js \
offset_dats.js \
bcr_dats.js \
efp_dats.js \
scrollTopLeft_dats.js \
scrollIntoView_dats.js \
style_dats.js \
computedStyle_dats.js \
frag1_dats.js \
text_dats.js \
events_dats.js \
dataset_dats.js

######

%_dats.c: %.dats; $(PATSOPT) -o $@ -d $<
%_dats.js: %_dats.c; $(ATSCC2JS) -o $@ -i $<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.c

######

cleanall:: clean
cleanall:: ; rm -f *_dats.js

######

testall:: all
testall:: cleanall

###### end of [Makefile] ######
