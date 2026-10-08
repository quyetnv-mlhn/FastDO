# FastDO (Fast Developer Options) 🚀

> **Bật / Tắt Tùy chọn nhà phát triển (Android Developer Options) nhanh chóng với 1 chạm từ thanh phím tắt Quick Settings hoặc giao diện ứng dụng.**

---

## 🎯 Vấn đề & Giải pháp (The Problem & Solution)

Khi phát triển ứng dụng Android/Flutter, chế độ **Tùy chọn nhà phát triển (Developer Options)** thường xuyên phải bật để debug qua USB/Wireless. Tuy nhiên, nhiều ứng dụng ngân hàng và tài chính (Vietcombank, MB, Techcombank, VPBank, Cake, MoMo,...) từ chối mở app khi phát hiện Developer Options đang hoạt động.

Quy trình thủ công rất mất thời gian:
> Cài đặt ➔ Hệ thống ➔ Tùy chọn nhà phát triển ➔ Tắt ➔ Mở app ngân hàng ➔ Dùng xong quay lại Cài đặt ➔ Bật lại.

**FastDO** giải quyết triệt để vấn đề này với **phím tắt 1 chạm trên thanh thông báo (Quick Settings Tile)** hoặc ngay từ màn hình chính ứng dụng.

---

## ✨ Tính năng chính (Features)

- ⚡ **1-Tap Quick Settings Tile**: Thao tác tức thì từ bảng điều khiển nhanh của hệ điều hành Android.
- 🔄 **Đồng bộ thời gian thực (Real-time State Sync)**: Tự động cập nhật giao diện và phím tắt thông qua `ContentObserver` khi hệ thống có thay đổi.
- 🛡️ **Bảo mật & Quyền riêng tư 100% (Offline First)**:
  - Hoạt động hoàn toàn Offline, không có quyền `INTERNET`.
  - Không tracking, không analytics, không quảng cáo.
  - Chỉ can thiệp duy nhất thiết lập hệ thống `Settings.Global.DEVELOPMENT_SETTINGS_ENABLED`.
- 🔌 **Trạng thái Gỡ lỗi USB**: Theo dõi nhanh trạng thái kết nối ADB.
- 🛠️ **Trình hướng dẫn thiết lập ADB & Root**: Sao chép lệnh 1 chạm và hỗ trợ cấp quyền trực tiếp nếu thiết bị đã Root.
- 🎨 **Thiết kế Material 3 chuẩn Clean Architecture**:
  - Hỗ trợ Chế độ Tối (Dark), Sáng (Light) và Hệ thống (System).
  - Hỗ trợ Song ngữ: Tiếng Việt 🇻🇳 và Tiếng Anh 🇺🇸.

---

## 🔑 Hướng dẫn cấp quyền (One-time Setup)

Vì `WRITE_SECURE_SETTINGS` là quyền hệ thống của Android, bạn chỉ cần cấp quyền **1 lần duy nhất** qua ADB:

### Cách 1: Qua ADB trên máy tính (Khuyên dùng)
1. Bật **Gỡ lỗi USB (USB Debugging)** trên điện thoại.
2. Kết nối điện thoại với máy tính qua cáp USB.
3. Chạy lệnh sau trong Terminal / Command Prompt:

```bash
adb shell pm grant com.quyetnv.fastdo android.permission.WRITE_SECURE_SETTINGS
```

### Cách 2: Thiết bị đã Root
Mở FastDO và nhấn nút **"Cấp quyền qua Root (SU)"**, ứng dụng sẽ tự động kích hoạt quyền trực tiếp.

---

## 📱 Cài đặt Quick Settings Tile

1. Kéo thanh thông báo (Notification Shade) xuống 2 lần.
2. Nhấn biểu tượng **Chỉnh sửa / Bút chì**.
3. Tìm ô phím tắt **"Dev Options"** của FastDO và kéo lên bảng phím tắt hoạt động.
4. Chạm để Bật/Tắt Developer Options bất cứ lúc nào.

---

## 🏗️ Kiến trúc dự án (Clean Architecture)

```text
lib/
├── core/                   # Shared config, theme, routing, utils, errors, base widgets
├── data/                   # Data Layer (DataSources, DTOs, Repositories Implementation)
├── domain/                 # Domain Layer (Pure Dart: Entities, Repositories, UseCases)
├── presentation/           # Presentation Layer (BLoC/Cubit, Pages, Widgets, L10n)
├── app.dart                # MaterialApp.router, Theme, Localization Config
└── main.dart               # Bootstrap, Dependency Injection, App Entry
```

---

## 🚀 Lệnh chạy & Build

```bash
# Cài đặt dependencies
fvm flutter pub get

# Sinh mã Freezed, Injectable & L10n
fvm flutter gen-l10n
fvm dart run build_runner build --delete-conflicting-outputs

# Kiểm tra mã nguồn & chạy kiểm thử
fvm flutter analyze
fvm flutter test

# Build file APK phát hành
fvm flutter build apk --release
```
