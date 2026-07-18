import 'package:flutter/material.dart';

import 'success_page.dart';

class CheckoutPage extends StatelessWidget {
  final double total;

  const CheckoutPage({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text(
                  "Alamat Pengiriman",
                ),
                subtitle: const Text(
                  "Jl. Merdeka No.123, Jakarta",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.payment),
                title: const Text(
                  "Metode Pembayaran",
                ),
                subtitle: const Text(
                  "Transfer Bank",
                ),
              ),
            ),

            const Spacer(),

            Text(
              "Total Bayar",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium,
            ),

            const SizedBox(height: 10),

            Text(
              "Rp ${total.toInt()}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const SuccessPage(),
                    ),
                  );
                },
                child: const Text(
                  "Bayar Sekarang",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}