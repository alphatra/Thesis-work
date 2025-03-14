import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../../core/navigation/app_router.dart';

class OptimizedNavigationItems extends ConsumerWidget {
  const OptimizedNavigationItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RepaintBoundary(
      child: ListView(
        children: NavigationRoute.values.map((route) {
          return OptimizedNavigationItem(
            route: route,
            isSelected: ref.watch(navigationProvider).currentRoute == route,
          );
        }).toList(),
      ),
    );
  }
}

class OptimizedNavigationItem extends ConsumerWidget {
  final NavigationRoute route;
  final bool isSelected;

  const OptimizedNavigationItem({
    Key? key,
    required this.route,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);

    return GestureDetector(
      onTap: () => ref.read(navigationProvider.notifier).navigateTo(route),
      child: RepaintBoundary(
        child: _NavigationItemContent(
          route: route,
          isSelected: isSelected,
          isExpanded: navigationState.isSidebarExpanded,
        ),
      ),
    );
  }
}
class _NavigationItemContent extends StatelessWidget {
  final NavigationRoute route;
  final bool isSelected;
  final bool isExpanded;

  const _NavigationItemContent({
    Key? key,
    required this.route,
    required this.isSelected,
    required this.isExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
