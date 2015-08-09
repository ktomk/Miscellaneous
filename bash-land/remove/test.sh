#!/usr/bin/env bash

echo "remove test"

./remove.test.sh > remove.test.actual

diff -q remove.test.expect remove.test.actual

if [ $? -ne 0 ]; then
    diff -y remove.test.expect remove.test.actual
fi

echo "done."
