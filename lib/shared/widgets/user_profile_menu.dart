import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';

class UserProfileMenu extends ConsumerWidget {
  const UserProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final user = ref.watch(userProvider);

    return PopupMenuButton<String>(
      offset: const Offset(0, 38),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: theme.sidebarColor,
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
          child: Text(
            user.name[0].toUpperCase(),
            style: TextStyle(
              color: theme.accentColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
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
                      child: Text(
                        user.name[0].toUpperCase(),
                        style: TextStyle(
                          color: theme.accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
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
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'profile',
          height: 36,
          child: Row(
            children: [
              Icon(Icons.account_circle_outlined, 
                size: 16, 
                color: theme.textSecondaryColor
              ),
              const SizedBox(width: 8),
              Text(
                'Profil',
                style: TextStyle(
                  color: theme.textPrimaryColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'settings',
          height: 36,
          child: Row(
            children: [
              Icon(Icons.settings_outlined, 
                size: 16, 
                color: theme.textSecondaryColor
              ),
              const SizedBox(width: 8),
              Text(
                'Ustawienia',
                style: TextStyle(
                  color: theme.textPrimaryColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'theme',
          height: 36,
          child: Row(
            children: [
              Icon(Icons.palette_outlined, 
                size: 16, 
                color: theme.textSecondaryColor
              ),
              const SizedBox(width: 8),
              Text(
                'Motyw',
                style: TextStyle(
                  color: theme.textPrimaryColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          height: 36,
          child: Row(
            children: [
              const Icon(Icons.logout_outlined, 
                size: 16, 
                color: Colors.redAccent
              ),
              const SizedBox(width: 8),
              Text(
                'Wyloguj',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (String value) {
        switch (value) {
          case 'profile':
            // TODO: Obsługa profilu
            break;
          case 'settings':
            // TODO: Obsługa ustawień
            break;
          case 'theme':
            // TODO: Obsługa zmiany motywu
            break;
          case 'logout':
            // TODO: Obsługa wylogowania
            break;
        }
      },
    );
  }
} 