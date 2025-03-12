import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // TODO: Implement user profile menu
        },
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.accentColor.withOpacity(0.2),
            border: Border.all(
              color: theme.accentColor,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.person_outline,
              size: 16,
              color: theme.accentColor,
            ),
          ),
        ),
      ),
    );
  }
}