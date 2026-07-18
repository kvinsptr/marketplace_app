import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../auth/presentation/providers/auth_provider.dart';

import '../providers/seller_order_provider.dart';





class SellerOrdersPage extends ConsumerWidget {


  const SellerOrdersPage({
    super.key,
  });






  Future<void> updateStatus(
      WidgetRef ref,
      String orderId,
      String status,
      ) async {


    await ref
        .read(
          sellerOrderRepositoryProvider,
        )
        .updateOrderStatus(

          orderId,

          status,

        );


  }







  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {



    final user =
        ref.watch(authProvider)
            .user;




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
              "Pesanan Seller",
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



                child:
                    ListTile(



                  leading:
                      const Icon(
                        Icons.shopping_bag,
                      ),





                  title:
                      Text(

                    order["productName"] ??
                    "Produk",

                  ),





                  subtitle:
                      Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,


                    children: [


                      Text(
                        "Jumlah: ${order["quantity"] ?? 1}",
                      ),


                      Text(
                        "Status: ${order["status"] ?? "pending"}",
                      ),


                    ],


                  ),






                  trailing:
                      PopupMenuButton(



                    itemBuilder:
                        (context)=>[



                      const PopupMenuItem(

                        value:
                            "diproses",

                        child:
                            Text(
                              "Diproses",
                            ),

                      ),




                      const PopupMenuItem(

                        value:
                            "dikirim",

                        child:
                            Text(
                              "Dikirim",
                            ),

                      ),




                      const PopupMenuItem(

                        value:
                            "selesai",

                        child:
                            Text(
                              "Selesai",
                            ),

                      ),



                    ],




                    onSelected:(value){


                      updateStatus(

                        ref,

                        order["id"],

                        value.toString(),

                      );


                    },



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