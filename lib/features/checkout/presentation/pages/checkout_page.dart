import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cart/presentation/providers/cart_provider.dart';
import 'success_page.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  final double total;

  const CheckoutPage({
    super.key,
    required this.total,
  });

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final List<String> paymentMethods = [
    'Transfer Bank',
    'E-Wallet',
    'COD',
  ];

  String selectedPayment = 'Transfer Bank';

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(Icons.location_on),
                title: Text(
                  "Alamat Pengiriman",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Jl. Merdeka No.123, Jakarta",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<String>(
                  value: selectedPayment,
                  decoration: const InputDecoration(
                    labelText: "Metode Pembayaran",
                    border: OutlineInputBorder(),
                  ),
                  items: paymentMethods
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      selectedPayment = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ringkasan Pesanan",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartItems.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = cartItems[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(item.product.image),
                    ),
                    title: Text(item.product.name),
                    subtitle: Text(
                      "${item.quantity} x Rp ${item.product.price.toInt()}",
                    ),
                    trailing: Text(
                      "Rp ${item.totalPrice.toInt()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            Card(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Pembayaran",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Rp ${widget.total.toInt()}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                label: const Text("Bayar Sekarang"),
                onPressed: () {
                  ref.read(cartProvider.notifier).clearCart();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SuccessPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}