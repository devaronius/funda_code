import 'package:flutter/foundation.dart';
import 'package:funda/core/data/api/client/rest_client.dart';
import 'package:funda/features/lots/blocs/bloc/lot_detail_bloc.dart';
import 'package:funda/features/lots/data/repository/funda_house_repository_impl.dart';
import 'package:funda/features/lots/data/services/funda_house_api_service.dart';
import 'package:funda/features/lots/domain/repository/funda_house_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/testing.dart';
import 'package:logging/logging.dart';

import '../data/api/client/fake_http_client.dart';

/// Dependency injection class to handle all factory and singleton
/// creation logic.
class FundaDi {
  static Logger logger = Logger('funda');

  static Future<void> initApp() async {
    final di = GetIt.instance;

    await initServices(di);
    initRepositories(di);
    initBlocs(di);
    setupLogging();
    await GetIt.I.allReady();
  }

  static void initBlocs(GetIt di) {
    di.registerFactory<LotDetailBloc>(() => LotDetailBloc(
          repository: di<FundaHouseRepository>(),
        ));
  }

  static Future<void> initServices(GetIt di) async {
    // due to the 401 issue with the api, i've included a mock client
    // to reproduce the idea of the application communicating with a backend.
    di.registerSingletonAsync<RestClient>(() async {
      final client = RestClient.build(
        rootUrl: Uri.parse('http://partnerapi.funda.nl/'),
        agentFlavor: 'internal',
        httpClient: MockClient(mockHttpHandler),
      );
      await client.init();
      return client;
    });
    di.registerFactory<FundaHouseApiService>(
      () => di<RestClient>().fetchService<FundaHouseApiService>(),
    );
  }

  static void initRepositories(GetIt di) {
    di.registerFactory<FundaHouseRepository>(
      () => FundaHouseRepositoryImpl(
        houseService: di<FundaHouseApiService>(),
      ),
    );
  }

  static void setupLogging() {
    Logger.root.onRecord.listen((record) {
      final buffer = StringBuffer();
      buffer.write('${record.time} - ');
      buffer.write('${record.level} - ');
      buffer.write('${record.loggerName} -');
      if (record.message.isNotEmpty) {
        buffer.write(' ${record.message}');
      }
      if (record.error != null) {
        buffer.write(' - Error details: ${record.error.toString()}');
      }
      if (record.stackTrace != null) {
        buffer.write(' - Stacktrace: ${record.stackTrace.toString()}');
      }
      debugPrint(buffer.toString());
    });
  }
}
