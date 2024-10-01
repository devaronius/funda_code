class Failure {
  final StackTrace stackTrace;
  final Exception? exception;

  /// failure code for easy identification
  final String? code;

  const Failure({required this.stackTrace, this.exception, this.code});
}
