// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Strings {
  Strings();

  static Strings? _current;

  static Strings get current {
    assert(_current != null,
        'No instance of Strings was loaded. Try to initialize the Strings delegate before accessing Strings.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Strings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Strings();
      Strings._current = instance;

      return instance;
    });
  }

  static Strings of(BuildContext context) {
    final instance = Strings.maybeOf(context);
    assert(instance != null,
        'No instance of Strings present in the widget tree. Did you add Strings.delegate in localizationsDelegates?');
    return instance!;
  }

  static Strings? maybeOf(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  /// `Kavel wordt geladen...`
  String get lotFetchingData {
    return Intl.message(
      'Kavel wordt geladen...',
      name: 'lotFetchingData',
      desc: '',
      args: [],
    );
  }

  /// `Omschrijving`
  String get lotDescriptionTitle {
    return Intl.message(
      'Omschrijving',
      name: 'lotDescriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Kenmerken`
  String get lotFeaturesTitle {
    return Intl.message(
      'Kenmerken',
      name: 'lotFeaturesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Vraagprijs per m2`
  String get lotFeatureAskingPricePerSquareMeter {
    return Intl.message(
      'Vraagprijs per m2',
      name: 'lotFeatureAskingPricePerSquareMeter',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get lotFeatureStatus {
    return Intl.message(
      'Status',
      name: 'lotFeatureStatus',
      desc: '',
      args: [],
    );
  }

  /// `Aanvaarding`
  String get lotFeatureAcceptance {
    return Intl.message(
      'Aanvaarding',
      name: 'lotFeatureAcceptance',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Strings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'nl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
