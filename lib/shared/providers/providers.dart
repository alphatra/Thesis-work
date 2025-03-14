import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../core/navigation/app_router.dart';
import '../shared/models/app_mode.dart';

// Theme provider
final themeProvider = StateNotifierProvider<AppThemeNotifier, AppThemeData>(
      (ref) => AppThemeNotifier(),
);

// Navigation provider
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>(
      (ref) => NavigationNotifier(),
);

// App mode provider
class AppModeNotifier extends StateNotifier<AppMode> {
  AppModeNotifier() : super(AppMode.basic);

  void toggleMode() {
    state = state == AppMode.basic ? AppMode.experimental : AppMode.basic;
  }
}

final appModeProvider = StateNotifierProvider<AppModeNotifier, AppMode>(
      (ref) => AppModeNotifier(),
);
