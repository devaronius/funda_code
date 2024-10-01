import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:funda/core/di/funda_di.dart';

import '../../../failures/api_failures.dart';
import '../api_typedefs.dart';

class JsonSerializableConverter extends JsonConverter {
  final Map<Type, JsonFactory> factories;

  JsonSerializableConverter(this.factories) {
    _addFactory<Map<String, String>>(_decodeStringStringMap);
  }

  void _addFactory<T>(JsonFactory<T> f) {
    factories[T] = f;
  }

  /// send the request raw back. the super class [JsonConverter.encodeJson]
  /// wants to [encodeJson]
  /// the request what is not valid for our own server.
  @override
  // all objects should implements toJson method
  Request convertRequest(Request request) => super.convertRequest(request);

  /// override on [encodeJson] to clear out any null body values.
  @override
  Request encodeJson(Request request) {
    final contentType = request.headers[contentTypeKey];

    final dynamic body = request.body;
    if (body is Map) {
      body.removeWhere((dynamic key, dynamic value) => value == null);
    }

    return (contentType?.contains(jsonHeaders) ?? false)
        ? request.copyWith(body: json.encode(body))
        : request;
  }

  Map<String, String> _decodeStringStringMap(Map<String, dynamic> json) =>
      json.cast<String, String>();

  dynamic _decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }
    return (entity is Map<String, dynamic>)
        ? _decodeMap<T>(entity)
        : _decodeNonJson<T>(entity);
  }

  List<T> _decodeList<T>(Iterable values) => values
      .where((dynamic v) => v != null)
      .map<T>((dynamic v) => _decode<T>(v) as T)
      .toList();

  /// Decoding responses that are not proper json responses.
  /// Mostly these would be empty or simple [String] messages.
  ///
  /// in case the return type is not a [String] we offer here a way to still
  /// try to covert the response to the given type.
  T? _decodeNonJson<T>(dynamic entity) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      // throw serializer not found error;
      return null;
    }
    return jsonFactory(<String, dynamic>{'': entity});
  }

  /// Get jsonFactory using Type parameters
  /// if not found or invalid, throw error or return null
  T? _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      // throw serializer not found error;
      return null;
    }
    return jsonFactory(values);
  }

  @override
  FutureOr<dynamic> tryDecodeJson(String data) {
    if (data.isEmpty) {
      FundaDi.logger.fine(
        'json_serializable_converter: Given response body was empty',
      );
      return data;
    }
    try {
      return json.decode(data);
    } catch (e) {
      FundaDi.logger.fine(
        'json_serializable_converter: given response '
        'could not be json decoded',
      );
      FundaDi.logger.fine(
        'json_serializable_converter: original data: $data',
      );
      FundaDi.logger.fine(e);

      return data;
    }
  }

  /// convert the response [Map]<[dynamic],[dynamic]> to TypeSafe classes given in [ResultType]
  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(
    Response response,
  ) async {
    if (response.statusCode == HttpStatus.noContent &&
        isTypeOf<ResultType, List>()) {
      return response.copyWith<List<Item>>(body: []) as Response<ResultType>;
    }
    if (isTypeOf<ResultType, String>()) {
      return response.copyWith<String>(body: response.bodyString)
          as Response<ResultType>;
    }

    if (isTypeOf<ResultType, Unit>()) {
      return response.copyWith<Unit>(body: unit) as Response<ResultType>;
    }

    // use [JsonConverter] to decode json
    final jsonRes = await super.convertResponse<dynamic, dynamic>(response);
    if (jsonRes.body == 'null') {
      return Response<ResultType>(jsonRes.base, null);
    }

    return jsonRes.copyWith<ResultType>(
      body: _decode<Item>(jsonRes.body) as ResultType,
    );
  }

  /// converts error [Response] values to [ApiFailure] responses.
  @override
  FutureOr<Response> convertError<ResultType, Item>(Response response) async {
    // use [JsonConverter] to decode json
    final jsonRes = await super.convertError<dynamic, dynamic>(response);

    try {
      return response.copyWith<ApiFailure>(
        body: ApiFailure.fromClient(
          json: jsonRes.body as Map<String, dynamic>?,
          response: response,
          stackTrace: StackTrace.empty,
        ),
      );
    }
    // ignore_for_file: avoid_catching_errors
    on TypeError catch (_, __) {
      return jsonRes.copyWith<ApiFailure>(
        body: ApiFailure.fromClient(
          json: <String, dynamic>{'Message': jsonRes.body},
          response: response,
          stackTrace: StackTrace.empty,
        ),
      );
    } on Exception catch (exception, stack) {
      return jsonRes.copyWith<ApiFailure>(
        body: ApiFailure.fromClient(
          json: const <String, dynamic>{},
          stackTrace: stack,
          response: response,
          exception: exception,
        ),
      );
    } catch (_, stack) {
      return jsonRes.copyWith<ApiFailure>(
        body: ApiFailure.fromClient(
          json: const <String, dynamic>{},
          stackTrace: stack,
          response: response,
        ),
      );
    }
  }
}
