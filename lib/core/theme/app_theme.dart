import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppThemeData {
  final Color titleBarColor;
  final Color searchBackgroundColor;
  final Color sidebarColor;
  final Color contentBackgroundColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color accentColor;
  final Color buttonBackgroundColor;
  final Color dividerColor;

  const AppThemeData({
    required this.titleBarColor,
    required this.searchBackgroundColor,
    required this.sidebarColor,
    required this.contentBackgroundColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.accentColor,
    required this.buttonBackgroundColor,
    required this.dividerColor,
  });

  factory AppThemeData.dark() => const AppThemeData(
    titleBarColor: Color(0xFF1E1E1E),
    searchBackgroundColor: Color(0xFF3C3C3C),
    sidebarColor: Color(0xFF252526),
    contentBackgroundColor: Color(0xFF1E1E1E),
    textPrimaryColor: Colors.white,
    textSecondaryColor: Colors.white70,
    accentColor: Color(0xFF007ACC),
    buttonBackgroundColor: Color(0xFF2D2D2D),
    dividerColor: Color(0xFF333333),
  );

  factory AppThemeData.light() => const AppThemeData(
    titleBarColor: Color(0xFFF3F3F3),
    searchBackgroundColor: Colors.white,
    sidebarColor: Color(0xFFEEEEEE),
    contentBackgroundColor: Colors.white,
    textPrimaryColor: Colors.black87,
    textSecondaryColor: Colors.black54,
    accentColor: Color(0xFF0066B8),
    buttonBackgroundColor: Colors.white,
    dividerColor: Color(0xFFE0E0E0),
  );
}

class AppThemeNotifier extends StateNotifier<AppThemeData> {
  AppThemeNotifier() : super(AppThemeData.dark());

  void toggleTheme() {
    state = state.titleBarColor == const Color(0xFF1E1E1E)
        ? AppThemeData.light()
        : AppThemeData.dark();
  }
}

final appThemeProvider = StateNotifierProvider<AppThemeNotifier, AppThemeData>(
  (ref) => AppThemeNotifier(),
);