#!/bin/bash
set -euxo pipefail
function runDocker {
    workingdirectory=${1%/*}
    fileName=${1##*/}
    docker run --mount "type=bind,source=${PWD}/$workingdirectory,target=/usr/data/" ghcr.io/secure-software-engineering/phasar:pr-524 -m "/usr/data/$fileName" -S -L --emit-statistic-as-json --project-id "$fileName-results" --out /usr/data
}
cd ..
echo ${PWD}
for FILE in $(find test -name '*.swift.noOpt.ll' -or -name '*.cpp.ll');
    do runDocker "$FILE";
done

