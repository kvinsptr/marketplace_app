import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/seller_product_repository.dart';

import '../../../product/domain/models/product_model.dart';



final sellerProductRepositoryProvider =
    Provider((ref){

  return SellerProductRepository();

});



final sellerProductsProvider =
StreamProvider.family<List<ProductModel>, String>(
(ref, sellerId){

  final repo =
      ref.read(
        sellerProductRepositoryProvider,
      );


  return repo.getSellerProducts(
    sellerId,
  );


});