# Modern Flutter Desktop App

A modern desktop application built with Flutter and Riverpod, featuring a professional UI design inspired by modern IDEs.

## Features

- 🎨 Modern, clean UI design
- 🌗 Dark mode support
- 📱 Responsive layout
- 🔍 Global search functionality
- 🎯 State management with Riverpod
- 🚀 Performance optimized
- 🔒 Clean architecture

## Project Structure

```
lib/
├── core/              # Core functionality and configurations
│   ├── navigation/    # Navigation system
│   └── theme/         # Theme configuration
├── features/          # Feature-based modules
│   └── home/         
├── shared/           # Shared functionality
│   ├── models/       # Data models
│   ├── providers/    # Riverpod providers
│   └── services/     # Services
└── ui/              # UI components
    └── layout/      # Layout components
```

## Getting Started

1. Clone the repository
```bash
git clone https://github.com/yourusername/modern-flutter-desktop.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run -d windows # or macos, linux
```

## Requirements

- Flutter 3.0.0 or higher
- Dart 2.17.0 or higher
- Desktop OS (Windows, macOS, or Linux)

## Dependencies

- flutter_riverpod: State management
- window_manager: Window management for desktop

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.