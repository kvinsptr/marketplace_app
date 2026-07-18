import '../../domain/models/seller_stats.dart';

abstract class SellerRepository {
  Future<SellerStats> getSellerStats(String sellerId);
}