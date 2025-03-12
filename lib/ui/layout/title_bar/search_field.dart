import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return Container(
      width: 400,
      height: 28,
      decoration: BoxDecoration(
        color: theme.searchBackgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _isFocused ? theme.accentColor : Colors.transparent,
          width: 1,
        ),
      ),
      child: Focus(
        onFocusChange: (focused) {
          setState(() => _isFocused = focused);
        },
        child: TextField(
          controller: _controller,
          style: TextStyle(
            color: theme.textPrimaryColor,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8, right: 4),
              child: Icon(
                Icons.search,
                size: 16,
                color: theme.textSecondaryColor,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 24,
              maxWidth: 32,
            ),
            hintText: 'Szukaj (Ctrl+P)',
            hintStyle: TextStyle(
              color: theme.textSecondaryColor,
              fontSize: 13,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }
}