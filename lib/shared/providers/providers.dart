import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_theme.dart';
import '../models/navigation_state.dart';

// Scentralizowany plik z providerami dla lepszej organizacji i wydajności

final themeProvider = StateProvider<AppTheme>((ref) {
  return const AppTheme(
    contentBackgroundColor: Color(0xFF1E1E1E),
    sidebarColor: Color(0xFF252526),
    titleBarColor: Color(0xFF1A1A1A),
    textPrimaryColor: Colors.white,
    textSecondaryColor: Colors.white70,
    accentColor: Color(0xFF007ACC),
    buttonBackgroundColor: Color(0xFF2D2D2D),
    dividerColor: Color(0xFF333333),
  );
});

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(const NavigationState(currentRoute: NavigationRoute.home));

  void navigateTo(NavigationRoute route, {String? subRoute}) {
    state = state.copyWith(
      currentRoute: route,
      selectedSubRoute: subRoute,
    );
  }

  void toggleSidebar() {
    state = state.copyWith(isSidebarExpanded: !state.isSidebarExpanded);
  }
}

@riverpod
class AppMode extends _$AppMode {
  @override
  AppModeState build() {
    return const AppModeState(mode: AppMode.basic);
  }

  void setMode(AppMode mode) {
    state = state.copyWith(mode: mode);
  }
} 