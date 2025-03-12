import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/providers/user_provider.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final user = ref.watch(userProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _showUserProfileMenu(context, ref, user);
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
            child: user.avatarUrl != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                user.avatarUrl!,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            )
                : Icon(
              Icons.person_outline,
              size: 16,
              color: theme.accentColor,
            ),
          ),
        ),
      ),
    );
  }

  void _showUserProfileMenu(BuildContext context, WidgetRef ref, user) {
    final theme = ref.watch(appThemeProvider);
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: theme.sidebarColor,
      items: [
        _buildUserInfoItem(theme, user),
        const PopupMenuItem(
          height: 1,
          padding: EdgeInsets.zero,
          child: Divider(),
        ),
        _buildMenuItem(
          theme,
          'Ustawienia profilu',
          Icons.settings_outlined,
              () {
            Navigator.pop(context);
            // TODO: Implementacja ustawień profilu
          },
        ),
        _buildMenuItem(
          theme,
          'Preferencje',
          Icons.tune_outlined,
              () {
            Navigator.pop(context);
            // TODO: Implementacja preferencji
          },
        ),
        _buildMenuItem(
          theme,
          'Motyw',
          Icons.palette_outlined,
              () {
            Navigator.pop(context);
            ref.read(appThemeProvider.notifier).toggleTheme();
          },
        ),
        const PopupMenuItem(
          height: 1,
          padding: EdgeInsets.zero,
          child: Divider(),
        ),
        _buildMenuItem(
          theme,
          'Wyloguj',
          Icons.logout_outlined,
              () {
            Navigator.pop(context);
            // TODO: Implementacja wylogowania
          },
          isDestructive: true,
        ),
      ],
    );
  }

  PopupMenuItem _buildUserInfoItem(AppThemeData theme, user) {
    return PopupMenuItem(
      enabled: false,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.accentColor.withOpacity(0.2),
                ),
                child: Center(
                  child: user.avatarUrl != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      user.avatarUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Icon(
                    Icons.person_outline,
                    size: 24,
                    color: theme.accentColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        color: theme.textPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email,
                      style: TextStyle(
                        color: theme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: theme.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              user.role,
              style: TextStyle(
                color: theme.accentColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildMenuItem(
      AppThemeData theme,
      String title,
      IconData icon,
      VoidCallback onTap, {
        bool isDestructive = false,
      }) {
    return PopupMenuItem(
      height: 40,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isDestructive ? Colors.redAccent : theme.textSecondaryColor,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: isDestructive ? Colors.redAccent : theme.textPrimaryColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
