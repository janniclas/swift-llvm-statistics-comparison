SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

counterSwift=0
for FILE in $(find . -name '*.swift');
do let counterSwift=counterSwift+1
done
echo Number Swift Tests $counterSwift

counterCpp=0
for FILE in $(find . -name '*.cpp');
do let counterCpp=counterCpp+1
done
echo Number Swift Tests $counterCpp

echo Generating Readme
noSwiftCases=$counterSwift noCppCases=$counterCpp envsubst < scripts/README_TEMPLATE.md > README.md