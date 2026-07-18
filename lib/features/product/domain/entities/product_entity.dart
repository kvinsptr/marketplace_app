class ProductEntity {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final double rating;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
  });
}