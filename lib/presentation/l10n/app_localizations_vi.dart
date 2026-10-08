// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'FastDO';

  @override
  String get appTagline => 'Bật / Tắt Tùy chọn nhà phát triển với 1 chạm';

  @override
  String get devOptionsEnabled => 'ĐANG BẬT TÙY CHỌN NHÀ PHÁT TRIỂN';

  @override
  String get devOptionsDisabled => 'ĐÃ TẮT TÙY CHỌN NHÀ PHÁT TRIỂN';

  @override
  String get statusActive => 'Trạng thái: BẬT';

  @override
  String get statusInactive => 'Trạng thái: TẮT';

  @override
  String get devOptionsDescActive =>
      'Các ứng dụng ngân hàng hoặc bảo mật có thể bị chặn. Nhấn để tắt nhanh.';

  @override
  String get devOptionsDescDisabled =>
      'An toàn cho các ứng dụng ngân hàng và fintech. Nhấn để bật lại khi lập trình.';

  @override
  String get usbDebugging => 'Gỡ lỗi USB';

  @override
  String get active => 'Hoạt động';

  @override
  String get inactive => 'Không hoạt động';

  @override
  String get openSystemDevSettings => 'Mở Tùy chọn nhà phát triển';

  @override
  String get qsTileTitle => 'Cài đặt Quick Settings Tile';

  @override
  String get qsTileSubtitle =>
      'Thêm ô tiện ích vào thanh trạng thái (Notification Shade) để bật/tắt mọi lúc mà không cần mở ứng dụng.';

  @override
  String get addTileButton => 'Thêm vào Quick Settings (Android 13+)';

  @override
  String get tileAddedNotice => 'Yêu cầu thêm ô Quick Settings đã được gửi!';

  @override
  String get howToAddTileManual =>
      'Cách thêm thủ công: Kéo thanh thông báo xuống 2 lần -> Nhấn biểu tượng Bút chì (Sửa) -> Kéo ô \"Dev Options\" lên bảng điều khiển.';

  @override
  String get permissionRequired => 'Cần cấp quyền WRITE_SECURE_SETTINGS';

  @override
  String get permissionDesc =>
      'Android yêu cầu quyền hệ thống này để bật/tắt Tùy chọn nhà phát triển trực tiếp. Bạn chỉ cần thực hiện 1 lần duy nhất qua ADB hoặc Root.';

  @override
  String get adbCommandTitle => 'Lệnh ADB (Khuyên dùng):';

  @override
  String get copyCommand => 'Sao chép lệnh';

  @override
  String get commandCopied => 'Đã sao chép lệnh ADB vào clipboard!';

  @override
  String get adbSteps =>
      '1. Bật Gỡ lỗi USB (USB Debugging) trên điện thoại\n2. Kết nối điện thoại với máy tính qua cáp USB\n3. Mở Terminal / CMD trên máy tính và chạy lệnh trên\n4. Nhấn \"Kiểm tra lại quyền\" bên dưới';

  @override
  String get grantViaRoot => 'Cấp quyền qua Root (SU)';

  @override
  String get checkPermission => 'Kiểm tra lại quyền';

  @override
  String get permissionGrantedSuccess => 'Quyền đã được cấp thành công!';

  @override
  String get permissionNotGranted =>
      'Chưa nhận được quyền. Vui lòng chạy lệnh ADB trước.';

  @override
  String get rootSuccess => 'Cấp quyền thành công qua Root!';

  @override
  String get rootFailed =>
      'Không thể cấp quyền qua Root. Vui lòng dùng lệnh ADB.';

  @override
  String get whyTitle => 'Tại sao lại cần FastDO?';

  @override
  String get whyProblem =>
      '• Vấn đề: Các app ngân hàng (Vietcombank, MB, Techcombank, VPBank,...) và fintech chặn người dùng khi bật Developer Options.\n• Trước đây: Mở Cài đặt -> Hệ thống -> Tùy chọn nhà phát triển -> Tắt -> Mở app ngân hàng -> Mở lại Cài đặt -> Bật lại. Rất mất thời gian!\n• Với FastDO: Chỉ 1 chạm từ thanh Quick Settings hoặc widget, bạn có thể tắt ngay khi vào app ngân hàng và bật lại ngay khi code!';

  @override
  String get privacyTitle => 'Bảo mật & Quyền riêng tư';

  @override
  String get privacyPoints =>
      '✓ 100% Offline, không có quyền INTERNET\n✓ Không quảng cáo, không phân tích, không thu thập dữ liệu\n✓ Chỉ thay đổi đúng 1 cài đặt: DEVELOPMENT_SETTINGS_ENABLED\n✓ Mã nguồn mở và hoàn toàn minh bạch';

  @override
  String get theme => 'Giao diện';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get systemMode => 'Hệ thống';

  @override
  String get darkMode => 'Tối';

  @override
  String get lightMode => 'Sáng';

  @override
  String get toggleSuccess => 'Đã cập nhật trạng thái Tùy chọn nhà phát triển!';

  @override
  String get toggleFailed =>
      'Không thể thay đổi trạng thái Tùy chọn nhà phát triển.';
}
