import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return Container(
      width: 400,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF3C3C3C),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Szukaj (Ctrl+P)',
          hintStyle: TextStyle(
            color: theme.textSecondaryColor,
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 16,
            color: theme.textSecondaryColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        style: TextStyle(
          color: theme.textPrimaryColor,
          fontSize: 13,
        ),
      ),
    );
  }
} 