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
      case 'VN2000_LAI_CHAU':
        return VN2000Province.VN2000_LAI_CHAU();
      case 'VN2000_DIEN_BIEN':
        return VN2000Province.VN2000_DIEN_BIEN();
      case 'VN2000_SON_LA':
        return VN2000Province.VN2000_SON_LA();
      case 'VN2000_LAO_CAI':
        return VN2000Province.VN2000_LAO_CAI();
      case 'VN2000_YEN_BAI':
        return VN2000Province.VN2000_YEN_BAI();
      case 'VN2000_HA_GIANG':
        return VN2000Province.VN2000_HA_GIANG();
      case 'VN2000_TUYEN_QUANG':
        return VN2000Province.VN2000_TUYEN_QUANG();
      case 'VN2000_PHU_THO':
        return VN2000Province.VN2000_PHU_THO();
      case 'VN2000_VINH_PHUC':
        return VN2000Province.VN2000_VINH_PHUC();
      case 'VN2000_CAO_BANG':
        return VN2000Province.VN2000_CAO_BANG();
      case 'VN2000_LANG_SON':
        return VN2000Province.VN2000_LANG_SON();
      case 'VN2000_BAC_CAN':
        return VN2000Province.VN2000_BAC_CAN();
      case 'VN2000_THAI_NGUYEN':
        return VN2000Province.VN2000_THAI_NGUYEN();
      case 'VN2000_BAC_GIANG':
        return VN2000Province.VN2000_BAC_GIANG();
      case 'VN2000_BAC_NINH':
        return VN2000Province.VN2000_BAC_NINH();
      case 'VN2000_QUANG_NINH':
        return VN2000Province.VN2000_QUANG_NINH();
      case 'VN2000_HAI_PHONG':
        return VN2000Province.VN2000_HAI_PHONG();
      case 'VN2000_HAI_DUONG':
        return VN2000Province.VN2000_HAI_DUONG();
      case 'VN2000_HUNG_YEN':
        return VN2000Province.VN2000_HUNG_YEN();
      case 'VN2000_HA_NOI':
        return VN2000Province.VN2000_HA_NOI();
      case 'VN2000_HOA_BINH':
        return VN2000Province.VN2000_HOA_BINH();
      case 'VN2000_HA_NAM':
        return VN2000Province.VN2000_HA_NAM();
      case 'VN2000_NAM_DINH':
        return VN2000Province.VN2000_NAM_DINH();
      case 'VN2000_THAI_BINH':
        return VN2000Province.VN2000_THAI_BINH();
      case 'VN2000_NINH_BINH':
        return VN2000Province.VN2000_NINH_BINH();
      case 'VN2000_THANH_HOA':
        return VN2000Province.VN2000_THANH_HOA();
      case 'VN2000_NGHE_AN':
        return VN2000Province.VN2000_NGHE_AN();
      case 'VN2000_HA_TINH':
        return VN2000Province.VN2000_HA_TINH();
      case 'VN2000_QUANG_BINH':
        return VN2000Province.VN2000_QUANG_BINH();
      case 'VN2000_QUANG_TRI':
        return VN2000Province.VN2000_QUANG_TRI();
      case 'VN2000_THUA_THIEN_HUE':
        return VN2000Province.VN2000_THUA_THIEN_HUE();
      case 'VN2000_DA_NANG':
        return VN2000Province.VN2000_DA_NANG();
      case 'VN2000_QUANG_NAM':
        return VN2000Province.VN2000_QUANG_NAM();
      case 'VN2000_QUANG_NGAI':
        return VN2000Province.VN2000_QUANG_NGAI();
      case 'VN2000_BINH_DINH':
        return VN2000Province.VN2000_BINH_DINH();
      case 'VN2000_KON_TUM':
        return VN2000Province.VN2000_KON_TUM();
      case 'VN2000_GIA_LAI':
        return VN2000Province.VN2000_GIA_LAI();
      case 'VN2000_DAK_LAK':
        return VN2000Province.VN2000_DAK_LAK();
      case 'VN2000_DAK_NONG':
        return VN2000Province.VN2000_DAK_NONG();
      case 'VN2000_PHU_YEN':
        return VN2000Province.VN2000_PHU_YEN();
      case 'VN2000_KHANH_HOA':
        return VN2000Province.VN2000_KHANH_HOA();
      case 'VN2000_NINH_THUAN':
        return VN2000Province.VN2000_NINH_THUAN();
      case 'VN2000_BINH_THUAN':
        return VN2000Province.VN2000_BINH_THUAN();
      case 'VN2000_LAM_DONG':
        return VN2000Province.VN2000_LAM_DONG();
      case 'VN2000_BINH_DUONG':
        return VN2000Province.VN2000_BINH_DUONG();
      case 'VN2000_BINH_PHUOC':
        return VN2000Province.VN2000_BINH_PHUOC();
      case 'VN2000_DONG_NAI':
        return VN2000Province.VN2000_DONG_NAI();
      case 'VN2000_BA_RIA_VUNG_TAU':
        return VN2000Province.VN2000_BA_RIA_VUNG_TAU();
      case 'VN2000_TAY_NINH':
        return VN2000Province.VN2000_TAY_NINH();
      case 'VN2000_LONG_AN':
        return VN2000Province.VN2000_LONG_AN();
      case 'VN2000_TIEN_GIANG':
        return VN2000Province.VN2000_TIEN_GIANG();
      case 'VN2000_BEN_TRE':
        return VN2000Province.VN2000_BEN_TRE();
      case 'VN2000_DONG_THAP':
        return VN2000Province.VN2000_DONG_THAP();
      case 'VN2000_VINH_LONG':
        return VN2000Province.VN2000_VINH_LONG();
      case 'VN2000_TRA_VINH':
        return VN2000Province.VN2000_TRA_VINH();
      case 'VN2000_AN_GIANG':
        return VN2000Province.VN2000_AN_GIANG();
      case 'VN2000_KIEN_GIANG':
        return VN2000Province.VN2000_KIEN_GIANG();
      case 'VN2000_CAN_THO':
        return VN2000Province.VN2000_CAN_THO();
      case 'VN2000_HAU_GIANG':
        return VN2000Province.VN2000_HAU_GIANG();
      case 'VN2000_SOC_TRANG':
        return VN2000Province.VN2000_SOC_TRANG();
      case 'VN2000_BAC_LIEU':
        return VN2000Province.VN2000_BAC_LIEU();
      case 'VN2000_CA_MAU':
        return VN2000Province.VN2000_CA_MAU();
      case 'VN2000_TP_HCM':
        return VN2000Province.VN2000_TP_HCM();
      default:
        return VN2000Province.VN2000_TP_HCM(); // Default to Ho Chi Minh
    }
  }

  /// Get list of available zones
  static List<String> getAvailableZones() {
    return [
      'VN2000_LAI_CHAU',
      'VN2000_DIEN_BIEN',
      'VN2000_SON_LA',
      'VN2000_LAO_CAI',
      'VN2000_YEN_BAI',
      'VN2000_HA_GIANG',
      'VN2000_TUYEN_QUANG',
      'VN2000_PHU_THO',
      'VN2000_VINH_PHUC',
      'VN2000_CAO_BANG',
      'VN2000_LANG_SON',
      'VN2000_BAC_CAN',
      'VN2000_THAI_NGUYEN',
      'VN2000_BAC_GIANG',
      'VN2000_BAC_NINH',
      'VN2000_QUANG_NINH',
      'VN2000_HAI_PHONG',
      'VN2000_HAI_DUONG',
      'VN2000_HUNG_YEN',
      'VN2000_HA_NOI',
      'VN2000_HOA_BINH',
      'VN2000_HA_NAM',
      'VN2000_NAM_DINH',
      'VN2000_THAI_BINH',
      'VN2000_NINH_BINH',
      'VN2000_THANH_HOA',
      'VN2000_NGHE_AN',
      'VN2000_HA_TINH',
      'VN2000_QUANG_BINH',
      'VN2000_QUANG_TRI',
      'VN2000_THUA_THIEN_HUE',
      'VN2000_DA_NANG',
      'VN2000_QUANG_NAM',
      'VN2000_QUANG_NGAI',
      'VN2000_BINH_DINH',
      'VN2000_KON_TUM',
      'VN2000_GIA_LAI',
      'VN2000_DAK_LAK',
      'VN2000_DAK_NONG',
      'VN2000_PHU_YEN',
      'VN2000_KHANH_HOA',
      'VN2000_NINH_THUAN',
      'VN2000_BINH_THUAN',
      'VN2000_LAM_DONG',
      'VN2000_BINH_DUONG',
      'VN2000_BINH_PHUOC',
      'VN2000_DONG_NAI',
      'VN2000_BA_RIA_VUNG_TAU',
      'VN2000_TAY_NINH',
      'VN2000_LONG_AN',
      'VN2000_TIEN_GIANG',
      'VN2000_BEN_TRE',
      'VN2000_DONG_THAP',
      'VN2000_VINH_LONG',
      'VN2000_TRA_VINH',
      'VN2000_AN_GIANG',
      'VN2000_KIEN_GIANG',
      'VN2000_CAN_THO',
      'VN2000_HAU_GIANG',
      'VN2000_SOC_TRANG',
      'VN2000_BAC_LIEU',
      'VN2000_CA_MAU',
      'VN2000_TP_HCM',
    ];
  }

  /// Get friendly display name for province
  static String getProvinceName(String province) {
    final name = province.replaceAll('VN2000_', '').replaceAll('_', ' ');
    return name;
  }
}
