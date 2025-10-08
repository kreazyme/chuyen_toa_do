import 'package:dart_vn2000/dart_vn2000.dart';
import 'package:dart_vn2000/src/configs.dart';

void main() {
  // Test conversion
  final result = DartVN2000Converter.vn2000ToWGS84(
    dx: 600997,
    dy: 1189964,
    province: VN2000Province.VN2000_TP_HCM(),
  );
  print('Result type: ${result.runtimeType}');
  print('Result: $result');
  print('Latitude: ${result.latitude}');
  print('Longitude: ${result.longitude}');

  // Test reverse
  final reverse = DartVN2000Converter.wgs84ToVN2000(
    longitude: 106.67523783,
    latitude: 10.75909134,
    province: VN2000Province.VN2000_TP_HCM(),
  );
  print('Reverse: $reverse');
  print('X: ${reverse.x}, Y: ${reverse.y}');
}
