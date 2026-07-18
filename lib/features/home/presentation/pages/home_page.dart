import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/entities/product_entity.dart';
import '../../../product/presentation/providers/product_provider.dart';
import '../../../product/presentation/pages/product_detail_page.dart';

import '../../../wishlist/domain/entities/wishlist_item.dart';
import '../../../wishlist/presentation/providers/wishlist_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);

    final filteredProducts = products.where((product) {
      return product.name
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Marketplace",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Temukan produk terbaik",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor:
                        Theme.of(context)
                            .colorScheme
                            .primary,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Cari produk...",
                  prefixIcon:
                      const Icon(Icons.search),
                  suffixIcon:
                      const Icon(Icons.tune),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(24),
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xff6C63FF),
                      Color(0xff9C27B0),
                    ],
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        "BIG SALE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Diskon hingga 50%",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Kategori",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: const [
                  _Category(
                    icon: Icons.phone_android,
                    title: "Gadget",
                  ),
                  _Category(
                    icon: Icons.checkroom,
                    title: "Fashion",
                  ),
                  _Category(
                    icon: Icons.sports_esports,
                    title: "Gaming",
                  ),
                  _Category(
                    icon: Icons.home,
                    title: "Home",
                  ),
                ],
              ),

              const SizedBox(height: 35),

              const Text(
                "Produk Populer",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
              if (filteredProducts.isEmpty)
  const Center(
    child: Padding(
      padding: EdgeInsets.all(30),
      child: Text(
        "Produk tidak ditemukan",
        style: TextStyle(fontSize: 18),
      ),
    ),
  )
else
  GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: filteredProducts.length,
    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: .72,
    ),
    itemBuilder: (context, index) {
      final ProductEntity product =
          filteredProducts[index];

      final isFavorite = ref
          .watch(wishlistProvider)
          .any((e) => e.id == product.id);

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ProductDetailPage(
                product: product,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Hero(
                      tag: product.id,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.only(
                          topLeft:
                              Radius.circular(20),
                          topRight:
                              Radius.circular(20),
                        ),
                        child: Image.network(
                          product.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) {
                            return Container(
                              color: Colors.grey
                                  .shade300,
                              child: const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor:
                            Colors.white,
                        child: IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons
                                    .favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            ref
                                .read(
                                  wishlistProvider
                                      .notifier,
                                )
                                .toggle(
                                  WishlistItem(
                                    id: product.id,
                                    name:
                                        product.name,
                                    image:
                                        product.image,
                                    price:
                                        product.price,
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Rp ${product.price.toInt()}",
                      style:
                          const TextStyle(
                        color: Colors.green,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color:
                              Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(
                            width: 4),
                        Text(
                          product.rating
                              .toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
              ],
          ),
        ),
      ),
    );
  }
}


class _Category extends StatelessWidget {
  final IconData icon;
  final String title;

  const _Category({
    required this.icon,
    required this.title,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          child: Icon(icon),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}