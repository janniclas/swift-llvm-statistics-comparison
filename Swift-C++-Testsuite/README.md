
1. Install PhASAR docker image.
2. Run `createIR.sh` to compile all C++ and Swift programs to LLVM IR.
3. Execute the statistical analysis on the generated IR by running `phasar-image -m /com.docker.devenvironments.code/array.swift.unchecked.ll -S -L --emit-statistics-as-json --out /com.docker.devenvironments.code/build/out` on each file. 

./phasar-llvm -m /com.docker.devenvironments.code/addition.swift.unchecked.ll -S

./tools/phasar-llvm/phasar-llvm -m /com.docker.devenvironments.code/array.swift.unchecked.ll -S -L --emit-statistics-as-json --out /com.docker.devenvironments.code/build/out