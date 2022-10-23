if which swift-format >/dev/null; then
    swift format -i -r Sources --configuration swiftStyle.json
    swift format -i -r Swift-C++-IR-Comparison --configuration swiftStyle.json
else
    echo "warning: swift-format not installed"
fi
