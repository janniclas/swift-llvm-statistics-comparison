#!/bin/bash
set -euxo pipefail
function runDockerStats {
    workingdirectory=${1%/*}
    fileName=${1##*/}
    docker run --mount "type=bind,source=${PWD}/$workingdirectory,target=/usr/data/" ghcr.io/secure-software-engineering/phasar:development -m "/usr/data/$fileName" -S -L --emit-statistics-as-json --project-id "$fileName-results" --out /usr/data || echo "$fileName failed to successfully analze."
}

function runDockerLinearConstantProp {
    workingdirectory=${1%/*}
    fileName=${1##*/}
    docker run --mount "type=bind,source=${PWD}/$workingdirectory,target=/usr/data/" ghcr.io/secure-software-engineering/phasar:development -m "/usr/data/$fileName" -D IDELinearConstantAnalysis --project-id "$fileName-results" --out /usr/data || echo "$fileName failed to successfully analze."
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

for FILE in $(find . -name '*.swift.noOpt.ll' -or -name '*.cpp.ll');
    #do runDockerStats "$FILE";
    do runDockerLinearConstantProp "$FILE";
done

 #clang++ -emit-llvm -S -fno-discard-value-names -std=c++20 -g SimpleAdd.cpp -o test.ll
# swiftc -emit-ir -parse-as-library -Onone -Xfrontend -disable-llvm-optzns -Xfrontend -disable-swift-specific-llvm-optzns -module-name myModule SimpleAdd.swift -o SimpleAdd.swift.noOpt.ll  && docker run --mount type=bind,source=/Users/struewer/git/swift-llvm-statistics-comparison/Swift-C++-Testsuite/test/arithmetic-operators/./Addition/Swift,target=/usr/data/ ghcr.io/secure-software-engineering/phasar:development -m /usr/data/SimpleAdd.swift.noOpt.ll -D IDELinearConstantAnalysis --project-id SimpleAdd.swift.noOpt.ll-results --out /usr/data