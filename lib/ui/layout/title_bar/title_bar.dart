import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/services/window_service.dart';
import 'search_field.dart';
import 'mode_selector.dart';
import 'user_profile.dart';

class TitleBar extends ConsumerWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return GestureDetector(
      onPanStart: (_) => WindowService.startDragging(),
      child: Container(
        height: 38,
        color: theme.titleBarColor,
        child: Row(
          children: [
            // Logo and app name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.code,
                    size: 16,
                    color: theme.textSecondaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Your App',
                    style: TextStyle(
                      color: theme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // Search field
            const Expanded(
              child: Center(
                child: SearchField(),
              ),
            ),
            
            // Mode selector
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ModeSelector(),
            ),

            // Settings button
            IconButton(
              icon: Icon(
                Icons.settings_outlined,
                size: 16,
                color: theme.textSecondaryColor,
              ),
              onPressed: () {
                // TODO: Implement settings dialog
              },
              tooltip: 'Ustawienia',
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
              splashRadius: 16,
            ),
            
            // User profile
            const Padding(
              padding: EdgeInsets.only(left: 4, right: 12),
              child: UserProfile(),
            ),
          ],
        ),
      ),
    );
  }
}