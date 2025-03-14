import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class OptimizedContent extends ConsumerWidget {
  final Widget child;

  const OptimizedContent({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color(0xFF1E1E1E),
      child: child,
    );
  }
}
