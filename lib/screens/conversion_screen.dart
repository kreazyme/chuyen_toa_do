import 'package:flutter/material.dart';
import '../services/coordinate_converter.dart';
import '../services/history_service.dart';
import '../services/province_preferences.dart';
import '../models/coordinate.dart';
import 'coordinate_detail_screen.dart';
import 'history_screen.dart';

enum ConversionMode { vn2000ToWgs84, wgs84ToVn2000 }

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final _formKey = GlobalKey<FormState>();

  // VN2000 to WGS84 controllers
  final _northingController = TextEditingController();
  final _eastingController = TextEditingController();

  // WGS84 to VN2000 controllers
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  String _selectedZone = 'VN2000_TP_HCM';
  bool _isLoading = false;
  ConversionMode _conversionMode = ConversionMode.vn2000ToWgs84;

  @override
  void initState() {
    super.initState();
    _loadLastProvince();
  }

  Future<void> _loadLastProvince() async {
    final lastProvince = await ProvincePreferences.getLastProvince();
    setState(() {
      _selectedZone = lastProvince;
    });
  }

  @override
  void dispose() {
    _northingController.dispose();
    _eastingController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _convertCoordinates() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        VN2000Coordinate vn2000;
        WGS84Coordinate wgs84;

        if (_conversionMode == ConversionMode.vn2000ToWgs84) {
          // VN2000 to WGS84
          final northing = double.parse(_northingController.text);
          final easting = double.parse(_eastingController.text);

          wgs84 = CoordinateConverter.vn2000ToWgs84(
            northing: northing,
            easting: easting,
            province: _selectedZone,
          );

          vn2000 = VN2000Coordinate(
            northing: northing,
            easting: easting,
            zone: _selectedZone,
          );
        } else {
          // WGS84 to VN2000
          final latitude = double.parse(_latitudeController.text);
          final longitude = double.parse(_longitudeController.text);

          wgs84 = WGS84Coordinate(latitude: latitude, longitude: longitude);

          vn2000 = CoordinateConverter.wgs84ToVn2000(
            latitude: latitude,
            longitude: longitude,
            province: _selectedZone,
          );
        }

        // Save to history
        final record = ConversionRecord(
          vn2000: vn2000,
          wgs84: wgs84,
          timestamp: DateTime.now(),
        );
        await HistoryService.saveConversion(record);

        setState(() {
          _isLoading = false;
        });

        // Navigate to detail screen
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CoordinateDetailScreen(vn2000: vn2000, wgs84: wgs84),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi chuyển đổi: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _conversionMode == ConversionMode.vn2000ToWgs84
              ? 'VN2000 → WGS84'
              : 'WGS84 → VN2000',
        ),
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
            tooltip: 'Lịch sử chuyển đổi',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                const Icon(Icons.map_outlined, size: 64, color: Colors.white70),
                const SizedBox(height: 16),
                Text(
                  'Chuyển đổi tọa độ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _conversionMode == ConversionMode.vn2000ToWgs84
                      ? 'Nhập tọa độ VN-2000 để chuyển sang WGS84'
                      : 'Nhập tọa độ WGS84 để chuyển sang VN-2000',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white60),
                ),
                const SizedBox(height: 24),

                // Mode selector
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildModeButton(
                          label: 'VN2000 → WGS84',
                          mode: ConversionMode.vn2000ToWgs84,
                        ),
                      ),
                      Expanded(
                        child: _buildModeButton(
                          label: 'WGS84 → VN2000',
                          mode: ConversionMode.wgs84ToVn2000,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Input fields based on mode
                if (_conversionMode == ConversionMode.vn2000ToWgs84) ...[
                  // VN2000 to WGS84 inputs
                  TextFormField(
                    controller: _northingController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Northing (Y)',
                      hintText: 'Ví dụ: 1189964',
                      prefixIcon: const Icon(Icons.north),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (_conversionMode == ConversionMode.vn2000ToWgs84) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Northing';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Vui lòng nhập số hợp lệ';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _eastingController,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Easting (X)',
                      hintText: 'Ví dụ: 600997',
                      prefixIcon: const Icon(Icons.east),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (_conversionMode == ConversionMode.vn2000ToWgs84) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Easting';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Vui lòng nhập số hợp lệ';
                        }
                      }
                      return null;
                    },
                  ),
                ] else ...[
                  // WGS84 to VN2000 inputs
                  TextFormField(
                    controller: _latitudeController,
                    decoration: InputDecoration(
                      labelText: 'Latitude (Vĩ độ)',
                      hintText: 'Ví dụ: 10.75909134',
                      prefixIcon: const Icon(Icons.public),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    validator: (value) {
                      if (_conversionMode == ConversionMode.wgs84ToVn2000) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Latitude';
                        }
                        final lat = double.tryParse(value);
                        if (lat == null) {
                          return 'Vui lòng nhập số hợp lệ';
                        }
                        if (lat < -90 || lat > 90) {
                          return 'Latitude phải từ -90 đến 90';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _longitudeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Longitude (Kinh độ)',
                      hintText: 'Ví dụ: 106.67523783',
                      prefixIcon: const Icon(Icons.public),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    validator: (value) {
                      if (_conversionMode == ConversionMode.wgs84ToVn2000) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập Longitude';
                        }
                        final lng = double.tryParse(value);
                        if (lng == null) {
                          return 'Vui lòng nhập số hợp lệ';
                        }
                        if (lng < -180 || lng > 180) {
                          return 'Longitude phải từ -180 đến 180';
                        }
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 16),

                // Zone selector
                DropdownButtonFormField<String>(
                  initialValue: _selectedZone,
                  decoration: InputDecoration(
                    labelText: 'Khu vực (Zone)',
                    prefixIcon: const Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: CoordinateConverter.getAvailableZones()
                      .map(
                        (zone) => DropdownMenuItem(
                          value: zone,
                          child: Text(
                            CoordinateConverter.getProvinceName(zone),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) async {
                    if (value != null) {
                      setState(() {
                        _selectedZone = value;
                      });
                      await ProvincePreferences.saveProvince(value);
                    }
                  },
                ),
                const SizedBox(height: 32),

                // Convert button
                ElevatedButton(
                  onPressed: _isLoading ? null : _convertCoordinates,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Chuyển đổi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 16),

                // Example button
                TextButton.icon(
                  onPressed: () {
                    if (_conversionMode == ConversionMode.vn2000ToWgs84) {
                      _northingController.text = '1189964';
                      _eastingController.text = '600997';
                    } else {
                      _latitudeController.text = '10.75909134';
                      _longitudeController.text = '106.67523783';
                    }
                    setState(() {
                      _selectedZone = 'VN2000_TP_HCM';
                    });
                    ProvincePreferences.saveProvince('VN2000_TP_HCM');
                  },
                  icon: const Icon(Icons.lightbulb_outline),
                  label: const Text('Sử dụng ví dụ'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton({
    required String label,
    required ConversionMode mode,
  }) {
    final isSelected = _conversionMode == mode;
    return InkWell(
      onTap: () {
        setState(() {
          _conversionMode = mode;
          // Clear input fields when switching modes
          _northingController.clear();
          _eastingController.clear();
          _latitudeController.clear();
          _longitudeController.clear();
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[700] : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
