docker run \
--mount type=bind,source="$(pwd)"/,target=/usr/src/example \
phasar -m /usr/src/example/linearConstantPropagation/incrementFunctionNoTypes.swift.ll -O /usr/src/example/linearConstantPropagation -D IDELinearConstantAnalysis
 
 # print statistics
# ./phasar-llvm -m /com.docker.devenvironments.code/addition.swift.unchecked.ll -S