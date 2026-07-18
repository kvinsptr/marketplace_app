import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/models/product_model.dart';



class ProductRepository {


  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;




  Stream<List<ProductModel>> getProducts(){


    return firestore
        .collection("products")
        .snapshots()
        .map((snapshot){


          return snapshot.docs.map((doc){


            return ProductModel.fromMap(

              doc.data(),

              doc.id,

            );


          }).toList();


        });


  }





  Future<void> createProduct(
    ProductModel product,
  ) async {


    await firestore
        .collection("products")
        .add(

          product.toMap(),

        );


  }





  Future<void> updateProduct(
    ProductModel product,
  ) async {


    await firestore
        .collection("products")
        .doc(product.id)
        .update(

          product.toMap(),

        );


  }





  Future<void> deleteProduct(
    String id,
  ) async {


    await firestore
        .collection("products")
        .doc(id)
        .delete();


  }


}