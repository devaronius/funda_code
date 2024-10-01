import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

Future<Response> mockHttpHandler(Request request) async {
  final id = request.url.pathSegments.last;

  if (id == '6289a7bb-a1a8-40d5-bed1-bff3a5f62ee6') {
    final response = await _generateSuccess(id: id);
    return Response(
      json.encode(response),
      200,
    );
  } else {
    return Response(
      json.encode(<String, dynamic>{
        'itemMessage': '',
        'resultMessage': 'ItemNotFound',
      }),
      404,
    );
  }
}

Future<Map<String, dynamic>> _generateSuccess({
  required String id,
}) async {
  const filePath = 'assets/json/funda_lot_detail.json';
  final jsonString = await rootBundle.loadString(filePath);

  // prevent getting an immutable map
  final jsonValues = Map<String, dynamic>.of(
    json.decode(jsonString) as Map<String, dynamic>,
  );
  jsonValues['id'] = id;
  return jsonValues;
}
