import 'package:flutter/material.dart';

import '../../../product/presentation/pages/add_product_page.dart';



class SellerProductsPage extends StatefulWidget {

  const SellerProductsPage({
    super.key,
  });


  @override
  State<SellerProductsPage> createState() =>
      _SellerProductsPageState();

}




class _SellerProductsPageState
    extends State<SellerProductsPage> {


  final List<Map<String, dynamic>> products = [];



  void openAddProduct() async {


    await Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const AddProductPage(),

      ),

    );


  }





  @override
  Widget build(BuildContext context) {


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


        onPressed:
            openAddProduct,


        icon:
            const Icon(
              Icons.add,
            ),


        label:
            const Text(
              "Tambah",
            ),


      ),





      body: products.isEmpty


          ? Center(


              child: Column(


                mainAxisAlignment:
                    MainAxisAlignment.center,


                children: [


                  const Icon(

                    Icons.inventory_2_outlined,

                    size:
                        80,

                    color:
                        Colors.grey,

                  ),



                  const SizedBox(
                    height:15,
                  ),



                  const Text(

                    "Belum ada produk",

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

                    "Tambahkan produk pertama Anda",

                  ),


                ],

              ),

            )



          : ListView.builder(


              padding:
                  const EdgeInsets.all(16),



              itemCount:
                  products.length,



              itemBuilder:
                  (context,index){


                final product =
                    products[index];



                return Card(

                  child: ListTile(


                    leading:
                        const Icon(

                      Icons.inventory,

                      color:
                          Colors.deepPurple,

                    ),



                    title:
                        Text(

                      product["name"],

                    ),



                    subtitle:
                        Text(

                      "Rp${product["price"]}",

                    ),



                  ),

                );


              },

            ),


    );

  }

}