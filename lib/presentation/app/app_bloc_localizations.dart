import 'package:flutter/material.dart';

class AppBlocLocalizations {
  static AppBlocLocalizations of(BuildContext context) {
    return Localizations.of<AppBlocLocalizations>(
      context,
      AppBlocLocalizations,
    );
  }
}
