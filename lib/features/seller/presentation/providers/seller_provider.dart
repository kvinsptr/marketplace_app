import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/seller_repository.dart';
import '../../data/repositories/seller_repository_impl.dart';
import '../../domain/models/seller_stats.dart';

final sellerRepositoryProvider = Provider<SellerRepository>((ref) {
  return SellerRepositoryImpl();
});

final sellerStatsProvider =
    FutureProvider.family<SellerStats, String>((ref, sellerId) {
  return ref
      .read(sellerRepositoryProvider)
      .getSellerStats(sellerId);
});