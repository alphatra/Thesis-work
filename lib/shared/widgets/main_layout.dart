import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'sidebar.dart';
import 'search_field.dart';

class MainLayout extends ConsumerStatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final navigation = ref.watch(navigationProvider);

    return Scaffold(
      backgroundColor: theme.contentBackgroundColor,
      body: Column(
        children: [
          // Title Bar
          Container(
            height: 38,
            color: theme.titleBarColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.code,
                        size: 16,
                        color: theme.textSecondaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Your App',
                        style: TextStyle(
                          color: theme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: SearchField(),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: navigation.isSidebarExpanded ? 250 : 52,
                  child: const Sidebar(),
                ),
                Expanded(
                  child: Container(
                    color: theme.contentBackgroundColor,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}