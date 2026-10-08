class AppStrings {
  static bool isVietnamese = true;

  // Title & Header
  static String get appName => 'FastDO';
  static String get appTagline => isVietnamese
      ? 'Bật / Tắt Tùy chọn nhà phát triển với 1 chạm'
      : 'One-tap Quick Toggle for Android Developer Options';

  // Status Card
  static String get devOptionsActive => isVietnamese
      ? 'ĐANG BẬT TÙY CHỌN NHÀ PHÁT TRIỂN'
      : 'DEVELOPER OPTIONS ENABLED';
  static String get devOptionsDisabled => isVietnamese
      ? 'ĐÃ TẮT TÙY CHỌN NHÀ PHÁT TRIỂN'
      : 'DEVELOPER OPTIONS DISABLED';
  static String get devOptionsDescActive => isVietnamese
      ? 'Các ứng dụng ngân hàng hoặc bảo mật có thể bị chặn. Nhấn để tắt nhanh.'
      : 'Banking & security apps may block access. Tap to quickly disable.';
  static String get devOptionsDescDisabled => isVietnamese
      ? 'An toàn cho các ứng dụng ngân hàng và fintech. Nhấn để bật lại khi lập trình.'
      : 'Safe for banking & fintech apps. Tap to re-enable when coding.';

  static String get enableUsbWarningTitle =>
      isVietnamese ? 'Bật USB Debugging?' : 'Enable USB Debugging?';
  static String get enableUsbWarningDesc => isVietnamese
      ? 'Để đồng bộ trạng thái, FastDO sẽ bật cả USB Debugging. Chỉ tiếp tục nếu bạn hiểu rõ rủi ro bảo mật.'
      : 'To keep the settings synchronized, FastDO will also enable USB Debugging. Continue only if you understand the security risk.';
  static String get cancel => isVietnamese ? 'Hủy' : 'Cancel';
  static String get continueAction => isVietnamese ? 'Tiếp tục' : 'Continue';

  static String get usbDebugging =>
      isVietnamese ? 'Gỡ lỗi USB' : 'USB Debugging';
  static String get active => isVietnamese ? 'Hoạt động' : 'Active';
  static String get inactive => isVietnamese ? 'Không hoạt động' : 'Inactive';

  static String get openSystemSettings =>
      isVietnamese ? 'Mở Tùy chọn nhà phát triển' : 'Open System Dev Settings';

  // Quick Settings Tile Card
  static String get qsTileTitle =>
      isVietnamese ? 'Cài đặt Quick Settings Tile' : 'Quick Settings Tile';
  static String get qsTileSubtitle => isVietnamese
      ? 'Thêm ô tiện ích vào thanh trạng thái (Notification Shade) để bật/tắt mọi lúc mà không cần mở ứng dụng.'
      : 'Add a tile to your notification shade to toggle anytime without opening the app.';
  static String get addTileButton => isVietnamese
      ? 'Thêm vào Quick Settings (Android 13+)'
      : 'Add to Quick Settings (Android 13+)';
  static String get tileAddedNotice => isVietnamese
      ? 'Yêu cầu thêm ô Quick Settings đã được gửi!'
      : 'Quick Settings tile request sent!';
  static String get howToAddTileManual => isVietnamese
      ? 'Cách thêm thủ công: Kéo thanh thông báo xuống 2 lần -> Nhấn biểu tượng Bút chì (Sửa) -> Kéo ô "Dev Options" lên bảng điều khiển.'
      : 'Manual setup: Pull down notification shade twice -> Tap Edit (Pencil icon) -> Drag "Dev Options" tile into your active panel.';

  // Permission Card
  static String get permissionRequired => isVietnamese
      ? 'Cần cấp quyền WRITE_SECURE_SETTINGS'
      : 'WRITE_SECURE_SETTINGS Required';
  static String get permissionDesc => isVietnamese
      ? 'Android yêu cầu quyền hệ thống này để bật/tắt Tùy chọn nhà phát triển trực tiếp. Bạn chỉ cần thực hiện 1 lần duy nhất qua ADB hoặc Root.'
      : 'Android requires this secure system permission to modify developer settings. Setup is only required once via ADB or Root.';
  static String get adbCommandTitle =>
      isVietnamese ? 'Lệnh ADB (Khuyên dùng):' : 'ADB Command (Recommended):';
  static String get copyCommand =>
      isVietnamese ? 'Sao chép lệnh' : 'Copy Command';
  static String get commandCopied => isVietnamese
      ? 'Đã sao chép lệnh ADB vào clipboard!'
      : 'ADB command copied to clipboard!';
  static String get adbSteps => isVietnamese
      ? '1. Bật Gỡ lỗi USB (USB Debugging) trên điện thoại\n2. Kết nối điện thoại với máy tính qua cáp USB\n3. Mở Terminal / CMD trên máy tính và chạy lệnh trên\n4. Nhấn "Kiểm tra lại quyền" bên dưới'
      : '1. Enable USB Debugging in your phone settings\n2. Connect phone to computer via USB cable\n3. Open Terminal / CMD on your PC and run the command above\n4. Tap "Check Permission" below';
  static String get grantViaRoot =>
      isVietnamese ? 'Cấp quyền qua Root (SU)' : 'Grant via Root (SU)';
  static String get checkPermissionAgain =>
      isVietnamese ? 'Kiểm tra lại quyền' : 'Check Permission';
  static String get rootSuccess => isVietnamese
      ? 'Cấp quyền thành công qua Root!'
      : 'Permission granted via Root successfully!';
  static String get rootFailed => isVietnamese
      ? 'Không thể cấp quyền qua Root. Vui lòng dùng lệnh ADB.'
      : 'Root grant failed. Please use the ADB command.';

  // Why FastDO
  static String get whyTitle =>
      isVietnamese ? 'Tại sao lại cần FastDO?' : 'Why do you need FastDO?';
  static String get whyProblem => isVietnamese
      ? '• Vấn đề: Các app ngân hàng (Vietcombank, MB, Techcombank, VPBank,...) và fintech chặn người dùng khi bật Developer Options.\n• Trước đây: Mở Cài đặt -> Hệ thống -> Tùy chọn nhà phát triển -> Tắt -> Mở app ngân hàng -> Mở lại Cài đặt -> Bật lại. Rất mất thời gian!\n• Với FastDO: Chỉ 1 chạm từ thanh Quick Settings hoặc widget, bạn có thể tắt ngay khi vào app ngân hàng và bật lại ngay khi code!'
      : '• The Problem: Banking apps & fintech strictly block access when Developer Options is enabled.\n• Before: Navigate Settings -> System -> Developer Options -> Turn off -> Open bank app -> Navigate back -> Turn on. Tedious!\n• With FastDO: One tap from notification shade. Switch off for banking, switch on for coding!';

  // Privacy & Safety
  static String get privacyTitle =>
      isVietnamese ? 'Bảo mật & Quyền riêng tư' : 'Privacy & Security First';
  static String get privacyPoints => isVietnamese
      ? '✓ 100% Offline, không có quyền INTERNET\n✓ Không quảng cáo, không phân tích, không thu thập dữ liệu\n✓ Chỉ thay đổi 2 cài đặt: Developer Options và Gỡ lỗi USB\n✓ Mã nguồn mở và hoàn toàn minh bạch'
      : '✓ 100% Offline, zero INTERNET permissions\n✓ No ads, no analytics, no tracking\n✓ Modifies only Developer Options and USB Debugging settings\n✓ Open source & transparent';

  // Language & Theme
  static String get language => isVietnamese ? 'Ngôn ngữ' : 'Language';
  static String get theme => isVietnamese ? 'Giao diện' : 'Theme';
  static String get darkMode => isVietnamese ? 'Tối' : 'Dark';
  static String get lightMode => isVietnamese ? 'Sáng' : 'Light';
  static String get systemMode => isVietnamese ? 'Hệ thống' : 'System';
}
