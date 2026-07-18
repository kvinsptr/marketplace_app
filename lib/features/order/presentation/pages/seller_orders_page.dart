import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/order_provider.dart';





class SellerOrdersPage extends ConsumerWidget {


  const SellerOrdersPage({
    super.key,
  });






  Future<void> updateStatus(
      WidgetRef ref,
      String id,
      String status,
      ) async {


    await ref
        .read(orderRepositoryProvider)
        .updateOrderStatus(
          id,
          status,
        );


  }








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
          sellerOrdersProvider(
            user.uid,
          ),
        );








    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Pesanan Masuk",
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





        error:(error,stack)=>

            Center(

              child:
                  Text(
                    error.toString(),
                  ),

            ),







        data:(items){



          if(items.isEmpty){


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






                      const SizedBox(
                        height:10,
                      ),






                      Text(
                        "Buyer : ${order.buyerId}",
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






                      const SizedBox(
                        height:15,
                      ),





                      DropdownButtonFormField<String>(


                        value:
                            order.status,



                        decoration:
                            const InputDecoration(

                          labelText:
                              "Status Pesanan",

                          border:
                              OutlineInputBorder(),

                        ),





                        items:
                            const [


                          DropdownMenuItem(

                            value:
                                "pending",

                            child:
                                Text(
                                  "Pending",
                                ),

                          ),




                          DropdownMenuItem(

                            value:
                                "diproses",

                            child:
                                Text(
                                  "Diproses",
                                ),

                          ),




                          DropdownMenuItem(

                            value:
                                "dikirim",

                            child:
                                Text(
                                  "Dikirim",
                                ),

                          ),




                          DropdownMenuItem(

                            value:
                                "selesai",

                            child:
                                Text(
                                  "Selesai",
                                ),

                          ),



                        ],





                        onChanged:(value){


                          if(value == null)
                            return;



                          updateStatus(

                            ref,

                            order.id,

                            value,

                          );


                        },


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