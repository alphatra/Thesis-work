import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';

class WindowService {
  static Future<void> initWindow() async {
    await windowManager.ensureInitialized();
    
    const windowOptions = WindowOptions(
      size: Size(1200, 700),
      center: true,
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.hidden,
      minimumSize: Size(800, 600),
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  static void startDragging() {
    windowManager.startDragging();
  }

  static Future<void> closeWindow() async {
    await windowManager.close();
  }

  static Future<void> minimizeWindow() async {
    await windowManager.minimize();
  }

  static Future<void> maximizeOrRestoreWindow() async {
    final isMaximized = await windowManager.isMaximized();
    if (isMaximized) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }
}