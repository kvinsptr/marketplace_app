import 'package:flutter/material.dart';

import 'chat_detail_page.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({super.key});


  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> chats = [

      {
        "name": "Official Store",
        "message": "Produk sudah dikirim",
        "time": "09:12",
        "unread": 2,
      },

      {
        "name": "Gaming Shop",
        "message": "Terima kasih sudah order",
        "time": "Kemarin",
        "unread": 0,
      },

      {
        "name": "Fashion Store",
        "message": "Silakan lakukan pembayaran",
        "time": "10:45",
        "unread": 1,
      },

    ];


    return Scaffold(

      appBar: AppBar(
        title: const Text("Chat"),
        centerTitle: true,
      ),


      body: ListView.separated(

        itemCount: chats.length,


        separatorBuilder: (_, index) =>
            const Divider(height: 1),


        itemBuilder: (context, index) {


          final chat = chats[index];


          return ListTile(

            leading: CircleAvatar(

              child: Text(

                chat["name"]
                    .toString()
                    .substring(0, 1)
                    .toUpperCase(),

              ),

            ),


            title: Text(

              chat["name"].toString(),

              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),

            ),


            subtitle: Text(

              chat["message"].toString(),

            ),


            trailing: Column(

              mainAxisAlignment:
                  MainAxisAlignment.center,


              children: [


                Text(
                  chat["time"].toString(),
                ),


                const SizedBox(height: 5),



                if (chat["unread"] > 0)

                  CircleAvatar(

                    radius: 10,


                    child: Text(

                      "${chat["unread"]}",

                      style:
                          const TextStyle(
                        fontSize: 11,
                      ),

                    ),

                  ),

              ],

            ),



            onTap: () {


              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                      ChatDetailPage(

                        sellerName:
                            chat["name"].toString(),

                      ),

                ),

              );

            },


          );

        },

      ),

    );

  }

}