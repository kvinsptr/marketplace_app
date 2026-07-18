import 'package:cloud_firestore/cloud_firestore.dart';


class ChatService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;


  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
    String senderId,
    String receiverId,
  ) {

    return _firestore
        .collection("messages")
        .orderBy(
          "createdAt",
          descending: false,
        )
        .snapshots();

  }



  Future<void> sendMessage({

    required String senderId,
    required String receiverId,
    required String message,

  }) async {


    await _firestore
        .collection("messages")
        .add({

      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "createdAt":
          FieldValue.serverTimestamp(),

    });


  }

}