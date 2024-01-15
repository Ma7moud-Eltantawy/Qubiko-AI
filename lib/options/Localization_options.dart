import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  late Locale locale;
  late Map<String, dynamic> _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<void> load() async {
    try {
      // If locale is not set, use the default locale
      locale = locale ?? const Locale('en', 'US');

      // Load the localization file based on the language code
      String jsonString = await rootBundle.loadString('assets/langs/${locale}.json');

      // Use the full locale to differentiate between variants (e.g., 'ar_EG')
      // Adjust this if your localization files follow a different pattern
      String jsonStringWithVariant = await rootBundle.loadString('assets/langs/${locale.toString()}.json');

      // Use the non-variant version if the variant-specific one is not found
      jsonString = jsonStringWithVariant.isNotEmpty ? jsonStringWithVariant : jsonString;

      // Adjust the path to the nested structure of your JSON
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = Map<String, dynamic>.from(jsonMap.cast<String, dynamic>());
    } catch (e) {
      print('Error loading localization: $e');
      throw Exception('Failed to load localization data for ${locale.languageCode}');
    }
  }

  String translate(String collection, String key) {
    final normalizedKey = key.toLowerCase();
    final translation = _localizedStrings[collection][normalizedKey];

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
      // If the locale is not supported, fallback to the default locale
      locale = fallbackLocale;
    }

    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}