import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Về hệ tọa độ'),
        elevation: 0,
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Icon(Icons.info_outline, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'Tại sao cần chuyển đổi tọa độ?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // WGS84 section
            _buildSection(
              context,
              title: '🌍 WGS84 (World Geodetic System 1984)',
              content: '''
• Hệ tọa độ địa lý toàn cầu được sử dụng rộng rãi trên thế giới
• Được GPS và các ứng dụng bản đồ như Google Maps sử dụng
• Biểu diễn bằng kinh độ (Longitude) và vĩ độ (Latitude)
• Đơn vị: độ thập phân (decimal degrees)
• Ví dụ: 10.7591°N, 106.6752°E (TP.HCM)

Ưu điểm:
✓ Tiêu chuẩn quốc tế
✓ Tương thích với GPS
✓ Dễ chia sẻ và sử dụng trên internet''',
            ),

            const SizedBox(height: 24),

            // VN-2000 section
            _buildSection(
              context,
              title: '🇻🇳 VN-2000 (Hệ tọa độ quốc gia Việt Nam 2000)',
              content: '''
• Hệ tọa độ phẳng chính thức của Việt Nam từ năm 2000
• Được thiết kế riêng cho lãnh thổ Việt Nam
• Biểu diễn bằng tọa độ Đông (X) và tọa độ Bắc (Y)
• Đơn vị: mét (meters)
• Ví dụ: X=600997m, Y=1189964m (TP.HCM)

Ưu điểm cho Việt Nam:
✓ Độ chính xác cao trong phạm vi lãnh thổ VN
✓ Thuận tiện cho đo đạc, xây dựng
✓ Tiêu chuẩn chính thức trong các dự án nhà nước
✓ Phù hợp với địa hình và vị trí địa lý Việt Nam''',
            ),

            const SizedBox(height: 24),

            // Why VN-2000 section
            _buildSection(
              context,
              title: '🎯 Tại sao Việt Nam cần VN-2000?',
              content: '''
Trước năm 2000, Việt Nam sử dụng nhiều hệ tọa độ khác nhau:
• Miền Bắc: Hệ tọa độ Hà Nội 1972
• Miền Nam: Hệ tọa độ Indian 1960
• Gây khó khăn trong quản lý và kết nối dữ liệu địa lý

VN-2000 được thiết lập để:
✓ Thống nhất hệ tọa độ trên toàn quốc
✓ Nâng cao độ chính xác đo đạc
✓ Phục vụ phát triển kinh tế-xã hội
✓ Đáp ứng yêu cầu hội nhập quốc tế
✓ Hỗ trợ quản lý đất đai, quy hoạch đô thị''',
            ),

            const SizedBox(height: 24),

            // When to use section
            _buildSection(
              context,
              title: '🔄 Khi nào cần chuyển đổi?',
              content: '''
Chuyển từ VN-2000 sang WGS84 khi:
• Muốn xem vị trí trên Google Maps
• Chia sẻ tọa độ qua GPS, điện thoại
• Sử dụng với các ứng dụng bản đồ quốc tế
• Tích hợp với hệ thống định vị toàn cầu

Chuyển từ WGS84 sang VN-2000 khi:
• Làm việc với bản đồ địa chính Việt Nam
• Thực hiện dự án xây dựng, đo đạc
• Báo cáo cho cơ quan nhà nước
• Sử dụng trong các phần mềm GIS của Việt Nam''',
            ),

            const SizedBox(height: 24),

            // Legal basis section
            _buildSection(
              context,
              title: '📋 Cơ sở pháp lý',
              content: '''
Việc sử dụng hệ tọa độ VN-2000 được quy định trong:

• Nghị quyết số 48/2000/QĐ-TTg ngày 21/4/2000
• Quy định việc áp dụng hệ tọa độ quốc gia VN-2000
• Thay thế các hệ tọa độ cũ trên toàn quốc

Xem chi tiết tại văn bản chính thức:''',
            ),

            const SizedBox(height: 16),

            // Official document link
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[900]?.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[700]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📄 Văn bản chính thức',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nghị quyết số 48/2000/QĐ-TTg\nVề việc áp dụng hệ tọa độ quốc gia VN-2000',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => _launchUrl(
                      'https://chinhphu.vn/default.aspx?docid=21337&pageid=27160',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.open_in_browser),
                    label: const Text('Xem văn bản gốc'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Usage note
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[900]?.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[700]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.green[400]),
                      const SizedBox(width: 8),
                      const Text(
                        'Lưu ý sử dụng',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Chọn đúng múi chiếu (zone) theo vùng địa lý\n'
                    '• TP.HCM và miền Nam: VN2000_TP_HCM\n'
                    '• Hà Nội và miền Bắc: VN2000_HA_NOI\n'
                    '• Kiểm tra kết quả trên bản đồ sau khi chuyển đổi',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800]?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
