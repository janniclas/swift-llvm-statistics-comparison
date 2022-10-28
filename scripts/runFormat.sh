
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

if which swift-format >/dev/null; then
    swift format -i -r ComparisonTool/Sources --configuration scripts/swiftStyle.json
    swift format -i -r Swift-C++-Testsuite --configuration scripts/swiftStyle.json
else
    echo "warning: swift-format not installed"
fi
