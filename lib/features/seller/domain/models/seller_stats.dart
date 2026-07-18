class SellerStats {
  final int totalProducts;
  final int totalOrders;
  final double totalRevenue;

  const SellerStats({
    required this.totalProducts,
    required this.totalOrders,
    required this.totalRevenue,
  });

  factory SellerStats.empty() {
    return const SellerStats(
      totalProducts: 0,
      totalOrders: 0,
      totalRevenue: 0,
    );
  }
}