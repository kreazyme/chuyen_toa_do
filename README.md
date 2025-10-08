# 📱 VN2000 to WGS84 Converter

A Flutter application for converting coordinates between VN-2000 (Vietnam's national coordinate system) and WGS84 (World Geodetic System 1984).

## ✨ Features

- **Coordinate Conversion**: Convert VN-2000 coordinates (Northing/Easting) to WGS84 (Latitude/Longitude)
- **Interactive Map**: View converted coordinates on an interactive map with markers
- **Multiple Zones**: Support for multiple Vietnamese provinces/zones:
  - TP HCM (Ho Chi Minh City)
  - HA NOI (Hanoi)
  - DA NANG (Da Nang)
  - CAN THO (Can Tho)
  - HAI PHONG (Hai Phong)
- **History**: Automatically saves conversion history for quick reference
- **Open in Maps**: Launch Google Maps or default map app with converted coordinates
- **Copy Coordinates**: Quick copy functionality for all coordinate values
- **Modern UI**: Clean, dark-themed interface with smooth navigation

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.9.0)
- Dart SDK
- iOS Simulator / Android Emulator / Physical Device

### Installation

1. Clone the repository:

```bash
git clone <your-repo-url>
cd chuyen_toa_do
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## 📱 Usage

1. **Convert Coordinates**:

   - Open the app
   - Enter Northing (Y) value
   - Enter Easting (X) value
   - Select the appropriate zone
   - Tap "Chuyển đổi" (Convert)

2. **View Results**:

   - See converted WGS84 coordinates
   - View location on interactive map
   - Copy individual coordinate values
   - Open location in external map app

3. **View History**:
   - Tap the history icon in the top-right corner
   - View all previous conversions
   - Tap any record to view details
   - Delete individual records or clear all history

## 🛠️ Technology Stack

- **Framework**: Flutter
- **Coordinate Conversion**: `dart_vn2000` package
- **Map Display**: `flutter_map` with OpenStreetMap tiles
- **URL Launcher**: `url_launcher` for external map integration
- **Storage**: `shared_preferences` for history persistence
- **UI**: Google Fonts for typography

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  dart_vn2000: ^1.0.3+2
  flutter_map: ^7.0.1
  latlong2: ^0.9.1
  url_launcher: ^6.3.0
  shared_preferences: ^2.3.3
  google_fonts: ^6.2.1
  intl: ^0.19.0
```

## 📂 Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   └── coordinate.dart               # Data models
├── services/
│   ├── coordinate_converter.dart     # Conversion logic
│   └── history_service.dart          # History management
└── screens/
    ├── conversion_screen.dart        # Main conversion UI
    ├── coordinate_detail_screen.dart # Detail view with map
    └── history_screen.dart           # History list view
```

## 🎯 Key Features Implementation

### Coordinate Conversion

Uses the `dart_vn2000` package with proper province configuration for accurate coordinate transformation.

### Map Integration

- OpenStreetMap tiles via `flutter_map`
- Custom markers for converted locations
- Interactive zoom and pan

### History Management

- Persistent storage using `shared_preferences`
- Automatic saving after each conversion
- Delete individual records or clear all
- Limit to 20 most recent conversions

## 🔮 Future Enhancements

- [ ] Reverse conversion (WGS84 → VN2000)
- [ ] GPS integration for current location
- [ ] Distance calculation to current position
- [ ] Batch coordinate conversion
- [ ] Export history to CSV
- [ ] Offline map support

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Acknowledgments

- Coordinate conversion based on [dart_vn2000](https://pub.dev/packages/dart_vn2000)
- JavaScript version by [@namlunkaka](https://github.com/namlunkaka/vn2000-converter)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
