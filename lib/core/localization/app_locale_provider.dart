import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('id')) {
    loadLocale();
  }

  final Box settings = Hive.box('settings');

  void loadLocale() {
    final code = settings.get('language', defaultValue: 'id');
    state = Locale(code);
  }

  void changeLanguage(String code) {
    settings.put('language', code);
    state = Locale(code);
  }
}

final localeProvider =
    StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);