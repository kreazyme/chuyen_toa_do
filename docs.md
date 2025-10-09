# 📱 VN2000 ↔ WGS84 Converter App

## 🎯 Mục tiêu

Ứng dụng giúp người dùng **chuyển đổi tọa độ hai chiều giữa hệ VN-2000 và WGS84** (lat/lng) và hiển thị vị trí trên bản đồ.

---

## 🧩 Yêu cầu cơ bản

### 1. Thiết kế

- Giao diện **đơn giản, hợp lý, hiện đại** (không cầu kỳ).
- Ưu tiên **trải nghiệm mượt mà** và **bố cục rõ ràng**.
- Sử dụng màu trung tính, icon đơn giản.

---

### 2. Chức năng chính

#### 🧮 Màn hình 1: Chuyển đổi tọa độ (Bidirectional)

**Chế độ 1: VN2000 → WGS84**

- Input:
  - Northing (Y)
  - Easting (X)
  - Zone (mặc định TP HCM)
- Khi bấm **"Chuyển đổi"**:
  - App sẽ tính toán tọa độ **lat/lng (WGS84)**.
  - Sau khi chuyển đổi thành công → chuyển sang màn hình chi tiết.

**Chế độ 2: WGS84 → VN2000**

- Input:
  - Latitude (Vĩ độ)
  - Longitude (Kinh độ)
  - Zone (mặc định TP HCM)
- Khi bấm **"Chuyển đổi"**:
  - App sẽ tính toán tọa độ **VN2000 (X, Y)**.
  - Sau khi chuyển đổi thành công → chuyển sang màn hình chi tiết.

---

#### 🗺️ Màn hình 2: Chi tiết tọa độ

- Hiển thị:
  - Lat, Lng đã chuyển đổi
  - Có **map view** (Google Map hoặc Leaflet) hiển thị marker tại vị trí đó.
- Có nút **"Mở trên bản đồ"** → mở Google Maps (hoặc ứng dụng bản đồ mặc định) với tọa độ đó.

---

### 3. Công nghệ

- Ngôn ngữ: **Flutter**
- Tính toán tọa độ:
  - Sử dụng thư viện `dart_vn2000`
  - Thư viện này có sẵn hàm chuyển đổi VN2000 → WGS84.
  - Thư viện `dart_vn2000` bị lỗi import `package:dart_vn2000/src/configs.dart` nên cần thêm dòng này.
- Example:

```dart
import 'package:dart_vn2000/dart_vn2000.dart';
import 'package:dart_vn2000/src/configs.dart';
void main() {
  final vn2000ToWGS84 = DartVN2000Converter.vn2000ToWGS84(
    dx: 600997,
    dy: 1189964,
    province: VN2000Province.VN2000_TP_HCM,
  );

  final wgs84ToVN2000 = DartVN2000Converter.wgs84ToVN2000(
    longitude: 106.67523783,
    latitude: 10.75909134,
    province: VN2000Province.VN2000_TP_HCM,
  );
  print(vn2000ToWGS84);
  print(wgs84ToVN2000);
}
```

---

### 4. Yêu cầu kỹ thuật

- Code gọn gàng, dễ mở rộng.
- Có tách biệt phần:
  - **Logic tính toán tọa độ**
  - **Giao diện / UI**
- ✅ **Đã hoàn thành**: Chuyển đổi hai chiều (VN2000 ↔ WGS84).

---

### 5. Gợi ý thêm

- Thêm **history** (lịch sử chuyển đổi gần đây).
- Cho phép **copy tọa độ nhanh**.
- Hiển thị **khoảng cách đến vị trí hiện tại** (nếu bật GPS).

---

## 🚀 Mục tiêu giai đoạn 1

- [x] Hoàn thiện UI cơ bản
- [x] Thực hiện chính xác chuyển đổi VN2000 → WGS84
- [x] Thực hiện chính xác chuyển đổi WGS84 → VN2000
- [x] Hiển thị bản đồ và marker
- [x] Nút mở bản đồ ngoài
- [x] Lịch sử chuyển đổi
- [x] Sao chép tọa độ nhanh

## Provinces list:

VN2000Province.VN2000_LAI_CHAU
VN2000Province.VN2000_DIEN_BIEN
VN2000Province.VN2000_SON_LA
VN2000Province.VN2000_LAO_CAI
VN2000Province.VN2000_YEN_BAI
VN2000Province.VN2000_HA_GIANG
VN2000Province.VN2000_TUYEN_QUANG
VN2000Province.VN2000_PHU_THO
VN2000Province.VN2000_VINH_PHUC
VN2000Province.VN2000_CAO_BANG
VN2000Province.VN2000_LANG_SON
VN2000Province.VN2000_BAC_CAN
VN2000Province.VN2000_THAI_NGUYEN
VN2000Province.VN2000_BAC_GIANG
VN2000Province.VN2000_BAC_NINH
VN2000Province.VN2000_QUANG_NINH
VN2000Province.VN2000_HAI_PHONG
VN2000Province.VN2000_HAI_DUONG
VN2000Province.VN2000_HUNG_YEN
VN2000Province.VN2000_HA_NOI
VN2000Province.VN2000_HOA_BINH
VN2000Province.VN2000_HA_NAM
VN2000Province.VN2000_NAM_DINH
VN2000Province.VN2000_THAI_BINH
VN2000Province.VN2000_NINH_BINH
VN2000Province.VN2000_THANH_HOA
VN2000Province.VN2000_NGHE_AN
VN2000Province.VN2000_HA_TINH
VN2000Province.VN2000_QUANG_BINH
VN2000Province.VN2000_QUANG_TRI
VN2000Province.VN2000_THUA_THIEN_HUE
VN2000Province.VN2000_DA_NANG
VN2000Province.VN2000_QUANG_NAM
VN2000Province.VN2000_QUANG_NGAI
VN2000Province.VN2000_BINH_DINH
VN2000Province.VN2000_KON_TUM
VN2000Province.VN2000_GIA_LAI
VN2000Province.VN2000_DAK_LAK
VN2000Province.VN2000_DAK_NONG
VN2000Province.VN2000_PHU_YEN
VN2000Province.VN2000_KHANH_HOA
VN2000Province.VN2000_NINH_THUAN
VN2000Province.VN2000_BINH_THUAN
VN2000Province.VN2000_LAM_DONG
VN2000Province.VN2000_BINH_DUONG
VN2000Province.VN2000_BINH_PHUOC
VN2000Province.VN2000_DONG_NAI
VN2000Province.VN2000_BA_RIA_VUNG_TAU
VN2000Province.VN2000_TAY_NINH
VN2000Province.VN2000_LONG_AN
VN2000Province.VN2000_TIEN_GIANG
VN2000Province.VN2000_BEN_TRE
VN2000Province.VN2000_DONG_THAP
VN2000Province.VN2000_VINH_LONG
VN2000Province.VN2000_TRA_VINH
VN2000Province.VN2000_AN_GIANG
VN2000Province.VN2000_KIEN_GIANG
VN2000Province.VN2000_CAN_THO
VN2000Province.VN2000_HAU_GIANG
VN2000Province.VN2000_SOC_TRANG
VN2000Province.VN2000_BAC_LIEU
VN2000Province.VN2000_CA_MAU
VN2000Province.VN2000_TP_HCM
