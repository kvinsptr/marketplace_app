import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/order_provider.dart';





class BuyerOrdersPage extends ConsumerWidget {

  const BuyerOrdersPage({
    super.key,
  });





  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {


    final user =
        ref.watch(authProvider).user;



    if(user == null){

      return const Scaffold(

        body:
            Center(

          child:
              Text(
                "Belum login",
              ),

        ),

      );

    }





    final orders =
        ref.watch(
          buyerOrdersProvider(
            user.uid,
          ),
        );






    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Pesanan Saya",
            ),

        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,

      ),






      body:

      orders.when(



        loading: () =>

            const Center(

              child:
                  CircularProgressIndicator(),

            ),




        error: (error,stack) =>

            Center(

              child:
                  Text(
                    error.toString(),
                  ),

            ),






        data: (items){



          if(items.isEmpty){


            return const Center(

              child:
                  Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,


                children: [


                  Icon(

                    Icons.shopping_bag_outlined,

                    size:
                        80,

                  ),



                  SizedBox(
                    height:15,
                  ),



                  Text(

                    "Belum ada pesanan",

                    style:
                        TextStyle(

                      fontSize:
                          18,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),



                ],

              ),

            );


          }







          return ListView.builder(


            padding:
                const EdgeInsets.all(16),



            itemCount:
                items.length,



            itemBuilder:
                (context,index){


              final order =
                  items[index];






              return Card(


                margin:
                    const EdgeInsets.only(
                      bottom:15,
                    ),



                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(18),

                ),





                child:
                    Padding(

                  padding:
                      const EdgeInsets.all(16),



                  child:
                      Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,



                    children: [




                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,


                        children: [



                          Expanded(

                            child:
                                Text(

                              order.productName,


                              style:
                                  const TextStyle(

                                fontSize:
                                    18,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),

                          ),




                          Container(

                            padding:
                                const EdgeInsets.symmetric(

                              horizontal:
                                  12,

                              vertical:
                                  6,

                            ),


                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.orange.shade100,


                              borderRadius:
                                  BorderRadius.circular(20),

                            ),



                            child:
                                Text(

                              order.status,


                              style:
                                  const TextStyle(

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),

                          ),



                        ],

                      ),






                      const SizedBox(
                        height:12,
                      ),






                      Text(

                        "Harga : Rp ${order.price.toInt()}",

                      ),





                      Text(

                        "Jumlah : ${order.quantity}",

                      ),





                      Text(

                        "Total : Rp ${(order.price * order.quantity).toInt()}",

                        style:
                            const TextStyle(

                          color:
                              Colors.green,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),





                    ],

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