# SimpleLibraryTest

Create LLVM IR for the whole module by running the following command
`swiftc -emit-ir -Onone -parse-as-library -whole-module-optimization -module-name XXX ExternalFile.swift SimpleLibraryTest.swift > llvm.ll`

or more generally for many files

swiftc -emit-ir -whole-module-optimization -Onone -module-name XXX \
`find . -name "*.swift" -maxdepth X` \
> llvm.ll

And for files with dependencies

swiftc -emit-ir -whole-module-optimization -Onone -module-name XXX \
-L /path/to/dependencies \
-I /path/to/dependencies \
-lDependencyName1 -lDependencyName2 \
`find . -name "*.swift" -maxdepth X` \
> llvm.ll
