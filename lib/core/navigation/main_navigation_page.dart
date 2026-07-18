import 'package:flutter/material.dart';

import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int currentIndex = 0;

  late final List<Widget> pages = const [
    HomePage(),
    ChatPage(),
    CartPage(),
    ProfilePage(),
  ];

  void changePage(int index) {
    if (currentIndex == index) return;

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        height: 72,
        selectedIndex: currentIndex,
        labelBehavior:
            NavigationDestinationLabelBehavior.alwaysShow,
        animationDuration: const Duration(milliseconds: 300),
        onDestinationSelected: changePage,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),

          const NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat),
            label: "Chat",
          ),

          NavigationDestination(
            icon: Badge(
              isLabelVisible: true,
              label: const Text("2"),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: true,
              label: const Text("2"),
              child: const Icon(Icons.shopping_cart),
            ),
            label: "Cart",
          ),

          NavigationDestination(
            icon: Badge(
              isLabelVisible: true,
              child: const Icon(Icons.person_outline),
            ),
            selectedIcon: Badge(
              isLabelVisible: true,
              child: const Icon(Icons.person),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}