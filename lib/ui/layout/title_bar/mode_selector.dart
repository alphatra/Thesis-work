import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/models/app_mode.dart';
import '../../../shared/providers/app_mode_provider.dart';

class ModeSelector extends ConsumerWidget {
  const ModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final currentMode = ref.watch(appModeProvider);

    return PopupMenuButton<AppMode>(
      offset: const Offset(0, 38),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: theme.sidebarColor,
      onSelected: (AppMode mode) {
        ref.read(appModeProvider.notifier).cycleMode();
      },
      itemBuilder: (context) => AppMode.values.map((mode) => 
        PopupMenuItem<AppMode>(
          value: mode,
          height: 32,
          child: Row(
            children: [
              Icon(
                mode.icon,
                size: 14,
                color: mode == currentMode 
                    ? theme.accentColor 
                    : theme.textSecondaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                mode.displayName,
                style: TextStyle(
                  fontSize: 12,
                  color: mode == currentMode 
                      ? theme.accentColor 
                      : theme.textPrimaryColor,
                  fontWeight: mode == currentMode 
                      ? FontWeight.w500 
                      : FontWeight.normal,
                ),
              ),
              if (mode == currentMode) ...[
                const Spacer(),
                Icon(
                  Icons.check,
                  size: 14,
                  color: theme.accentColor,
                ),
              ],
            ],
          ),
        ),
      ).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: theme.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: theme.dividerColor, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              currentMode.icon,
              size: 14,
              color: theme.textSecondaryColor,
            ),
            const SizedBox(width: 6),
            Text(
              currentMode.displayName,
              style: TextStyle(
                color: theme.textSecondaryColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 14,
              color: theme.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}