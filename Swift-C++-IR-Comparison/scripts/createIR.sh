#!/bin/bash
set -euxo pipefail
function generate_IR {
    workingdirectory=${1%/*}
    if grep -qE '.swift$' <<< "$1"; then

        newSwiftIRNameDemangled="$1".noOptDemangled.ll
        newSwiftIRName="$1".noOpt.ll
        fileName=${newSwiftIRName##*/}

        swiftc -emit-ir -parse-as-library -Onone -Xfrontend -disable-llvm-optzns -Xfrontend -disable-swift-specific-llvm-optzns -module-name myModule "$1" | swift demangle > $newSwiftIRNameDemangled || echo "$fileName failed to compile"
        swiftc -emit-ir -parse-as-library -Onone -Xfrontend -disable-llvm-optzns -Xfrontend -disable-swift-specific-llvm-optzns -module-name myModule "$1" -o $newSwiftIRName || echo "$fileName failed to compile"
    fi

    if grep -qE '.cpp$' <<< "$1"; then

        fileName=${1##*/}
        # Somehow the default setting on the M1 MacBook is not to support usual C++ features
        # like a raw string so we had to add the -std=c++20 flag.
        clang++ -emit-llvm -S -fno-discard-value-names -std=c++20 -working-directory $workingdirectory $fileName -o $fileName.ll || echo "$fileName failed to compile"
        fileName=${fileName%.cpp}.cpp.ll
    fi
}
cd ..
for FILE in $(find test -name '*.swift' -or -name '*.cpp');
    do generate_IR $FILE;
done
