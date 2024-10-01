import 'dart:io' as io;

import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:funda/features/lots/data/services/funda_house_api_service.dart';
import 'package:http/http.dart' as http;

import '../api_typedefs.dart';
import '../converters/json_serializable_converter.dart';

class RestClient {
  static List<ChopperService> services = <ChopperService>[
    FundaHouseApiService.create(),
  ];
  static Map<Type, JsonFactory> factoryConverters = <Type, JsonFactory>{
    Unit: (json) => unit,
    String: (json) => json[''].toString(),
    ...FundaHouseApiService.factoryConverters(),
  };

  final Uri _rootUrl;

  final String _agentFlavor;
  late ChopperClient _client;

  final http.Client? _httpClient;

  /// listener call for when auth credentials change.
  void Function(String credentials)? onAuthUpdateListener;

  RestClient.build({
    required Uri rootUrl,
    required String agentFlavor,
    http.Client? httpClient,
  })  : _httpClient = httpClient,
        _rootUrl = rootUrl,
        _agentFlavor = agentFlavor;

  S fetchService<S extends ChopperService>() => _client.getService<S>();

  Map<Type, JsonFactory> _getFactoryConverters() => factoryConverters;

  Future<void> init() async {
    await _setupClient(root: _rootUrl);
  }

  Future<ChopperClient> _setupClient({
    required Uri root,
  }) async {
    final _services = services;

    final headerInterceptor = await _buildHeaderInterceptor();
    _client = ChopperClient(
      baseUrl: root,
      services: _services,
      client: _httpClient,
      interceptors: <dynamic>[
        headerInterceptor,
      ],
      converter: _converter,
      errorConverter: _converter,
    );

    return _client;
  }

  Future<HeadersInterceptor> _buildHeaderInterceptor() async {
    final type = io.Platform.operatingSystem;
    return HeadersInterceptor(
      {
        'User-Agent': 'Funda/$_agentFlavor)-($type)'.replaceAll(' ', ''),
      },
    );
  }

  JsonSerializableConverter get _converter => JsonSerializableConverter(
        _getFactoryConverters(),
      );

  void reassemble() {
    _setupClient(root: _rootUrl);
  }

  void dispose() {
    _client.dispose();
  }
}
