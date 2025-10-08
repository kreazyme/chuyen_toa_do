import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/coordinate.dart';
import '../services/coordinate_converter.dart';

class CoordinateDetailScreen extends StatelessWidget {
  final VN2000Coordinate vn2000;
  final WGS84Coordinate wgs84;

  const CoordinateDetailScreen({
    super.key,
    required this.vn2000,
    required this.wgs84,
  });

  Future<void> _openInMaps(BuildContext context) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${wgs84.latitude},${wgs84.longitude}',
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Không thể mở bản đồ'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã sao chép $label'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết tọa độ'),
        elevation: 0,
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Map view
            SizedBox(
              height: 300,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(wgs84.latitude, wgs84.longitude),
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.chuyen_toa_do',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(wgs84.latitude, wgs84.longitude),
                        width: 80,
                        height: 80,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Coordinate information
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // WGS84 coordinates
                  _buildSectionTitle('Tọa độ WGS84'),
                  const SizedBox(height: 12),
                  _buildCoordinateCard(
                    context,
                    icon: Icons.public,
                    label: 'Latitude (Vĩ độ)',
                    value: wgs84.latitude.toStringAsFixed(8),
                    onCopy: () => _copyToClipboard(
                      context,
                      wgs84.latitude.toString(),
                      'Latitude',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCoordinateCard(
                    context,
                    icon: Icons.public,
                    label: 'Longitude (Kinh độ)',
                    value: wgs84.longitude.toStringAsFixed(8),
                    onCopy: () => _copyToClipboard(
                      context,
                      wgs84.longitude.toString(),
                      'Longitude',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // VN2000 coordinates
                  _buildSectionTitle('Tọa độ VN-2000'),
                  const SizedBox(height: 12),
                  _buildCoordinateCard(
                    context,
                    icon: Icons.navigation,
                    label: 'Northing (Y)',
                    value: vn2000.northing.toStringAsFixed(2),
                    onCopy: () => _copyToClipboard(
                      context,
                      vn2000.northing.toString(),
                      'Northing',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCoordinateCard(
                    context,
                    icon: Icons.navigation,
                    label: 'Easting (X)',
                    value: vn2000.easting.toStringAsFixed(2),
                    onCopy: () => _copyToClipboard(
                      context,
                      vn2000.easting.toString(),
                      'Easting',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCoordinateCard(
                    context,
                    icon: Icons.location_city,
                    label: 'Zone',
                    value: CoordinateConverter.getProvinceName(vn2000.zone),
                    onCopy: () =>
                        _copyToClipboard(context, vn2000.zone, 'Zone'),
                  ),
                  const SizedBox(height: 32),

                  // Open in Maps button
                  ElevatedButton.icon(
                    onPressed: () => _openInMaps(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.map, color: Colors.white),
                    label: const Text(
                      'Mở trên bản đồ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Copy full coordinates button
                  OutlinedButton.icon(
                    onPressed: () {
                      final fullCoord = '${wgs84.latitude}, ${wgs84.longitude}';
                      _copyToClipboard(context, fullCoord, 'tọa độ đầy đủ');
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.blue[300]!),
                    ),
                    icon: Icon(Icons.content_copy, color: Colors.blue[300]),
                    label: Text(
                      'Sao chép tọa độ',
                      style: TextStyle(fontSize: 16, color: Colors.blue[300]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCoordinateCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onCopy,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[300], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onCopy,
            icon: const Icon(Icons.copy, size: 20),
            color: Colors.grey[400],
            tooltip: 'Sao chép',
          ),
        ],
      ),
    );
  }
}
