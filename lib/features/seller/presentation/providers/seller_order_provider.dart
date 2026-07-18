import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/seller_order_repository.dart';



final sellerOrderRepositoryProvider =
    Provider((ref) {


  return SellerOrderRepository();


});







final sellerOrdersProvider =
    StreamProvider.family<List<Map<String,dynamic>>, String>(
        (ref, sellerId) {



  final repository =
      ref.read(
        sellerOrderRepositoryProvider,
      );



  return repository.getSellerOrders(
    sellerId,
  );


});