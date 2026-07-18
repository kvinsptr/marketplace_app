import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    loadTheme();
  }

  final Box settings = Hive.box('settings');

  void loadTheme() {
    final dark = settings.get('darkMode', defaultValue: false);

    state = dark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggle(bool value) {
    settings.put('darkMode', value);

    state = value ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);