import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';
import '../../core/theme/app_theme.dart';
import 'optimized_navigation_items.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final navigation = ref.watch(navigationProvider);

    return Container(
      width: navigation.isSidebarExpanded ? 240 : 52,
      color: theme.sidebarColor,
      child: Column(
        children: [
          SidebarSection(
            title: navigation.isSidebarExpanded ? 'NAVIGATION' : '',
            children: [
              for (final route in NavigationRoute.values)
                SidebarItem(
                  route: route,
                  isExpanded: navigation.isSidebarExpanded,
                  isSelected: navigation.currentRoute == route,
                  onTap: () => ref.read(navigationProvider.notifier).navigateTo(route),
                ),
            ],
          ),
          const Spacer(),
          _buildSidebarFooter(theme, navigation, ref),
        ],
      ),
    );
  }

  Widget _buildSidebarFooter(
      AppThemeData theme,
      NavigationState navigation,
      WidgetRef ref,
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
          navigation.isSidebarExpanded ? Icons.chevron_left : Icons.chevron_right,
          color: theme.textSecondaryColor,
          size: 20,
        ),
        onPressed: () => ref.read(navigationProvider.notifier).toggleSidebar(),
        tooltip: navigation.isSidebarExpanded ? 'Collapse sidebar' : 'Expand sidebar',
      ),
    );
  }
}

class SidebarSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SidebarSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }
}

class SidebarItem extends StatelessWidget {
  final NavigationRoute route;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  const SidebarItem({
    Key? key,
    required this.route,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF007ACC).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              route.icon,
              size: 20,
              color: isSelected ? const Color(0xFF007ACC) : Colors.white70,
            ),
            if (isExpanded) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  route.title,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF007ACC) : Colors.white,
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
