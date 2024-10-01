import 'package:chopper/chopper.dart';

import 'failures.dart';

class ApiFailure<T extends Object> extends Failure {
  final Response<dynamic> response;
  final Map<String, dynamic>? json;

  const ApiFailure({
    required this.json,
    required this.response,
    required super.code,
    required super.stackTrace,
    super.exception,
  });

  factory ApiFailure.fromClient({
    required Map<String, dynamic>? json,
    required Response<dynamic> response,
    required StackTrace stackTrace,
    Exception? exception,
  }) {
    return ApiFailure(
      json: json,
      response: response,
      code: 'xxAF',
      stackTrace: stackTrace,
      exception: exception,
    );
  }
}

/// The generic [Failure] class for the [HttpStatus.notFound] and in used
/// in junction with the [ApiFailure] due to the same use of the data.
class NotFoundFailure extends ApiFailure {
  NotFoundFailure({
    required super.response,
    required super.stackTrace,
    super.code = 'NFAF',
    super.json = const {},
  });
}
