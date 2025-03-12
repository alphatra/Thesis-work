import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_mode.dart';

class AppModeNotifier extends StateNotifier<AppMode> {
  AppModeNotifier() : super(AppMode.basic);

  void cycleMode() {
    state = state == AppMode.basic ? AppMode.experimental : AppMode.basic;
  }

  void setMode(AppMode mode) {
    state = mode;
  }
}

final appModeProvider = StateNotifierProvider<AppModeNotifier, AppMode>(
  (ref) => AppModeNotifier(),
);