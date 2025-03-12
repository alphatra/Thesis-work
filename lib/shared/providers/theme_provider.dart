import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme {
  final Color contentBackgroundColor;
  final Color sidebarColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color accentColor;

  const AppTheme({
    required this.contentBackgroundColor,
    required this.sidebarColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.accentColor,
  });
}

final appThemeProvider = Provider<AppTheme>((ref) {
  return AppTheme(
    contentBackgroundColor: const Color(0xFF1E1E1E),
    sidebarColor: const Color(0xFF252526),
    textPrimaryColor: Colors.white,
    textSecondaryColor: Colors.white70,
    accentColor: const Color(0xFF007ACC),
  );
});