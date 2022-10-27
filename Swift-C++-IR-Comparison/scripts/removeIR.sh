#!/bin/bash
cd ..
for FILE in $(find . -name '*.silgen' -or -name '*.sil' -or -name '*.silgenopt' -or -name '*.sildebug' -or -name '*.llgen' -or -name '*.ll' -or -name '*.final');
do rm $FILE;
done
