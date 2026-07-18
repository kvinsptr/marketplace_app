import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/product_repository.dart';
import '../../domain/models/product_model.dart';


final productRepositoryProvider =
    Provider((ref){

  return ProductRepository();

});



final productProvider =
    StreamProvider<List<ProductModel>>((ref){

  return ref
      .read(productRepositoryProvider)
      .getProducts();

});