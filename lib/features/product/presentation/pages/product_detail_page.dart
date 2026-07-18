import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cart/presentation/providers/cart_provider.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailPage extends ConsumerWidget {
  final ProductEntity product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: Image.network(
                product.image,
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 320,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 80,
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Rp ${product.price.toInt()}",
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Chip(
                    label: Text(product.category),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Stok : ${product.stock}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Tambah ke Keranjang"),
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .addToCart(product);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Produk berhasil ditambahkan ke keranjang",
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}