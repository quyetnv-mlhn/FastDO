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
  String get appTagline => 'Trình điều khiển Tùy chọn nhà phát triển nhanh';

  @override
  String get devOptionsEnabled => 'Tùy chọn nhà phát triển Đang Bật';

  @override
  String get devOptionsDisabled => 'Tùy chọn nhà phát triển Đã Tắt';

  @override
  String get statusActive => 'TRẠNG THÁI: HOẠT ĐỘNG';

  @override
  String get statusInactive => 'TRẠNG THÁI: ĐÃ TẮT';

  @override
  String get devOptionsDescActive =>
      'Các ứng dụng ngân hàng và tài chính có thể bị giới hạn truy cập. Chạm để tắt nhanh ngay tức thì.';

  @override
  String get devOptionsDescDisabled =>
      'Thiết bị ở chế độ tiêu chuẩn an toàn. Mọi ứng dụng ngân hàng đều hoạt động bình thường. Chạm để bật lại khi lập trình.';

  @override
  String get usbDebugging => 'Gỡ lỗi USB';

  @override
  String get active => 'Hoạt động';

  @override
  String get inactive => 'Không hoạt động';

  @override
  String get openSystemDevSettings => 'Cài đặt hệ thống';

  @override
  String get qsTileTitle => 'Phím tắt Quick Settings';

  @override
  String get qsTileSubtitle =>
      'Bật/tắt Tùy chọn nhà phát triển trực tiếp từ bảng thông báo mà không cần mở ứng dụng.';

  @override
  String get addTileButton => 'Thêm phím tắt vào Quick Settings';

  @override
  String get tileAddedNotice =>
      'Yêu cầu thêm phím tắt Quick Settings đã được gửi!';

  @override
  String get howToAddTileManual =>
      'Thao tác thủ công: Kéo thanh thông báo xuống 2 lần -> Nhấn biểu tượng Bút chì (Sửa) -> Kéo ô \'Dev Options\' lên bảng điều khiển.';

  @override
  String get permissionRequired => 'Yêu cầu quyền hệ thống';

  @override
  String get permissionDesc =>
      'Android yêu cầu quyền WRITE_SECURE_SETTINGS để điều khiển cài đặt nhà phát triển. Bạn chỉ cần cấp quyền 1 lần duy nhất qua ADB hoặc Root.';

  @override
  String get adbCommandTitle => 'Lệnh thiết lập qua ADB';

  @override
  String get copyCommand => 'Sao chép lệnh';

  @override
  String get commandCopied => 'Đã sao chép lệnh ADB vào bộ nhớ tạm!';

  @override
  String get adbSteps =>
      '1. Bật Gỡ lỗi USB trên điện thoại\n2. Kết nối điện thoại với máy tính bằng cáp USB\n3. Chạy lệnh trên trong Terminal / Command Prompt\n4. Nhấn \'Kiểm tra quyền\' bên dưới';

  @override
  String get grantViaRoot => 'Cấp quyền qua Root (SU)';

  @override
  String get checkPermission => 'Kiểm tra quyền';

  @override
  String get permissionGrantedSuccess => 'Đã xác nhận quyền thành công!';

  @override
  String get permissionNotGranted =>
      'Chưa phát hiện quyền. Vui lòng chạy lệnh ADB trước.';

  @override
  String get rootSuccess => 'Cấp quyền qua Root thành công!';

  @override
  String get rootFailed =>
      'Không thể cấp quyền qua Root. Vui lòng sử dụng lệnh ADB.';

  @override
  String get whyTitle => 'Vì sao bạn cần FastDO?';

  @override
  String get whyProblem =>
      'Các app ngân hàng & fintech thường xuyên chặn thiết bị đang bật Developer Options.\n• Trước khi có FastDO: Cài đặt -> Hệ thống -> Tùy chọn nhà phát triển -> Tắt -> Mở app ngân hàng -> Cài đặt -> Bật lại.\n• Khi có FastDO: 1 chạm từ thanh thông báo Quick Settings. Tiện lợi, tức thì và mượt mà.';

  @override
  String get privacyTitle => '100% Offline & Bảo mật';

  @override
  String get privacyPoints =>
      '✓ Không có quyền truy cập Internet (100% Offline)\n✓ Không theo dõi, không phân tích, không quảng cáo\n✓ Chỉ thay đổi duy nhất giá trị DEVELOPMENT_SETTINGS_ENABLED';

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

  @override
  String get footerTagline => 'FastDO • Fast Developer Options Controller';

  @override
  String get versionInfo => 'Phiên bản 1.0.0';
}
