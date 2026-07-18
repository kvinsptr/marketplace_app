import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/order_repository.dart';
import '../../domain/models/order_model.dart';





final orderRepositoryProvider =
    Provider<OrderRepository>((ref) {

  return OrderRepository();

});









class OrderNotifier
    extends StateNotifier<AsyncValue<void>> {


  final OrderRepository repository;



  OrderNotifier(
    this.repository,
  )
      : super(
          const AsyncData(null),
        );






  Future<void> createOrder(
    OrderModel order,
  ) async {


    try {


      state =
          const AsyncLoading();




      await repository.createOrder(
        order,
      );




      state =
          const AsyncData(null);




    } catch(e, stack){


      state =
          AsyncError(
            e,
            stack,
          );


    }


  }



}










final orderNotifierProvider =
    StateNotifierProvider<
        OrderNotifier,
        AsyncValue<void>>(
  (ref){


    return OrderNotifier(

      ref.read(
        orderRepositoryProvider,
      ),

    );


  },

);













// BUYER ORDERS

final buyerOrdersProvider =
    StreamProvider.family<List<OrderModel>, String>(
  (ref, buyerId){


    final repository =
        ref.read(
          orderRepositoryProvider,
        );



    return repository.getBuyerOrders(
      buyerId,
    );


  },

);











// SELLER ORDERS

final sellerOrdersProvider =
    StreamProvider.family<List<OrderModel>, String>(
  (ref, sellerId){


    final repository =
        ref.read(
          orderRepositoryProvider,
        );



    return repository.getSellerOrders(
      sellerId,
    );


  },

);












// ADMIN - SEMUA ORDER

final allOrdersProvider =
    StreamProvider<List<OrderModel>>(
  (ref){


    final repository =
        ref.read(
          orderRepositoryProvider,
        );



    return repository.getAllOrders();


  },

);