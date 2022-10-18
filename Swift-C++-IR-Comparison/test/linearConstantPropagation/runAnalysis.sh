docker run \
--mount type=bind,source="$(pwd)"/,target=/usr/src/example \
phasar -m /usr/src/example/swift/incrementFunctionNoTypes.swift.ll \
-O /usr/src/example/swift -D IDELinearConstantAnalysis

docker run \
--mount type=bind,source="$(pwd)"/,target=/usr/src/example \
phasar -m /usr/src/example/c++/incrementFunction.ll \
-O /usr/src/example/c++ -D IDELinearConstantAnalysis

docker run \
--mount type=bind,source="$(pwd)"/,target=/usr/src/example \
phasar -m /usr/src/example/swift/incrementFunctionNoTypes.swift.disabledOptzns.ll \
-O /usr/src/example/swift -D IDELinearConstantAnalysis

docker run \
--mount type=bind,source="$(pwd)"/,target=/usr/src/example \
phasar -m /usr/src/example/output2.ll \
-O /usr/src/example -D IDELinearConstantAnalysis

docker run \
--mount type=bind,source="$(pwd)"/,target=/usr/src/example \
phasar -m /usr/src/example/output.ll \
--entry-points swiftServer_main \
-O /usr/src/example -D IDELinearConstantAnalysis


 # print statistics
# ./phasar-llvm -m /com.docker.devenvironments.code/addition.swift.unchecked.ll -S