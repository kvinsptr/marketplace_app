import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/chat_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final String sellerName;

  const ChatDetailPage({
    super.key,
    required this.sellerName,
  });

  @override
  ConsumerState<ChatDetailPage> createState() =>
      _ChatDetailPageState();
}

class _ChatDetailPageState
    extends ConsumerState<ChatDetailPage> {

  final TextEditingController messageController =
      TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final auth = ref.watch(authProvider);

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.sellerName),
      ),


      body: Column(

        children: [

          Expanded(

            child: StreamBuilder<QuerySnapshot>(

              stream: ref
                  .read(chatServiceProvider)
                  .getMessages(
                    auth.user!.uid,
                    "seller",
                  ),


              builder: (context, snapshot) {


                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                }


                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {

                  return const Center(
                    child: Text(
                      "Belum ada pesan",
                    ),
                  );

                }


                final docs =
                    snapshot.data!.docs;



                return ListView.builder(

                  padding:
                      const EdgeInsets.all(15),


                  itemCount:
                      docs.length,


                  itemBuilder:
                      (context, index) {


                    final data =
                        docs[index].data()
                            as Map<String, dynamic>;



                    final bool isMe =
                        data["senderId"] ==
                            auth.user!.uid;



                    return Align(

                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,


                      child: Container(

                        margin:
                            const EdgeInsets.symmetric(
                          vertical: 5,
                        ),


                        padding:
                            const EdgeInsets.all(12),


                        decoration:
                            BoxDecoration(

                          color: isMe
                              ? Colors.deepPurple
                              : Colors.grey.shade300,


                          borderRadius:
                              BorderRadius.circular(12),

                        ),



                        child: Text(

                          data["message"] ?? "",


                          style: TextStyle(

                            color: isMe
                                ? Colors.white
                                : Colors.black,

                          ),

                        ),

                      ),

                    );

                  },

                );

              },

            ),

          ),



          SafeArea(

            child: Padding(

              padding:
                  const EdgeInsets.all(10),


              child: Row(

                children: [


                  Expanded(

                    child: TextField(

                      controller:
                          messageController,


                      decoration:
                          const InputDecoration(

                        hintText:
                            "Tulis pesan...",


                        border:
                            OutlineInputBorder(),

                      ),

                    ),

                  ),



                  IconButton(

                    icon:
                        const Icon(Icons.send),



                    onPressed:
                        () async {


                      if (messageController
                          .text
                          .trim()
                          .isEmpty) {

                        return;

                      }



                      await ref
                          .read(chatServiceProvider)
                          .sendMessage(

                            senderId:
                                auth.user!.uid,


                            receiverId:
                                "seller",


                            message:
                                messageController.text
                                    .trim(),

                          );



                      messageController.clear();


                    },

                  ),


                ],

              ),

            ),

          ),

        ],

      ),

    );

  }

}