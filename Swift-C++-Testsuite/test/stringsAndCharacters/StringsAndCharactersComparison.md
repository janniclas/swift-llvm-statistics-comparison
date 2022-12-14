## General Differences


## Character Array
* C++ generates one array with all characters in them 
  * @__const.main.myword = private unnamed_addr constant [6 x i8] c"Hello\00", align 1
* Swift generates each character seperatly and reuses the duplicate l character 
  * @.str = private unnamed_addr constant [2 x i8] c"H\00" @.str.1 = private unnamed_addr constant [2 x i8] c"e\00" @.str.2 = private unnamed_addr constant [2 x i8] c"l\00" @.str.3 = private unnamed_addr constant [2 x i8] c"o\00"

## String from Character Array
* Both use a function to initialize a String from a Character Array
* Swift uses the same pattern as observed previously (arithmetic operations), by just calling a declared method

## Strings
* Are declared identical

## Compound Concatination
* Swift handles this identically to the solution for compound arithmetic opertaors
* C++ 


## String Interpolation
* Swift uses functions from the DefaultStringInterpolation namespace
  * Basically they define the string to be modified and the number of interpolations. Those are then filled by calling appendInterpolation.
* C++ uses a basic_ostream and pushes the base string as well as the calculation results in this stream

## Multiline Strings
* Are handled indentically

## Single Characters
* C++ stores the related number, while Swift creates a string with a c"" prefix