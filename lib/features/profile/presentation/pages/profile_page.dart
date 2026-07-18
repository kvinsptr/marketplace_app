import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              const CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/300",
                ),
              ),

              const SizedBox(height: 15),

              Text(
                auth.user?.email ?? "User",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "${auth.user?.role ?? 'Buyer'} Account",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              _menuTile(
                Icons.shopping_bag_outlined,
                "My Orders",
              ),

              _menuTile(
                Icons.favorite_border,
                "Wishlist",
              ),

              _menuTile(
                Icons.location_on_outlined,
                "Shipping Address",
              ),

              _menuTile(
                Icons.notifications_outlined,
                "Notifications",
              ),

              _menuTile(
                Icons.settings_outlined,
                "Settings",
              ),

              _menuTile(
                Icons.help_outline,
                "Help Center",
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final logout = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Logout"),
                        content: const Text(
                          "Apakah Anda yakin ingin logout?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context, false),
                            child: const Text("Batal"),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                Navigator.pop(context, true),
                            child: const Text("Logout"),
                          ),
                        ],
                      ),
                    );

                    if (logout == true) {
                      await ref
                          .read(authProvider.notifier)
                          .logout();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _menuTile(
    IconData icon,
    String title,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }
}