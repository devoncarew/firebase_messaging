#!/bin/bash
set -e

echo "Installing Dart SDK..."
curl https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip > $HOME/dartsdk.zip
unzip $HOME/dartsdk.zip -d $HOME > /dev/null
rm $HOME/dartsdk.zip
export DART_SDK="$HOME/dart-sdk"
export PATH="$DART_SDK/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
dart --version

echo "Checking dartfmt..."
dartfmt -w . > /dev/null 2>&1
if [[ $(git ls-files --modified) ]]; then
    git diff
    echo
    echo "The following files do not adhere to the dartfmt style:"
    git ls-files --modified | sed 's/^/  /'
    echo "To fix run: 'dartfmt -w .'"
    exit 1
else
    echo "dartftm OK"
fi

echo "Checking clang-format..."
find . -iname *.h -o -iname *.m -print0 | xargs -0 clang-format-5.0 -i --style=Google
if [[ $(git ls-files --modified) ]]; then
    git diff
    echo
    echo "The following files do not adhere to the clang-format syle:"
    git ls-files --modified | sed 's/^/  /'
    echo "To fix run: 'find . -iname *.h -o -iname *.m -print0 | xargs -0 clang-format -i --style=Google'"
    exit 1
else
    echo "clang-format OK"
fi
