import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product_entity.dart';

final productProvider = Provider<List<ProductEntity>>((ref) {
  return const [
    ProductEntity(
      id: '1',
      name: 'iPhone 15 Pro',
      description: 'iPhone terbaru dengan chip A17 Pro dan kamera profesional.',
      image:
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569',
      price: 18000000,
      category: 'Gadget',
      rating: 4.9,
      stock: 15,
      sellerId: 'seller_001',
    ),
    ProductEntity(
      id: '2',
      name: 'MacBook Pro M3',
      description: 'Laptop Apple dengan performa tinggi menggunakan chip M3.',
      image:
          'https://images.unsplash.com/photo-1517336714739-489689fd1ca8',
      price: 35000000,
      category: 'Laptop',
      rating: 4.8,
      stock: 8,
      sellerId: 'seller_001',
    ),
    ProductEntity(
      id: '3',
      name: 'Gaming Headset',
      description: 'Headset gaming dengan surround sound dan microphone.',
      image:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
      price: 1500000,
      category: 'Gaming',
      rating: 4.7,
      stock: 20,
      sellerId: 'seller_002',
    ),
    ProductEntity(
      id: '4',
      name: 'Smart Watch',
      description: 'Smartwatch dengan fitur kesehatan dan notifikasi.',
      image:
          'https://images.unsplash.com/photo-1546868871-7041f2a55e12',
      price: 2500000,
      category: 'Wearable',
      rating: 4.6,
      stock: 30,
      sellerId: 'seller_003',
    ),
  ];
});