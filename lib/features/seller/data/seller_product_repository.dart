import 'package:cloud_firestore/cloud_firestore.dart';

import '../../product/data/product_repository.dart';
import '../../product/domain/models/product_model.dart';



class SellerProductRepository
    extends ProductRepository {



  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;



  Stream<List<ProductModel>> getSellerProducts(
      String sellerId,
      ) {


    return _firestore
        .collection("products")
        .where(
          "sellerId",
          isEqualTo: sellerId,
        )
        .snapshots()
        .map((snapshot) {


          return snapshot.docs.map((doc) {


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


    await _firestore
        .collection("products")
        .add(
          product.toMap(),
        );


  }




  Future<void> updateProduct(
      ProductModel product,
      ) async {


    await _firestore
        .collection("products")
        .doc(product.id)
        .update(
          product.toMap(),
        );


  }




  Future<void> deleteProduct(
      String id,
      ) async {


    await _firestore
        .collection("products")
        .doc(id)
        .delete();


  }



}