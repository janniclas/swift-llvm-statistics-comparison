# swift-llvm-statistics-comparison

This repository contains microbenchmarks written in Swift and C++, which are meant to be compiled to LLVM IR provide a baseline for the comparison of C++-based LLVM IR and Swift-based LLVM IR.
This repository is used as a part of my Master's Thesis, which I currently write with Fraunhofer IEM.

## Proposal Abstract
Since Swift’s introduction in 2014, it has become the default programming language for Apple’s rich ecosystem. However, despite its high adoption, there are only limited tools to help developers build secure applications. Developers came to expect and rely on such tools due to their high availability in other languages. Thus, their absence can lead to developers having low confidence in the correctness of their code and possibly insecure applications. 
In this thesis, we explore the possibility of using existing static analysis tools for C++-based LLVM IR to analyze Swift-based LLVM IR. We first examine how Swift’s language features are represented in LLVM IR. Therefore, we create a set of microbenchmarks based on Swift’s language features and compare the corresponding LLVM IR with semantically equivalent C++ programs. Secondly, we run PhASAR on a selection of the microbenchmarks and check the analysis result’s correctness. Based on this exploratory research, we understand the applicability of existing static analysis tools to Swift and get an overview of how we possibly must adapt PhASAR’s analyses to handle Swift.

