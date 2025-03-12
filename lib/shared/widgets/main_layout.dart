import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      backgroundColor: theme.contentBackgroundColor,
      body: Row(
        children: [
          Container(
            width: 250,
            color: theme.sidebarColor,
            child: Column(
              children: [
                // Sidebar content
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}