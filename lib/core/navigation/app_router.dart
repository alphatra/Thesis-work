import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationRoute {
  home,
  data,
  reports,
  experimental;

  String get title {
    switch (this) {
      case NavigationRoute.home:
        return 'Strona Główna';
      case NavigationRoute.data:
        return 'Dane';
      case NavigationRoute.reports:
        return 'Raporty';
      case NavigationRoute.experimental:
        return 'Eksperymentalne';
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationRoute.home:
        return Icons.home_outlined;
      case NavigationRoute.data:
        return Icons.folder_outlined;
      case NavigationRoute.reports:
        return Icons.description_outlined;
      case NavigationRoute.experimental:
        return Icons.science_outlined;
    }
  }
}

class NavigationState {
  final NavigationRoute currentRoute;
  final String? selectedSubRoute;
  final bool isSidebarExpanded;

  const NavigationState({
    required this.currentRoute,
    this.selectedSubRoute,
    this.isSidebarExpanded = true,
  });

  NavigationState copyWith({
    NavigationRoute? currentRoute,
    String? selectedSubRoute,
    bool? isSidebarExpanded,
  }) {
    return NavigationState(
      currentRoute: currentRoute ?? this.currentRoute,
      selectedSubRoute: selectedSubRoute ?? this.selectedSubRoute,
      isSidebarExpanded: isSidebarExpanded ?? this.isSidebarExpanded,
    );
  }
}

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

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>(
  (ref) => NavigationNotifier(),
);