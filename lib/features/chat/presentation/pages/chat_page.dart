import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(),
            title: Text("Official Store"),
            subtitle: Text("Produk sudah dikirim"),
            trailing: Text("09:12"),
          ),
          ListTile(
            leading: CircleAvatar(),
            title: Text("Gaming Shop"),
            subtitle: Text("Terima kasih sudah order"),
            trailing: Text("Kemarin"),
          ),
        ],
      ),
    );
  }
}