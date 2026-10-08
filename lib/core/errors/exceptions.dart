class PlatformExceptionWrapper implements Exception {
  final String message;
  final String? code;
  const PlatformExceptionWrapper(this.message, {this.code});

  @override
  String toString() => 'PlatformExceptionWrapper($code): $message';
}

class PermissionDeniedException implements Exception {
  final String message;
  const PermissionDeniedException([this.message = 'Permission denied']);

  @override
  String toString() => 'PermissionDeniedException: $message';
}
