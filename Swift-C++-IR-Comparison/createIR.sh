#!/bin/bash

function generate_IR {
    workingdirectory=${1%/*}
    if grep -qE '.swift$' <<< "$1"; then

        newSwiftIRNameDemangled="$1".noOptDemangled.ll
        newSwiftIRName="$1".noOpt.ll
        fileName=${newSwiftIRName##*/}

        swiftc -emit-ir -parse-as-library -Onone -Xfrontend -disable-llvm-optzns -Xfrontend -disable-swift-specific-llvm-optzns -module-name myModule "$1" | swift demangle > $newSwiftIRNameDemangled
        swiftc -emit-ir -parse-as-library -Onone -Xfrontend -disable-llvm-optzns -Xfrontend -disable-swift-specific-llvm-optzns -module-name myModule "$1" -o $newSwiftIRName
    fi

    if grep -qE '.cpp$' <<< "$1"; then

        fileName=${1##*/}
        # Somehow the default setting on the M1 MacBook is not to support usual C++ features
        # like a raw string so we had to add the -std=c++20 flag.
        clang++ -emit-llvm -S -fno-discard-value-names -std=c++20 -working-directory $workingdirectory $fileName -o $fileName.ll
        fileName=${fileName%.cpp}.cpp.ll
    fi
    echo $fileName
#        docker run --mount type=bind,source=$(PWD)/$workingdirectory,target=/usr/data/ phasar -m /usr/data/$fileName -S -L --emit-statistic-as-json --project-id $fileName-results --out /usr/data
}

for FILE in $(find test -name '*.swift' -or -name '*.cpp');
    do generate_IR $FILE;
done
