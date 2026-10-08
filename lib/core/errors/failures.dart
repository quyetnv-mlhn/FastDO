abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class PlatformFailure extends Failure {
  final String? code;
  const PlatformFailure(super.message, {this.code});
}

class PermissionFailure extends Failure {
  const PermissionFailure(
      [super.message = 'WRITE_SECURE_SETTINGS permission denied']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred']);
}
