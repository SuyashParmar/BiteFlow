#!/bin/bash
echo "Setting up BiteFlow..."

if ! command -v xcodegen &> /dev/null
then
    echo "xcodegen could not be found, installing..."
    brew install xcodegen
fi

echo "Generating Xcode project..."
xcodegen generate

echo "Setup complete! Open BiteFlow.xcodeproj to run the app."
