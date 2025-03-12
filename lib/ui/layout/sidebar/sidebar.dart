import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/navigation/app_router.dart';
import 'sidebar_item.dart';
import 'sidebar_section.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final navigation = ref.watch(navigationProvider);
    final navigationNotifier = ref.read(navigationProvider.notifier);

    return Container(
      color: theme.sidebarColor,
      child: Column(
        children: [
          SidebarSection(
            title: navigation.isSidebarExpanded ? 'NAWIGACJA' : '',
            children: [
              SidebarItem(
                route: NavigationRoute.home,
                isExpanded: navigation.isSidebarExpanded,
                isSelected: navigation.currentRoute == NavigationRoute.home,
                onTap: () => navigationNotifier.navigateTo(NavigationRoute.home),
              ),
              SidebarItem(
                route: NavigationRoute.data,
                isExpanded: navigation.isSidebarExpanded,
                isSelected: navigation.currentRoute == NavigationRoute.data,
                onTap: () => navigationNotifier.navigateTo(NavigationRoute.data),
              ),
              SidebarItem(
                route: NavigationRoute.reports,
                isExpanded: navigation.isSidebarExpanded,
                isSelected: navigation.currentRoute == NavigationRoute.reports,
                onTap: () => navigationNotifier.navigateTo(NavigationRoute.reports),
              ),
              SidebarItem(
                route: NavigationRoute.experimental,
                isExpanded: navigation.isSidebarExpanded,
                isSelected: navigation.currentRoute == NavigationRoute.experimental,
                onTap: () => navigationNotifier.navigateTo(NavigationRoute.experimental),
              ),
            ],
          ),
          const Spacer(),
          _buildSidebarFooter(theme, navigation.isSidebarExpanded, navigationNotifier),
        ],
      ),
    );
  }

  Widget _buildSidebarFooter(
    AppThemeData theme,
    bool isExpanded,
    NavigationNotifier navigationNotifier,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: IconButton(
        icon: Icon(
          isExpanded ? Icons.chevron_left : Icons.chevron_right,
          color: theme.textSecondaryColor,
          size: 20,
        ),
        onPressed: navigationNotifier.toggleSidebar,
        tooltip: isExpanded ? 'Zwiń menu' : 'Rozwiń menu',
      ),
    );
  }
}