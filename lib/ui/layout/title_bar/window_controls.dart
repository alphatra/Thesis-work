import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/services/window_service.dart';

class WindowControls extends ConsumerWidget {
  const WindowControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return Row(
      children: [
        _WindowButton(
          icon: Icons.remove,
          onPressed: WindowService.minimizeWindow,
          theme: theme,
        ),
        _WindowButton(
          icon: Icons.crop_square,
          onPressed: WindowService.maximizeOrRestoreWindow,
          theme: theme,
        ),
        _WindowButton(
          icon: Icons.close,
          onPressed: WindowService.closeWindow,
          theme: theme,
          isClose: true,
        ),
      ],
    );
  }
}

class _WindowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final AppThemeData theme;
  final bool isClose;

  const _WindowButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.theme,
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
            color: widget.theme.textSecondaryColor,
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!_isHovered) return Colors.transparent;
    if (widget.isClose) return Colors.red;
    return widget.theme.buttonBackgroundColor;
  }
}