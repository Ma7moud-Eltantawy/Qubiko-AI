import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  late Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<void> load() async {
    try {
      print(locale);
      // If locale is not set, use the default locale
      locale = locale ?? Locale('en', 'US');
      print(locale);

      // Load the localization file based on the language code
      String jsonString = await rootBundle.loadString('assets/langs/${locale}.json');

      // Use the full locale to differentiate between variants (e.g., 'ar_EG')
      // Adjust this if your localization files follow a different pattern
      String jsonStringWithVariant = await rootBundle.loadString('assets/langs/${locale.toString()}.json');

      // Use the non-variant version if the variant-specific one is not found
      jsonString = jsonStringWithVariant.isNotEmpty ? jsonStringWithVariant : jsonString;

      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = Map<String, String>.from(jsonMap.cast<String, dynamic>());
    } catch (e) {
      print('Error loading localization: $e');
      throw Exception('Failed to load localization data for ${locale.languageCode}');
    }
  }

  String translate(String key) {
    final normalizedKey = key.toLowerCase();
    final translation = _localizedStrings[normalizedKey];
    return translation ?? 'KeyNotFound: $key';
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include support for the Arabic (Egypt) locale
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Locale get fallbackLocale => const Locale('en', 'US');

  @override
  Future<AppLocalizations> load(Locale locale) async {
    if (!isSupported(locale)) {
      print(locale);
      // If the locale is not supported, fallback to the default locale
      locale = fallbackLocale;
      print(locale);
    }

    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}