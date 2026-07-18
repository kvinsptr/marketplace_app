class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final String category;
  final double rating;
  final int stock;
  final String sellerId;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.rating,
    required this.stock,
    required this.sellerId,
  });

  ProductEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    double? price,
    String? category,
    double? rating,
    int? stock,
    String? sellerId,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      sellerId: sellerId ?? this.sellerId,
    );
  }
}