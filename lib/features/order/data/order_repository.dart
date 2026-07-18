import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/models/order_model.dart';



class OrderRepository {


  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;





  Future<void> createOrder(
      OrderModel order
      ) async {


    await firestore
        .collection("orders")
        .add(
          order.toMap(),
        );


  }





  Stream<List<OrderModel>> getBuyerOrders(
      String buyerId
      ){


    return firestore
        .collection("orders")
        .where(
          "buyerId",
          isEqualTo: buyerId,
        )
        .snapshots()
        .map((snapshot){


          return snapshot.docs.map((doc){


            return OrderModel.fromMap(
              doc.data(),
              doc.id,
            );


          }).toList();


        });


  }







  Stream<List<OrderModel>> getSellerOrders(
      String sellerId
      ){


    return firestore
        .collection("orders")
        .where(
          "sellerId",
          isEqualTo: sellerId,
        )
        .snapshots()
        .map((snapshot){


          return snapshot.docs.map((doc){


            return OrderModel.fromMap(
              doc.data(),
              doc.id,
            );


          }).toList();


        });


  }







  Stream<List<OrderModel>> getAllOrders(){


    return firestore
        .collection("orders")
        .orderBy(
          "createdAt",
          descending:true,
        )
        .snapshots()
        .map((snapshot){


          return snapshot.docs.map((doc){


            return OrderModel.fromMap(

              doc.data(),

              doc.id,

            );


          }).toList();


        });


  }







  Future<void> updateOrderStatus(
      String id,
      String status,
      ) async {


    await firestore
        .collection("orders")
        .doc(id)
        .update({

          "status":status,

        });


  }



}