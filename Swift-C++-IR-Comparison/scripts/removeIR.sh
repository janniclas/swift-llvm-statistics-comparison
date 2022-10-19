#!/bin/bash

for FILE in $(find src -name '*.silgen' -or -name '*.sil' -or -name '*.silgenopt' -or -name '*.sildebug' -or -name '*.llgen' -or -name '*.ll' -or -name '*.final');
do rm $FILE;
done
