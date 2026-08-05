// theme_controller.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Global theme controller
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

// Initialize theme from SharedPreferences
Future<void> setupTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final savedMode = prefs.getString('themeMode') ?? 'light';
  themeNotifier.value = savedMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
}

// Save theme preference
Future<void> saveThemeMode(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('themeMode', mode == ThemeMode.dark ? 'dark' : 'light');
  themeNotifier.value = mode;
}
