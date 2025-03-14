class OptimizedNavigationItems extends ConsumerWidget {
  const OptimizedNavigationItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RepaintBoundary(
      child: ListView.builder(
        itemCount: NavigationRoute.values.length,
        itemBuilder: (context, index) {
          final route = NavigationRoute.values[index];
          return OptimizedNavigationItem(route: route);
        },
      ),
    );
  }
}

class OptimizedNavigationItem extends ConsumerWidget {
  final NavigationRoute route;

  const OptimizedNavigationItem({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(
      navigationProvider.select((state) => state.currentRoute == route)
    );
    final isExpanded = ref.watch(
      navigationProvider.select((state) => state.isSidebarExpanded)
    );

    return RepaintBoundary(
      child: _NavigationItemContent(
        route: route,
        isSelected: isSelected,
        isExpanded: isExpanded,
      ),
    );
  }
} 