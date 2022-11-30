#!/bin/bash
set -euxo pipefail
function runDockerStats {
    workingdirectory=${1%/*}
    fileName=${1##*/}
    docker run --mount "type=bind,source=${PWD}/$workingdirectory,target=/usr/data/" ghcr.io/secure-software-engineering/phasar:development -m "/usr/data/$fileName" -S --emit-statistics-as-json --project-id "$fileName-results" --out /usr/data || echo "$fileName failed to successfully analze."
}

function runDockerLinearConstantProp {
    workingdirectory=${1%/*}
    fileName=${1##*/}
    docker run --mount "type=bind,source=${PWD}/$workingdirectory,target=/usr/data/" ghcr.io/secure-software-engineering/phasar:development -m "/usr/data/$fileName" -D IDELinearConstantAnalysis --project-id "$fileName-linearConstantPropagation-results" --out /usr/data || echo "$fileName failed to successfully analze."
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

for FILE in $(find . -name '*.swift.noOpt.ll' -or -name '*.cpp.ll');
    do runDockerStats "$FILE";
done


# docker run \
# --mount type=bind,source="$(pwd)"/,target=/usr/src/example \
# phasar -m /usr/src/example/linearConstantPropagation/incrementFunctionNoTypes.swift.ll -O /usr/src/example/linearConstantPropagation -D IDELinearConstantAnalysis
 