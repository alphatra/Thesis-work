import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/models/auth_state.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/views/login_view.dart';
import 'features/home/views/home_view.dart';
import 'shared/providers/navigation_provider.dart';
import 'shared/services/window_service.dart';
import 'shared/widgets/main_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowService.initWindow();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    // Sprawdzanie stanu uwierzytelniania przy starcie aplikacji
    if (authState.status == AuthStatus.initial) {
      ref.read(authProvider.notifier).checkAuthStatus();
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      title: 'Your App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007ACC),
          brightness: Brightness.dark,
        ),
      ),
      home: authState.isAuthenticated
          ? const MainLayoutWithRouting()
          : const LoginView(),
    );
  }
}

class MainLayoutWithRouting extends ConsumerWidget {
  const MainLayoutWithRouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(navigationProvider).currentRoute;

    Widget getViewForRoute() {
      switch (currentRoute) {
        case NavigationRoute.home:
          return const HomeView();
        case NavigationRoute.data:
          return const Center(child: Text('Dane'));
        case NavigationRoute.reports:
          return const Center(child: Text('Raporty'));
        case NavigationRoute.experimental:
          return const Center(child: Text('Tryb eksperymentalny'));
      }
    }

    return MainLayout(
      child: getViewForRoute(),
    );
  }
}