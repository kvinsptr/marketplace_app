import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/seller_stats.dart';
import 'seller_repository.dart';

class SellerRepositoryImpl implements SellerRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<SellerStats> getSellerStats(String sellerId) async {
    final products = await firestore
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .get();

    final orders = await firestore
        .collection('orders')
        .where('sellerId', isEqualTo: sellerId)
        .get();

    double revenue = 0;

    for (final doc in orders.docs) {
      revenue += (doc['total'] ?? 0).toDouble();
    }

    return SellerStats(
      totalProducts: products.docs.length,
      totalOrders: orders.docs.length,
      totalRevenue: revenue,
    );
  }
}