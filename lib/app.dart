import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navigation/main_navigation_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/providers/auth_provider.dart';


class MarketplaceApp extends ConsumerWidget {
  const MarketplaceApp({super.key});


  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {

    final authState = ref.watch(authProvider);


    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Marketplace',


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


      home: authState.isAuthenticated
          ? const MainNavigationPage()
          : const LoginPage(),

    );

  }
}