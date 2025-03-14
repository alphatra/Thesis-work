class MainLayout extends ConsumerStatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  // Używamy late final dla jednokrotnej inicjalizacji
  late final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _MainLayoutContent(
          child: widget.child,
          searchController: _searchController,
          constraints: constraints,
        );
      },
    );
  }
}

// Wydzielony komponent dla lepszej wydajności
class _MainLayoutContent extends ConsumerWidget {
  final Widget child;
  final TextEditingController searchController;
  final BoxConstraints constraints;

  const _MainLayoutContent({
    required this.child,
    required this.searchController,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final navigation = ref.watch(navigationProvider);

    return Material(
      color: theme.contentBackgroundColor,
      child: Column(
        children: [
          const OptimizedTitleBar(),
          Expanded(
            child: Row(
              children: [
                OptimizedSidebar(
                  width: navigation.isSidebarExpanded ? 250 : 52,
                ),
                Expanded(
                  child: OptimizedContent(child: child),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 