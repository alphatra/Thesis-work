import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';
import 'optimized_navigation_items.dart';

class OptimizedSidebar extends ConsumerWidget {
  final bool isExpanded;

  const OptimizedSidebar({
    Key? key,
    this.isExpanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(navigationProvider.notifier).toggleSidebar(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isExpanded ? 240 : 52,
        child: _SidebarContent(isExpanded: isExpanded),
      ),
    );
  }
}

class _SidebarContent extends StatelessWidget {
  final bool isExpanded;

  const _SidebarContent({
    Key? key,
    required this.isExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF252526),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(isExpanded, 'NAVIGATION'),
                  const OptimizedNavigationItems(),
                ],
              ),
            ),
          ),
          _buildSidebarFooter(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(bool isExpanded, String title) {
    if (!isExpanded) return const SizedBox.shrink();

    return Padding(
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
    );
  }

  Widget _buildSidebarFooter(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF333333)),
          ),
        ),
        child: IconButton(
          icon: Icon(
            isExpanded ? Icons.chevron_left : Icons.chevron_right,
            color: Colors.white70,
            size: 20,
          ),
          onPressed: () {
            ref.read(navigationProvider.notifier).toggleSidebar();
          },
          tooltip: isExpanded ? 'Collapse sidebar' : 'Expand sidebar',
        ),
      );
    });
  }
}
