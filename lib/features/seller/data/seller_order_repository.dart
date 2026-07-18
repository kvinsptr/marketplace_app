import 'package:cloud_firestore/cloud_firestore.dart';


class SellerOrderRepository {


  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;



  Stream<List<Map<String,dynamic>>> getSellerOrders(
      String sellerId
      ) {


    return firestore
        .collection("orders")
        .where(
          "sellerId",
          isEqualTo: sellerId,
        )
        .snapshots()
        .map((snapshot){


          return snapshot.docs.map((doc){


            return {

              "id": doc.id,

              ...doc.data(),

            };


          }).toList();


        });


  }





  Future<void> updateOrderStatus(
      String orderId,
      String status,
      ) async {


    await firestore
        .collection("orders")
        .doc(orderId)
        .update({

      "status": status,

    });


  }



}