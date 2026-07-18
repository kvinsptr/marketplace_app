import 'package:flutter/material.dart';



class SellerChatPage extends StatelessWidget {

  const SellerChatPage({
    super.key,
  });



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Chat Buyer",
            ),


        backgroundColor:
            Colors.deepPurple,


        foregroundColor:
            Colors.white,

      ),




      body: Padding(

        padding:
            const EdgeInsets.all(16),


        child: Column(


          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [


            const Text(

              "Pesan Masuk",

              style:
                  TextStyle(

                fontSize:
                    20,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(
              height:20,
            ),




            Expanded(


              child: Center(


                child: Column(


                  mainAxisAlignment:
                      MainAxisAlignment.center,


                  children: [


                    const Icon(

                      Icons.chat_bubble_outline,

                      size:
                          80,

                      color:
                          Colors.grey,

                    ),



                    const SizedBox(
                      height:15,
                    ),



                    const Text(

                      "Belum ada chat",

                      style:
                          TextStyle(

                        fontSize:
                            18,

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),



                    const SizedBox(
                      height:8,
                    ),



                    const Text(

                      "Chat dari buyer akan muncul di sini",

                      textAlign:
                          TextAlign.center,

                    ),


                  ],

                ),

              ),

            ),


          ],

        ),

      ),


    );

  }

}