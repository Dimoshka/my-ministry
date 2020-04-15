import 'package:flutter/material.dart';

import 'app_bloc_localizations.dart';

class AppBlocLocalizationsDelegate
    extends LocalizationsDelegate<AppBlocLocalizations> {
  @override
  Future<AppBlocLocalizations> load(Locale locale) =>
      Future(() => AppBlocLocalizations());

  @override
  bool shouldReload(AppBlocLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains('en');
}
