import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/navigation/app_router.dart';
import '../../core/theme/app_theme.dart';
import 'title_bar/title_bar.dart';
import 'sidebar/sidebar.dart';

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final navigation = ref.watch(navigationProvider);

    return Scaffold(
      body: Column(
        children: [
          const TitleBar(),
          Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: navigation.isSidebarExpanded ? 240 : 52,
                  child: const Sidebar(),
                ),
                Expanded(
                  child: Container(
                    color: theme.contentBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(theme, navigation.currentRoute.title),
                        Expanded(child: child),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(AppThemeData theme, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.contentBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: theme.textPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}