import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

import 'core/navigation/main_navigation_page.dart';

import 'features/admin/presentation/pages/admin_dashboard_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/providers/auth_state.dart';
import 'features/seller/presentation/pages/seller_dashboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Hive
  await Hive.initFlutter();

  await Future.wait([
    Hive.openBox('settings'),
    Hive.openBox('cart'),
    Hive.openBox('cache'),
  ]);

  runApp(
    const ProviderScope(
      child: MarketplaceApp(),
    ),
  );
}

class MarketplaceApp extends ConsumerWidget {
  const MarketplaceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketplace',

      // Localization
      locale: const Locale('id'),

      supportedLocales: const [
        Locale('id'),
        Locale('en'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Theme
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
      ),

      themeMode: ThemeMode.system,

      home: _buildHome(authState),
    );
  }

  Widget _buildHome(AuthState authState) {
    if (authState.isLoading) {
      return const SplashLoadingPage();
    }

    if (!authState.isAuthenticated) {
      return const LoginPage();
    }

    switch (authState.user?.role) {
      case 'admin':
        return const AdminDashboardPage();

      case 'seller':
        return const SellerDashboardPage();

      case 'buyer':
      default:
        return const MainNavigationPage();
    }
  }
}

class SplashLoadingPage extends StatelessWidget {
  const SplashLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}