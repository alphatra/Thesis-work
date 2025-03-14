import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../models/navigation_state.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final navigation = ref.watch(navigationProvider);

    return Container(
      color: theme.sidebarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (navigation.isSidebarExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'NAWIGACJA',
                style: TextStyle(
                  color: theme.textSecondaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          Expanded(
            child: ListView(
              children: NavigationRoute.values.map((route) {
                final isSelected = navigation.currentRoute == route;
                return _buildNavigationItem(
                  ref,
                  route,
                  isSelected,
                  navigation.isSidebarExpanded,
                  theme,
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: theme.dividerColor),
              ),
            ),
            child: IconButton(
              icon: Icon(
                navigation.isSidebarExpanded 
                    ? Icons.chevron_left 
                    : Icons.chevron_right,
                color: theme.textSecondaryColor,
                size: 20,
              ),
              onPressed: () => ref.read(navigationProvider.notifier).toggleSidebar(),
              tooltip: navigation.isSidebarExpanded 
                  ? 'Zwiń menu' 
                  : 'Rozwiń menu',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(
    WidgetRef ref,
    NavigationRoute route,
    bool isSelected,
    bool isExpanded,
    AppTheme theme,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isExpanded ? 4 : 6,
        vertical: 2,
      ),
      child: InkWell(
        onTap: () => ref.read(navigationProvider.notifier).navigateTo(route),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isExpanded ? 12 : 8,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isSelected 
                ? theme.accentColor.withOpacity(0.1) 
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                route.icon,
                size: 20,
                color: isSelected 
                    ? theme.accentColor 
                    : theme.textSecondaryColor,
              ),
              if (isExpanded) ...[
                const SizedBox(width: 12),
                Text(
                  route.title,
                  style: TextStyle(
                    color: isSelected 
                        ? theme.accentColor 
                        : theme.textPrimaryColor,
                    fontSize: 13,
                    fontWeight: isSelected 
                        ? FontWeight.w500 
                        : FontWeight.normal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
} 