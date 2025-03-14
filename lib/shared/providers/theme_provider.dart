import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme {
  final Color contentBackgroundColor;
  final Color sidebarColor;
  final Color titleBarColor;
  final Color titleBarTextColor;
  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color accentColor;
  final Color buttonBackgroundColor;
  final Color dividerColor;

  const AppTheme({
    required this.contentBackgroundColor,
    required this.sidebarColor,
    required this.titleBarColor,
    required this.titleBarTextColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.accentColor,
    required this.buttonBackgroundColor,
    required this.dividerColor,
  });
}

final appThemeProvider = Provider<AppTheme>((ref) {
  return const AppTheme(
    contentBackgroundColor: Color(0xFF1E1E1E),
    sidebarColor: Color(0xFF252526),
    titleBarColor: Color(0xFF1A1A1A),
    titleBarTextColor: Colors.white,
    textPrimaryColor: Colors.white,
    textSecondaryColor: Colors.white70,
    accentColor: Color(0xFF007ACC),
    buttonBackgroundColor: Color(0xFF2D2D2D),
    dividerColor: Color(0xFF333333),
  );
});