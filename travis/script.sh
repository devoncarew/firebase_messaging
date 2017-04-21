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

echo "Installing google-java-format..."
wget -O $HOME/google-java-format.jar https://github.com/google/google-java-format/releases/download/google-java-format-1.3/google-java-format-1.3-all-deps.jar

echo "Checking dartfmt..."
dartfmt -w . > /dev/null 2>&1
if [[ $(git ls-files --modified) ]]; then
    git diff
    echo
    echo "The following files do not adhere to the dartfmt style (see diff above):"
    git ls-files --modified | sed 's/^/  /'
    echo "To fix run: 'dartfmt -w .'"
    exit 1
else
    echo "dartfmt OK"
fi

echo "Checking clang-format..."
find . -iname *.h -o -iname *.m -print0 | xargs -0 clang-format-5.0 -i --style=Google
if [[ $(git ls-files --modified) ]]; then
    git diff
    echo
    echo "The following files do not adhere to the clang-format syle (see diff above):"
    git ls-files --modified | sed 's/^/  /'
    echo "To fix run: 'find . -iname *.h -o -iname *.m -print0 | xargs -0 clang-format -i --style=Google'"
    exit 1
else
    echo "clang-format OK"
fi

echo "Checking google-java-format..."
find . -iname *.java -print0 | xargs -0 java -jar $HOME/google-java-format.jar --replace
if [[ $(git ls-files --modified) ]]; then
    git diff
    echo
    echo "The following files do not adhere to the google-java-format syle (see diff above):"
    git ls-files --modified | sed 's/^/  /'
    echo "To fix run: 'find . -iname *.java -print0 | xargs -0 java -jar /path/to/google-java-format-1.3-all-deps.jar --replace'"
    exit 1
else
    echo "google-java-format OK"
fi
