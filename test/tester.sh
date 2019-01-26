#!/bin/bash

TESTPID="/tmp/$name.pid"
rm -f $TESTPID
python3 -m http.server 8000 --bind 127.0.0.1 &
echo $! > $TESTPID
sleep 0.5

gpat=*
if [[ $# -eq 1 ]] ; then
    gpat=$1
fi

for src in ./$gpat.html; do
    name=$(basename $src .html)

    python3 -m unittest
    dst="$name.py"
    python3 -m unittest $dst
done

kill `cat $TESTPID`
