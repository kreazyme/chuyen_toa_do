import 'package:dart_vn2000/dart_vn2000.dart';
import 'package:dart_vn2000/src/configs.dart';
import '../models/coordinate.dart';

class CoordinateConverter {
  /// Convert VN2000 to WGS84
  static WGS84Coordinate vn2000ToWgs84({
    required double northing,
    required double easting,
    required String province,
  }) {
    final provinceConfig = _getProvinceConfig(province);
    final result = DartVN2000Converter.vn2000ToWGS84(
      dx: easting,
      dy: northing,
      province: provinceConfig,
    );

    return WGS84Coordinate(
      latitude: result.latitude,
      longitude: result.longitude,
    );
  }

  /// Convert WGS84 to VN2000
  static VN2000Coordinate wgs84ToVn2000({
    required double latitude,
    required double longitude,
    required String province,
  }) {
    final provinceConfig = _getProvinceConfig(province);
    final result = DartVN2000Converter.wgs84ToVN2000(
      longitude: longitude,
      latitude: latitude,
      province: provinceConfig,
    );

    return VN2000Coordinate(
      northing: result.y,
      easting: result.x,
      zone: province,
    );
  }

  /// Get VN2000Province configuration from zone string
  static VN2000Province _getProvinceConfig(String zone) {
    switch (zone) {
      case 'VN2000_TP_HCM':
        return VN2000Province.VN2000_TP_HCM();
      case 'VN2000_HA_NOI':
        return VN2000Province.VN2000_HA_NOI();
      case 'VN2000_DA_NANG':
        return VN2000Province.VN2000_DA_NANG();
      case 'VN2000_CAN_THO':
        return VN2000Province.VN2000_CAN_THO();
      case 'VN2000_HAI_PHONG':
        return VN2000Province.VN2000_HAI_PHONG();
      default:
        return VN2000Province.VN2000_TP_HCM(); // Default to Ho Chi Minh
    }
  }

  /// Get list of available zones
  static List<String> getAvailableZones() {
    return [
      'VN2000_TP_HCM',
      'VN2000_HA_NOI',
      'VN2000_DA_NANG',
      'VN2000_CAN_THO',
      'VN2000_HAI_PHONG',
    ];
  }

  /// Get friendly display name for province
  static String getProvinceName(String province) {
    final name = province.replaceAll('VN2000_', '').replaceAll('_', ' ');
    return name;
  }
}
