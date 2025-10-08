class VN2000Coordinate {
  final double northing; // Y
  final double easting; // X
  final String zone;

  VN2000Coordinate({
    required this.northing,
    required this.easting,
    required this.zone,
  });

  Map<String, dynamic> toJson() => {
    'northing': northing,
    'easting': easting,
    'zone': zone,
  };

  factory VN2000Coordinate.fromJson(Map<String, dynamic> json) =>
      VN2000Coordinate(
        northing: json['northing'] as double,
        easting: json['easting'] as double,
        zone: json['zone'] as String,
      );
}

class WGS84Coordinate {
  final double latitude;
  final double longitude;

  WGS84Coordinate({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  factory WGS84Coordinate.fromJson(Map<String, dynamic> json) =>
      WGS84Coordinate(
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
      );
}

class ConversionRecord {
  final VN2000Coordinate vn2000;
  final WGS84Coordinate wgs84;
  final DateTime timestamp;

  ConversionRecord({
    required this.vn2000,
    required this.wgs84,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'vn2000': vn2000.toJson(),
    'wgs84': wgs84.toJson(),
    'timestamp': timestamp.toIso8601String(),
  };

  factory ConversionRecord.fromJson(Map<String, dynamic> json) =>
      ConversionRecord(
        vn2000: VN2000Coordinate.fromJson(json['vn2000']),
        wgs84: WGS84Coordinate.fromJson(json['wgs84']),
        timestamp: DateTime.parse(json['timestamp']),
      );
}
