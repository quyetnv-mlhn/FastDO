class DevSettingsState {
  final bool hasPermission;
  final bool isDevOptionsEnabled;
  final bool isUsbDebuggingEnabled;
  final bool isRootAvailable;
  final bool isLoading;
  final String? errorMessage;

  const DevSettingsState({
    this.hasPermission = false,
    this.isDevOptionsEnabled = false,
    this.isUsbDebuggingEnabled = false,
    this.isRootAvailable = false,
    this.isLoading = true,
    this.errorMessage,
  });

  DevSettingsState copyWith({
    bool? hasPermission,
    bool? isDevOptionsEnabled,
    bool? isUsbDebuggingEnabled,
    bool? isRootAvailable,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DevSettingsState(
      hasPermission: hasPermission ?? this.hasPermission,
      isDevOptionsEnabled: isDevOptionsEnabled ?? this.isDevOptionsEnabled,
      isUsbDebuggingEnabled:
          isUsbDebuggingEnabled ?? this.isUsbDebuggingEnabled,
      isRootAvailable: isRootAvailable ?? this.isRootAvailable,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
