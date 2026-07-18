import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../order/presentation/providers/order_provider.dart';



class AdminOrdersPage extends ConsumerWidget {


  const AdminOrdersPage({
    super.key,
  });




  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {



    final orders =
        ref.watch(
          allOrdersProvider,
        );




    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Semua Pesanan",
            ),

        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,

      ),




      body:

      orders.when(



        data:(data){



          if(data.isEmpty){


            return const Center(

              child:
                  Text(
                    "Belum ada pesanan",
                  ),

            );


          }





          return ListView.builder(


            padding:
                const EdgeInsets.all(16),



            itemCount:
                data.length,



            itemBuilder:
                (context,index){



              final order =
                  data[index];




              return Card(


                margin:
                    const EdgeInsets.only(
                      bottom:15,
                    ),



                child:
                    Padding(

                  padding:
                      const EdgeInsets.all(15),


                  child:
                      Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,


                    children:[



                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,


                        children:[


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



                          Text(

                            "Rp ${order.price.toInt()}",


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





                      const SizedBox(
                        height:10,
                      ),






                      Text(
                        "Buyer : ${order.buyerId}",
                      ),



                      Text(
                        "Seller : ${order.sellerId}",
                      ),




                      Text(
                        "Jumlah : ${order.quantity}",
                      ),




                      Text(
                        "Pembayaran : ${order.paymentMethod}",
                      ),




                      const SizedBox(
                        height:10,
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


                ),



              );



            },


          );



        },




        error:(e,_){


          return Center(

            child:
                Text(
                  e.toString(),
                ),

          );


        },





        loading:(){


          return const Center(

            child:
                CircularProgressIndicator(),

          );


        },


      ),


    );


  }



}