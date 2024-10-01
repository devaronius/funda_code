import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funda/core/di/funda_di.dart';

class LogBlocObserver extends BlocObserver {
  LogBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    final message =
        // ignore: avoid_dynamic_calls
        '${bloc.runtimeType}: state ${change.nextState.runtimeType}';
    FundaDi.logger.fine(message);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    FundaDi.logger.fine('Error occurred in bloc ${bloc.runtimeType}');
    FundaDi.logger.severe('', error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    final message = '${bloc.runtimeType}: event ${event?.runtimeType}';
    FundaDi.logger.fine(message);
  }
}
