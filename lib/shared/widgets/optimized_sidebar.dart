class OptimizedSidebar extends ConsumerWidget {
  final double width;

  const OptimizedSidebar({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Używamy select aby reagować tylko na konkretne zmiany stanu
    final isExpanded = ref.watch(
      navigationProvider.select((state) => state.isSidebarExpanded)
    );
    final currentRoute = ref.watch(
      navigationProvider.select((state) => state.currentRoute)
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      child: _SidebarContent(
        isExpanded: isExpanded,
        currentRoute: currentRoute,
      ),
    );
  }
} 