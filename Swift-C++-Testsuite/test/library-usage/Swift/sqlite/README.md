# swiftServer

A description of this package.
swift build -Xswiftc -emit-ir | tee output.ll

docker run \
--mount type=bind,source="$(pwd)"/,target=/usr/src/example \
phasar -m /usr/src/example/output.ll \
--entry-points swiftServer_main \
-O /usr/src/example -D IDELinearConstantAnalysis