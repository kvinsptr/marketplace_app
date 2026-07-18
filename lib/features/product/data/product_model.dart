import '../domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final String category;
  final double rating;
  final int stock;
  final String sellerId;

  const ProductModel({
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

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      price: (map['price'] ?? 0).toDouble(),
      category: map['category']?.toString() ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      stock: (map['stock'] ?? 0) as int,
      sellerId: map['sellerId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'category': category,
      'rating': rating,
      'stock': stock,
      'sellerId': sellerId,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      image: image,
      price: price,
      category: category,
      rating: rating,
      stock: stock,
      sellerId: sellerId,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      image: entity.image,
      price: entity.price,
      category: entity.category,
      rating: entity.rating,
      stock: entity.stock,
      sellerId: entity.sellerId,
    );
  }

  ProductModel copyWith({
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
    return ProductModel(
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