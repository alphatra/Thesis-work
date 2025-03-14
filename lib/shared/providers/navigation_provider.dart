import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/navigation/app_router.dart';

// Re-export the NavigationState and NavigationRoute for convenience
export '../../core/navigation/app_router.dart' show NavigationState, NavigationRoute;

// Navigation provider
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});
