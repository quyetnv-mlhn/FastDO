# FastDO (Fast Developer Options) 🚀

> **Bật / Tắt Tùy chọn nhà phát triển (Android Developer Options) chỉ với 1 chạm từ Quick Settings hoặc giao diện ứng dụng.**  
> *Dự án Flutter lấy cảm hứng và tham khảo từ [Loophole (shubhang-d/loophole)](https://github.com/shubhang-d/loophole).*

---

## 🎯 Vấn đề thực tế (The Problem)

Nếu bạn là lập trình viên Android hoặc Flutter, chế độ **Tùy chọn nhà phát triển (Developer Options)** hầu như luôn được bật để debug. Tuy nhiên, rất nhiều ứng dụng ngân hàng và fintech (Vietcombank, MB Bank, Techcombank, VPBank, Cake, MoMo,...) chặn hoặc từ chối mở app khi phát hiện Developer Options đang bật.

Quy trình thông thường rất phiền phức:
> Mở Cài đặt ➔ Hệ thống ➔ Tùy chọn nhà phát triển ➔ Tắt ➔ Mở ứng dụng ngân hàng ➔ Sau khi dùng xong, mở lại Cài đặt ➔ Bật lại Developer Options.

**FastDO** biến toàn bộ quy trình đó thành **1 chạm ngay từ thanh thông báo (Quick Settings Tile)** hoặc từ widget/giao diện ứng dụng!

---

## ✨ Tính năng chính (Features)

- ⚡ **1-Tap Quick Settings Tile**: Kéo thanh thông báo xuống và chạm vào ô "Dev Options" để bật/tắt tức thì.
- 🔄 **Real-time Sync**: Tự động đồng bộ trạng thái ngay lập tức khi bạn thay đổi từ Cài đặt hệ thống, ô Quick Settings hoặc trong ứng dụng (thông qua `ContentObserver`).
- 🛡️ **Bảo mật tuyệt đối (100% Offline)**:
  - Không yêu cầu quyền `INTERNET` (Zero network permissions).
  - Không quảng cáo, không theo dõi, không gửi dữ liệu ra ngoài.
  - Chỉ đọc và điều khiển hai thiết lập hệ thống `DEVELOPMENT_SETTINGS_ENABLED` và `ADB_ENABLED`.
- 🔌 **Tích hợp gỡ lỗi USB (ADB Status)**: Hiển thị trạng thái USB Debugging trực tiếp trên giao diện.
- 🛠️ **Hỗ trợ Root / ADB Setup Wizard**: Hướng dẫn chi tiết từng bước cấp quyền `WRITE_SECURE_SETTINGS` qua ADB hoặc 1 chạm nếu thiết bị đã Root.
- 🎨 **Giao diện Material 3 & Song ngữ**:
  - Hỗ trợ Dark Mode / Light Mode / Hệ thống.
  - Hỗ trợ tiếng Việt 🇻🇳 và tiếng Anh 🇺🇸.

---

## 🔑 Hướng dẫn cấp quyền (One-time Setup)

Vì việc thay đổi cài đặt bảo mật của Android yêu cầu quyền hệ thống `WRITE_SECURE_SETTINGS`, bạn chỉ cần cấp quyền **1 lần duy nhất** qua ADB:

### Cách 1: Qua máy tính bằng ADB (Khuyên dùng)
1. Bật **Gỡ lỗi USB (USB Debugging)** trên điện thoại.
2. Cắm cáp kết nối điện thoại với máy tính.
3. Mở Terminal / Command Prompt và chạy lệnh:

```bash
adb shell pm grant com.quyetnv.fastdo android.permission.WRITE_SECURE_SETTINGS
```

### Cách 2: Thiết bị đã Root
Mở app FastDO và nhấn nút **"Cấp quyền qua Root (SU)"**, ứng dụng sẽ tự động cấp quyền trực tiếp!

Sau khi đã có quyền `WRITE_SECURE_SETTINGS`, FastDO sẽ đồng bộ Developer Options và USB Debugging khi bạn bật hoặc tắt từ ứng dụng hoặc Quick Settings. Khi bật từ giao diện ứng dụng, FastDO hiển thị cảnh báo trước khi bật USB Debugging.

---

## 📱 Cài đặt Quick Settings Tile

1. Kéo thanh thông báo (Notification Shade) xuống 2 lần.
2. Nhấn vào biểu tượng **Chỉnh sửa / Bút chì (Edit)**.
3. Tìm ô **"Dev Options"** của FastDO và kéo lên danh sách phím tắt hoạt động.
4. Xong! Bạn có thể chạm để Bật/Tắt Developer Options bất cứ lúc nào.

---

## 🏗️ Cấu trúc dự án (Architecture)

```
FastDO/
├── android/
│   └── app/src/main/
│       ├── AndroidManifest.xml          # Khai báo WRITE_SECURE_SETTINGS & TileService
│       ├── res/drawable/ic_tile_dev.xml # Vector icon cho Quick Settings Tile
│       └── kotlin/com/quyetnv/fastdo/
│           ├── MainActivity.kt          # MethodChannel, EventChannel, ContentObserver
│           ├── DevSettingsHelper.kt     # Đọc/ghi Settings.Global & kiểm tra quyền
│           └── FastDoTileService.kt     # TileService xử lý tương tác Quick Settings
├── lib/
│   ├── main.dart                        # Điểm khởi chạy ứng dụng
│   ├── l10n/translations.dart           # Song ngữ Việt - Anh
│   ├── models/dev_settings_state.dart   # State model
│   ├── providers/dev_settings_provider.dart # Quản lý logic & lắng nghe stream
│   ├── services/dev_settings_service.dart   # Native Platform Bridge
│   ├── theme/app_theme.dart             # Material 3 Themes (Light / Dark)
│   ├── widgets/
│   │   ├── status_hero_card.dart        # Thẻ toggle chính & trạng thái
│   │   ├── permission_guide_card.dart   # Hướng dẫn cấp quyền ADB & Root
│   │   ├── quick_settings_tile_card.dart# Hướng dẫn cài đặt Quick Settings Tile
│   │   ├── features_info_card.dart      # Giải thích vấn đề app ngân hàng
│   │   └── privacy_card.dart            # Cam kết quyền riêng tư & bảo mật
│   └── screens/
│       └── home_screen.dart             # Màn hình chính
└── test/
    └── widget_test.dart
```

---

## 🚀 Hướng dẫn chạy & Build ứng dụng

```bash
# Cài đặt dependencies
flutter pub get

# Chạy ứng dụng trên thiết bị
flutter run

# Build file APK phát hành
flutter build apk --release
```

---

## 📄 Bản quyền (License)

Dự án phát triển mã nguồn mở tuân thủ giấy phép MIT. Tham khảo và học hỏi từ dự án [shubhang-d/loophole](https://github.com/shubhang-d/loophole).
