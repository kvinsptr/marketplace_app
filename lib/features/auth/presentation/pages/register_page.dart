import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String role = "buyer";


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [

            TextField(
              controller: emailController,

              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),


            const SizedBox(height: 15),


            TextField(
              controller: passwordController,

              obscureText: true,

              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),


            const SizedBox(height: 15),


            DropdownButtonFormField<String>(
              initialValue: role,

              decoration: const InputDecoration(
                labelText: "Role",
                border: OutlineInputBorder(),
              ),


              items: const [

                DropdownMenuItem(
                  value: "buyer",
                  child: Text("Buyer"),
                ),


                DropdownMenuItem(
                  value: "seller",
                  child: Text("Seller"),
                ),


                DropdownMenuItem(
                  value: "admin",
                  child: Text("Admin"),
                ),

              ],


              onChanged: (value) {

                if (value == null) return;

                setState(() {
                  role = value;
                });

              },
            ),


            const SizedBox(height: 25),


            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: () async {


                  await ref
                      .read(
                        authProvider.notifier,
                      )
                      .register(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        role,
                      );


                  if (!context.mounted) return;


                  Navigator.pop(context);

                },


                child: const Text(
                  "Register",
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}