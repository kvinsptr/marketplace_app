import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/presentation/providers/product_provider.dart';
import '../../../product/domain/models/product_model.dart';



class AdminProductsPage extends ConsumerWidget {

  const AdminProductsPage({
    super.key,
  });



  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {


    final products =
        ref.watch(productProvider);



    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
              "Semua Produk",
            ),

        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,

      ),



      body:

      products.when(


        loading: (){

          return const Center(

            child:
                CircularProgressIndicator(),

          );

        },



        error:(error,stack){


          return Center(

            child:
                Text(
                  error.toString(),
                ),

          );


        },




        data:(items){



          if(items.isEmpty){

            return const Center(

              child:
                  Text(
                    "Belum ada produk",
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



              final ProductModel product =
                  items[index];





              return Card(


                margin:
                    const EdgeInsets.only(
                      bottom:15,
                    ),



                child:
                    ListTile(



                  leading:
                      ClipRRect(

                    borderRadius:
                        BorderRadius.circular(10),


                    child:
                        Image.network(

                      product.imageUrl,


                      width:
                          55,


                      height:
                          55,


                      fit:
                          BoxFit.cover,



                      errorBuilder:
                          (context,error,stack){


                        return const Icon(
                          Icons.image,
                        );


                      },

                    ),

                  ),





                  title:
                      Text(
                        product.name,
                      ),





                  subtitle:
                      Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,


                    children:[


                      Text(
                        "Rp ${product.price}",
                      ),


                      Text(
                        "Seller : ${product.sellerId}",
                      ),


                    ],


                  ),





                  trailing:
                      IconButton(


                    icon:
                        const Icon(

                          Icons.delete,

                          color:
                              Colors.red,

                        ),




                    onPressed:() async {



                      final confirm =
                          await showDialog<bool>(


                        context:
                            context,



                        builder:(context){


                          return AlertDialog(


                            title:
                                const Text(
                                  "Hapus Produk?",
                                ),




                            content:
                                Text(
                                  product.name,
                                ),




                            actions:[



                              TextButton(


                                onPressed:(){

                                  Navigator.pop(
                                    context,
                                    false,
                                  );

                                },


                                child:
                                    const Text(
                                      "Batal",
                                    ),


                              ),




                              TextButton(


                                onPressed:(){


                                  Navigator.pop(
                                    context,
                                    true,
                                  );


                                },


                                child:
                                    const Text(
                                      "Hapus",
                                    ),


                              ),



                            ],



                          );


                        },


                      );






                      if(confirm == true){


                        ScaffoldMessenger.of(context)
                            .showSnackBar(


                          const SnackBar(

                            content:
                                Text(
                                  "Fitur hapus siap disambungkan",
                                ),

                          ),


                        );


                      }



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