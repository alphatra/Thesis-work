import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/window_service.dart';

class OptimizedTitleBar extends ConsumerWidget {
  final TextEditingController searchController;

  const OptimizedTitleBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 38,
      color: const Color(0xFF1E1E1E),
      child: GestureDetector(
        onPanStart: (_) => WindowService.startDragging(),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: const [
                  Icon(
                    Icons.code,
                    size: 16,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Modern Flutter Desktop',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 400,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3C3C3C),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8, right: 4),
                        child: Icon(
                          Icons.search,
                          size: 16,
                          color: Colors.white70,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 24,
                        maxWidth: 32,
                      ),
                      hintText: 'Search (Ctrl+P)',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                _WindowButton(
                  icon: Icons.remove,
                  onPressed: WindowService.minimizeWindow,
                ),
                _WindowButton(
                  icon: Icons.crop_square,
                  onPressed: WindowService.maximizeOrRestoreWindow,
                ),
                _WindowButton(
                  icon: Icons.close,
                  onPressed: WindowService.closeWindow,
                  isClose: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WindowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isClose;

  const _WindowButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.isClose = false,
  }) : super(key: key);

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 46,
          height: 38,
          color: _getBackgroundColor(),
          child: Icon(
            widget.icon,
            size: 16,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!_isHovered) return Colors.transparent;
    if (widget.isClose) return Colors.red;
    return const Color(0xFF2D2D2D);
  }
}
