import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product_entity.dart';

final productProvider = Provider<List<ProductEntity>>((ref) {
  return [
    ProductEntity(
      id: '1',
      name: 'iPhone 15 Pro',
      price: 18000000,
      image:
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569',
      category: 'Gadget',
      rating: 4.9,
    ),
    ProductEntity(
      id: '2',
      name: 'Macbook Pro M3',
      price: 35000000,
      image:
          'https://images.unsplash.com/photo-1517336714739-489689fd1ca8',
      category: 'Laptop',
      rating: 4.8,
    ),
  ];
});