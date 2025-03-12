import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared/services/window_service.dart';
import 'ui/layout/main_layout.dart';
import 'features/home/home_view.dart';
import 'core/navigation/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowService.initWindow();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
      home: MainLayout(
        child: getViewForRoute(),
      ),
    );
  }
}