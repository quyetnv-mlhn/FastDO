.PHONY: all init setup get gen watch l10n format fix analyze test check clean run build-apk build-aab grant-adb help

# Colors for terminal output
CYAN  := \033[0;36m
GREEN := \033[0;32m
YELLOW:= \033[0;33m
RED   := \033[0;31m
NC    := \033[0m # No Color

## Default Target: Display help menu
help:
	@echo "$(CYAN)==================================================================$(NC)"
	@echo "$(GREEN)⚡ FastDO - Flutter All-in-One Development Makefile$(NC)"
	@echo "$(CYAN)==================================================================$(NC)"
	@echo "🔥 $(YELLOW)ALL-IN-ONE COMMANDS:$(NC)"
	@echo "  $(GREEN)make all$(NC)          🔥 Chạy toàn bộ thiết lập + sinh code + kiểm thử (Khuyên dùng)"
	@echo "  $(GREEN)make init$(NC)         🚀 Khởi tạo dự án từ đầu (clean + setup + check)"
	@echo "  $(GREEN)make dev$(NC)          🚀 Chạy toàn bộ thiết lập và khởi động ứng dụng (all + run)"
	@echo ""
	@echo "📦 $(YELLOW)INDIVIDUAL COMMANDS:$(NC)"
	@echo "  $(YELLOW)make setup$(NC)        Install packages & generate all code"
	@echo "  $(YELLOW)make get$(NC)          Run 'fvm flutter pub get'"
	@echo "  $(YELLOW)make gen$(NC)          Generate L10n & run build_runner"
	@echo "  $(YELLOW)make watch$(NC)        Watch & rebuild code continuously"
	@echo "  $(YELLOW)make l10n$(NC)         Generate localization files only"
	@echo "  $(YELLOW)make format$(NC)       Format Dart code (fvm dart format .)"
	@echo "  $(YELLOW)make fix$(NC)          Apply Dart automated fixes"
	@echo "  $(YELLOW)make analyze$(NC)      Run static analysis (fvm flutter analyze)"
	@echo "  $(YELLOW)make test$(NC)         Run all tests (fvm flutter test)"
	@echo "  $(YELLOW)make check$(NC)        Full verification (format + fix + analyze + test)"
	@echo "  $(YELLOW)make clean$(NC)        Clean build cache and reinstall"
	@echo "  $(YELLOW)make run$(NC)          Run app on connected device"
	@echo "  $(YELLOW)make build-apk$(NC)    Build Android Release APK"
	@echo "  $(YELLOW)make build-aab$(NC)    Build Android App Bundle for Store"
	@echo "  $(YELLOW)make grant-adb$(NC)    Grant WRITE_SECURE_SETTINGS via ADB"
	@echo "$(CYAN)==================================================================$(NC)"

## 🔥 ALL-IN-ONE: Dọn sạch cache + cài đặt + sinh mã + kiểm thử toàn diện
all: clean get gen format analyze test
	@echo "\n$(GREEN)==================================================================$(NC)"
	@echo "$(GREEN)🎉 HOÀN TẤT TOÀN BỘ CÀI ĐẶT & KIỂM THỬ THÀNH CÔNG!$(NC)"
	@echo "$(GREEN)==================================================================$(NC)"

## 🚀 INIT: Khởi tạo dự án từ đầu (clean + setup + check)
init: clean setup check
	@echo "\n$(GREEN)==================================================================$(NC)"
	@echo "$(GREEN)🎉 KHỞI TẠO DỰ ÁN THÀNH CÔNG! SẴN SÀNG PHÁT TRIỂN.$(NC)"
	@echo "$(GREEN)==================================================================$(NC)"

## 🚀 DEV: Dọn dẹp, sinh code, kiểm tra và khởi chạy app trên thiết bị
dev: all run

## Setup dependencies and generated code
setup: get gen

## Install dependencies
get:
	@echo "\n$(GREEN)📦 [1/5] Cài đặt dependencies (fvm flutter pub get)...$(NC)"
	fvm flutter pub get

## Generate localization and build_runner outputs (Freezed, Injectable)
gen: l10n
	@echo "\n$(GREEN)🔨 [3/5] Sinh mã nguồn Freezed & Dependency Injection...$(NC)"
	fvm dart run build_runner build --delete-conflicting-outputs

## Watch build_runner
watch:
	@echo "\n$(GREEN)👀 Đang theo dõi thay đổi file để tự động sinh mã...$(NC)"
	fvm dart run build_runner watch --delete-conflicting-outputs

## Generate Localization files
l10n:
	@echo "\n$(GREEN)🌐 [2/5] Sinh file đa ngôn ngữ (L10n ARB)...$(NC)"
	fvm flutter gen-l10n

## Format Dart code
format:
	@echo "\n$(GREEN)🎨 [4/5] Định dạng mã nguồn Dart...$(NC)"
	fvm dart format .

## Fix Dart lints
fix:
	@echo "\n$(GREEN)🔧 Áp dụng tự động sửa lỗi cú pháp...$(NC)"
	fvm dart fix --apply

## Analyze code
analyze:
	@echo "\n$(GREEN)🔍 [5/5] Kiểm tra tĩnh toàn bộ mã nguồn (Analyze)...$(NC)"
	fvm flutter analyze

## Run unit & widget tests
test:
	@echo "\n$(GREEN)🧪 Chạy bộ kiểm thử tự động (Unit & Widget Tests)...$(NC)"
	fvm flutter test

## Full verification pipeline
check: fix format analyze test
	@echo "\n$(GREEN)✅ Đã vượt qua toàn bộ các bước kiểm tra chất lượng!$(NC)"

## Clean project & build cache
clean:
	@echo "\n$(YELLOW)🧹 [0/5] Dọn sạch toàn bộ cache build và artifact cũ...$(NC)"
	fvm flutter clean
	rm -rf .dart_tool/build

## Run Flutter application
run:
	@echo "\n$(GREEN)🚀 Khởi chạy ứng dụng FastDO trên thiết bị...$(NC)"
	fvm flutter run

## Build Android Release APK (Clean + Gen + Build)
build-apk: clean get gen
	@echo "\n$(GREEN)📱 Đang build file Release APK...$(NC)"
	fvm flutter build apk --release
	@echo "\n$(GREEN)✅ File APK đã được tạo tại: build/app/outputs/flutter-apk/app-release.apk$(NC)"

## Build Android App Bundle (Clean + Gen + Build)
build-aab: clean get gen
	@echo "\n$(GREEN)📦 Đang build file Release App Bundle (.aab)...$(NC)"
	fvm flutter build appbundle --release
	@echo "\n$(GREEN)✅ File AAB đã được tạo tại: build/app/outputs/bundle/release/app-release.aab$(NC)"

## Grant WRITE_SECURE_SETTINGS via ADB
grant-adb:
	@echo "\n$(GREEN)🔑 Đang cấp quyền WRITE_SECURE_SETTINGS cho com.quyetnv.fastdo qua ADB...$(NC)"
	adb shell pm grant com.quyetnv.fastdo android.permission.WRITE_SECURE_SETTINGS
	@echo "\n$(GREEN)✅ Cấp quyền thành công!$(NC)"
