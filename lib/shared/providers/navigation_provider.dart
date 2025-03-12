import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationRoute {
  home,
  data,
  reports,
  experimental,
}

class NavigationState {
  final NavigationRoute currentRoute;

  const NavigationState({
    this.currentRoute = NavigationRoute.home,
  });

  NavigationState copyWith({
    NavigationRoute? currentRoute,
  }) {
    return NavigationState(
      currentRoute: currentRoute ?? this.currentRoute,
    );
  }
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(const NavigationState());

  void navigateTo(NavigationRoute route) {
    state = state.copyWith(currentRoute: route);
  }
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});