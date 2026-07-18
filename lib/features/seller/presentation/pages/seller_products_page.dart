import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

import '../../../product/domain/models/product_model.dart';

import '../../../product/presentation/providers/product_provider.dart';

import '../../../product/presentation/pages/add_product_page.dart';
import '../../../product/presentation/pages/edit_product_page.dart';



class SellerProductsPage extends ConsumerWidget {

  const SellerProductsPage({
    super.key,
  });



  Future<void> deleteProduct(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {

    await ref
        .read(
          productRepositoryProvider,
        )
        .deleteProduct(id);



    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(
        content:
            Text(
              "Produk berhasil dihapus",
            ),
      ),

    );

  }





  void confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) {

    showDialog(

      context: context,

      builder: (context){

        return AlertDialog(

          title:
              const Text(
                "Hapus Produk",
              ),


          content:
              const Text(
                "Yakin ingin menghapus produk ini?",
              ),



          actions: [


            TextButton(

              onPressed: (){

                Navigator.pop(context);

              },

              child:
                  const Text(
                    "Batal",
                  ),

            ),




            ElevatedButton(

              onPressed: (){

                Navigator.pop(context);


                deleteProduct(
                  context,
                  ref,
                  id,
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






    final products =
        ref.watch(
          productProvider,
        );






    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Produk Saya",
            ),

        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,

      ),







      floatingActionButton:
          FloatingActionButton.extended(


        backgroundColor:
            Colors.deepPurple,


        foregroundColor:
            Colors.white,


        onPressed: (){


          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const AddProductPage(),

            ),

          );


        },


        icon:
            const Icon(
              Icons.add,
            ),



        label:
            const Text(
              "Tambah",
            ),


      ),







      body:

      products.when(



        loading: ()=>


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



          final sellerItems =
              items
                  .where(
                    (product) =>
                        product.sellerId ==
                        user.uid,
                  )
                  .toList();






          if(sellerItems.isEmpty){


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
                sellerItems.length,



            itemBuilder:
                (context,index){



              final ProductModel product =
                  sellerItems[index];







              return Card(


                margin:
                    const EdgeInsets.only(
                      bottom:12,
                    ),



                child:
                    ListTile(



                  leading:

                      CircleAvatar(

                        backgroundColor:
                            Colors.deepPurple,


                        child:
                            const Icon(

                          Icons.inventory,

                          color:
                              Colors.white,

                        ),

                      ),






                  title:
                      Text(

                    product.name,

                    style:
                        const TextStyle(

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),






                  subtitle:
                      Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,


                    children: [


                      Text(
                        "Rp ${product.price}",
                      ),


                      Text(
                        product.description,
                      ),


                    ],


                  ),







                  trailing:
                      PopupMenuButton(



                    itemBuilder:(context)=>[



                      const PopupMenuItem(

                        value:
                            "edit",

                        child:
                            Text(
                              "Edit",
                            ),

                      ),






                      const PopupMenuItem(

                        value:
                            "delete",

                        child:
                            Text(
                              "Hapus",
                            ),

                      ),



                    ],





                    onSelected:(value){



                      if(value=="edit"){



                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                                EditProductPage(

                                  product:
                                      product,

                                ),

                          ),

                        );


                      }






                      if(value=="delete"){


                        confirmDelete(

                          context,

                          ref,

                          product.id,

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