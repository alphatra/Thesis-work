import 'package:flutter/material.dart';

enum AppMode {
  basic,
  experimental;
  
  String get displayName {
    switch (this) {
      case AppMode.basic: 
        return 'Podstawowy';
      case AppMode.experimental: 
        return 'Eksperymentalny';
    }
  }
  
  IconData get icon {
    switch (this) {
      case AppMode.basic:
        return Icons.view_compact_alt_outlined;
      case AppMode.experimental:
        return Icons.science_outlined;
    }
  }

  String get description {
    switch (this) {
      case AppMode.basic:
        return 'Standardowy tryb pracy z podstawowymi funkcjami';
      case AppMode.experimental:
        return 'Zaawansowane funkcje i eksperymentalne możliwości';
    }
  }
}