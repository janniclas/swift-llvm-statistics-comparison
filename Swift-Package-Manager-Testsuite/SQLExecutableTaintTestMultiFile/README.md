# SQLExecutableTaintTest

swiftc -emit-ir -whole-module-optimization -Onone -module-name XXX \
-L /Users/struewer/git/swift-llvm-statistics-comparison/Swift-Package-Manager-Testsuite/SQLExecutableTaintTest/.build/debug \
-I /Users/struewer/git/swift-llvm-statistics-comparison/Swift-Package-Manager-Testsuite/SQLExecutableTaintTest/.build/debug \
-lSQLite \
`find . -name "*.swift" -maxdepth 2` \
> llvm.ll

This test is currently not working in PhASAR. It seems like the taint is lost during the function call?
