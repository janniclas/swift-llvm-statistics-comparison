# swift-llvm-statistics-comparison

This repository contains microbenchmarks written in Swift and C++, which are meant to be compiled to LLVM IR provide a baseline for the comparison of C++-based LLVM IR and Swift-based LLVM IR.
This repository is used as a part of my Master's Thesis, which I currently write with Fraunhofer IEM.

## Proposal Abstract
Since Swift’s introduction in 2014, it has replaced Objective-C as the default programming language for Apple’s rich ecosystem. However, despite its high adoption, there are only limited tools to help developers build secure applications. In this thesis, we explore the possibility of using existing static analysis tools for C++-based LLVM IR to analyze Swift-based LLVM IR. We first examine how Swift’s language features are represented in LLVM IR. Therefore, we create a set of microbenchmarks, each containing one of Swift’s language features, and first, compare the resulting LLVM IR with semantically equivalent C++ programs. Secondly, we run PhASAR on a selection of the microbenchmarks and investigate the analysis results. Based on this work, we understand the applicability of existing static analysis tools to Swift and an overview of how we possibly must adapt PhASAR’s analyses to handle Swift. 

