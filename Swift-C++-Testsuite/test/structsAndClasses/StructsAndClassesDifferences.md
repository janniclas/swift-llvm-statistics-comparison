# Structs and Classes Differences

## General Differences


## Programs with no equivalent C++ representation
* Property Wrapping with annotations doesn't exist in C++
* The way we can define properties of structs and classes is more expressive in Swift than in C++
* C++ doesn't have the lazy keyword
* Property observers don't exist in C++
* C++ constructors can't directly fail, they can either throw, or if we want to have the smiliar behavior to Swift init()? we can use a factory method and return a nullptr for the fail case. 