import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:funda/core/di/funda_di.dart';

import 'components/templates/lot_detail_template.dart';
import 'core/listeners/bloc_observer_listener.dart';
import 'gen/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = LogBlocObserver();
  await FundaDi.initApp();
  FlutterError.onError = (details) {
    FundaDi.logger.severe('FlutterError', details.exception, details.stack);
  };

  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    FundaDi.logger.severe('PlatformDispatcher', error, stack);
    return true;
  };

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        Strings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Strings.delegate.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          debugPrint('*language locale is null!!!');
          return supportedLocales.first;
        }
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const LotDetailTemplate(
        id: '6289a7bb-a1a8-40d5-bed1-bff3a5f62ee6',
      ),
    );
  }
}
