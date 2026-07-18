import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/navigation/main_navigation_page.dart';

import 'features/admin/presentation/pages/admin_dashboard_page.dart';
import 'features/seller/presentation/pages/seller_dashboard_page.dart';

import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/providers/auth_state.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();

  await Hive.openBox('settings');
  await Hive.openBox('cart');
  await Hive.openBox('cache');


  runApp(
    const ProviderScope(
      child: MarketplaceApp(),
    ),
  );
}



class MarketplaceApp extends ConsumerWidget {

  const MarketplaceApp({
    super.key,
  });



  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {

    final authState = ref.watch(authProvider);


    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Marketplace',


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


      theme: ThemeData(

        useMaterial3: true,

        colorSchemeSeed: Colors.deepPurple,

      ),


      darkTheme: ThemeData(

        useMaterial3: true,

        colorSchemeSeed: Colors.deepPurple,

      ),


      themeMode: ThemeMode.system,


      home: _buildHome(authState),

    );

  }



  Widget _buildHome(AuthState authState) {


    // tampilkan loading saat cek Firebase
    if (authState.isLoading) {

      return const Scaffold(

        body: Center(

          child: CircularProgressIndicator(),

        ),

      );

    }



    // belum login
    if (!authState.isAuthenticated) {

      return const LoginPage();

    }



    // berdasarkan role
    switch (authState.user?.role) {


      case "admin":

        return const AdminDashboardPage();



      case "seller":

        return const SellerDashboardPage();



      case "buyer":

      default:

        return const MainNavigationPage();

    }

  }

}