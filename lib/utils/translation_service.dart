import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_connect/utils/app_constants.dart';
import 'package:lets_connect/utils/shared_pref_utils.dart';

class TranslationService {
  Locale? _locale;
  Map<dynamic, dynamic>? _localizedValues;

  ///
  /// Returns the translation that corresponds to the [key]
  ///
  String? text(String key) {
  // Return the requested string
    return (_localizedValues == null || _localizedValues![key] == null)
        ? '** $key not found'
        : _localizedValues![key];
  }

  ///
  /// One-time initialization
  ///
  Future init([String? language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  ///
  /// Routine to change the language
  ///
  Future<void> setNewLanguage([String? newLanguage, bool saveInPrefs = false]) async {
    var language = newLanguage ?? await SharedPrefUtils().getValue(key: SharedPrefKey.locale);
    if (language == null || language == '') {
      language = StringConstants.englishLocale;
    }

    var languageFile = language.toLowerCase();

    _locale = Locale(language, "");
    
    // Load the language strings
    var jsonContent = await rootBundle
        .loadString('assets/locale/i18n_$languageFile.json');
    _localizedValues = json.decode(jsonContent);
    return;
  }

  ///
  /// Singleton Object
  ///
  static final TranslationService _translations = TranslationService._internal();
  factory TranslationService() {
    return _translations;
  }
  TranslationService._internal();
}

TranslationService translationService = TranslationService();