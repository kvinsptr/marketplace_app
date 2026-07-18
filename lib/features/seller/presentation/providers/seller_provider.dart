import 'package:flutter_riverpod/flutter_riverpod.dart';


class SellerState {

  final int totalProduct;

  final int totalOrder;

  final double income;


  const SellerState({

    this.totalProduct = 0,

    this.totalOrder = 0,

    this.income = 0,

  });


}



class SellerNotifier extends StateNotifier<SellerState> {


  SellerNotifier()
      : super(
          const SellerState(),
        );


  void addProduct(){

    state = SellerState(

      totalProduct:
          state.totalProduct + 1,

      totalOrder:
          state.totalOrder,

      income:
          state.income,

    );

  }


}



final sellerProvider =
    StateNotifierProvider<SellerNotifier, SellerState>(

  (ref){

    return SellerNotifier();

  },

);