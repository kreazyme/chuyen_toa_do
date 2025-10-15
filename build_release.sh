#!/bin/bash

# Build script for VN2000 Coordinate Converter App
# Make sure you have the key.properties file configured

echo "🚀 Building VN2000 Coordinate Converter App for Release..."
echo ""

# Check if key.properties exists
if [ ! -f "android/key.properties" ]; then
    echo "❌ Error: key.properties file not found in android/ directory"
    echo "Please make sure your key.properties file is properly configured"
    exit 1
fi

echo "✅ Key properties file found"
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
flutter pub get
echo ""

# Build APK
echo "📦 Building release APK..."
flutter build apk --release

# Check if build was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Build completed successfully!"
    echo ""
    echo "📱 APK location:"
    echo "build/app/outputs/flutter-apk/app-release.apk"
    echo ""
    echo "📊 APK size:"
    ls -lh build/app/outputs/flutter-apk/app-release.apk | awk '{print $5}'
    echo ""
    echo "✨ You can now install this APK on Android devices!"
else
    echo ""
    echo "❌ Build failed. Please check the error messages above."
    exit 1
fi