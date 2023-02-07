
# Swift-based and C++-based LLVM IR Microbenchmark
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](https://github.com/janniclas/swift-llvm-statistics-comparison/blob/main/Licence)

## Overview
This repository contains microbenchmarks written in Swift and C++. They are meant to be compiled to LLVM IR and provide a baseline for the comparison of C++-based LLVM IR and Swift-based LLVM IR.
This microbenchmark can be used to verify that static analysis tools that can analyze Swift or C++ also work with the other language.

## Currently Available Tests
[![SwiftTests](https://img.shields.io/badge/Swift_Test_Cases-204-orange?style=for-the-badge&logo=swift)](https://github.com/janniclas/swift-llvm-statistics-comparison/tree/main/Swift-C%2B%2B-Testsuite/test) [![CppTests](https://img.shields.io/badge/C++_Test_Cases-68-blue?style=for-the-badge&logo=c%2B%2B)](https://github.com/janniclas/swift-llvm-statistics-comparison/tree/main/Swift-C%2B%2B-Testsuite/test)

## Abstract
Since Swift’s introduction in 2014, it has become the default programming language for Apple’s rich ecosystem. However, despite its high adoption, there are only limited tools to help developers build secure applications. Developers came to expect and rely on such tools due to their high availability in other languages. Thus, their absence can lead to developers having low confidence in the correctness of their code and may result in insecure applications.
In this thesis, we explore the possibility of using existing static analysis tools for C++-based LLVM IR to analyze Swift-based LLVM IR. We first examine how Swift’s language features are represented in LLVM IR. Therefore, we create a set of microbenchmarks based on Swift’s language features and compare the corresponding LLVM IR with semantically equivalent C++ programs. Secondly, we run PhASAR on a selection of the microbenchmarks and check the analysis result’s correctness. Based on this exploratory research, we understand the applicability of existing static analysis tools to Swift and get an overview of how we possibly must adapt PhASAR’s analyses to handle Swift.


[![forthebadge](https://forthebadge.com/images/badges/made-with-swift.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/powered-by-coffee.svg)](https://forthebadge.com)

