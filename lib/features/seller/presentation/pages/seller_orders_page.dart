import 'package:flutter/material.dart';



class SellerOrdersPage extends StatelessWidget {

  const SellerOrdersPage({
    super.key,
  });



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Pesanan Seller",
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

              "Daftar Pesanan",

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

                      Icons.shopping_bag_outlined,

                      size:
                          80,

                      color:
                          Colors.grey,

                    ),



                    const SizedBox(
                      height:15,
                    ),




                    const Text(

                      "Belum ada pesanan",

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

                      "Pesanan dari buyer akan muncul di sini",

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