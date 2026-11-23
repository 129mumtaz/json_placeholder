#!/bin/bash
set -e

# If build/web/index.html already exists, use existing build
if [ -f "build/web/index.html" ]; then
  echo "Found pre-built web assets in build/web, deploying..."
  exit 0
fi

echo "Installing Flutter SDK on Vercel..."
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter
fi

export PATH="$PATH:`pwd`/flutter/bin"

echo "Flutter version:"
flutter --version

echo "Building Flutter Web..."
flutter config --enable-web
flutter pub get
flutter build web --release

echo "Build complete! Output in build/web"
