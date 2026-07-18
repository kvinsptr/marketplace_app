import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../product/domain/models/product_model.dart';

import '../../../product/presentation/providers/product_provider.dart';

import '../../../product/presentation/pages/product_detail_page.dart';


import '../../../wishlist/domain/entities/wishlist_item.dart';

import '../../../wishlist/presentation/providers/wishlist_provider.dart';



class HomePage extends ConsumerStatefulWidget {


  const HomePage({
    super.key,
  });



  @override
  ConsumerState<HomePage> createState() =>
      _HomePageState();


}





class _HomePageState extends ConsumerState<HomePage> {


  String searchQuery = '';




  @override
  Widget build(BuildContext context) {



    final productsAsync =
        ref.watch(productProvider);




    return Scaffold(


      body:
          SafeArea(


        child:
            productsAsync.when(



          loading: () =>

              const Center(

            child:
                CircularProgressIndicator(),

          ),





          error: (error, stack) =>

              Center(

            child:
                Text(
                  error.toString(),
                ),

          ),





          data: (products){



            final filteredProducts =
                products.where((product){


              return product.name
                  .toLowerCase()
                  .contains(
                    searchQuery.toLowerCase(),
                  );


            }).toList();







            return SingleChildScrollView(



              padding:
                  const EdgeInsets.all(20),



              child:
                  Column(



                crossAxisAlignment:
                    CrossAxisAlignment.start,



                children: [





                  Row(


                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,



                    children: [


                      const Column(


                        crossAxisAlignment:
                            CrossAxisAlignment.start,


                        children: [


                          Text(

                            "Marketplace",

                            style:
                                TextStyle(

                              fontSize:
                                  28,

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          ),



                          SizedBox(
                            height:4,
                          ),



                          Text(
                            "Temukan produk terbaik",
                            style:
                                TextStyle(
                                  color:
                                      Colors.grey,
                                ),
                          ),



                        ],

                      ),




                      const CircleAvatar(

                        radius:
                            24,

                        child:
                            Icon(
                              Icons.person,
                            ),

                      ),



                    ],


                  ),







                  const SizedBox(
                    height:25,
                  ),






                  TextField(



                    onChanged:(value){


                      setState((){

                        searchQuery =
                            value;

                      });


                    },



                    decoration:
                        InputDecoration(



                      hintText:
                          "Cari produk...",


                      prefixIcon:
                          const Icon(
                            Icons.search,
                          ),



                      filled:
                          true,



                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                              18,
                            ),

                        borderSide:
                            BorderSide.none,

                      ),



                    ),



                  ),






                  const SizedBox(
                    height:25,
                  ),







                  Container(


                    height:
                        180,


                    width:
                        double.infinity,



                    decoration:
                        BoxDecoration(



                      borderRadius:
                          BorderRadius.circular(
                            24,
                          ),



                      gradient:
                          const LinearGradient(

                        colors: [

                          Color(
                            0xff6C63FF,
                          ),

                          Color(
                            0xff9C27B0,
                          ),

                        ],

                      ),


                    ),




                    child:
                        const Center(


                      child:
                          Column(



                        mainAxisAlignment:
                            MainAxisAlignment.center,



                        children: [



                          Text(

                            "BIG SALE",

                            style:
                                TextStyle(

                              color:
                                  Colors.white,

                              fontSize:
                                  32,

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          ),





                          SizedBox(
                            height:8,
                          ),





                          Text(

                            "Diskon hingga 50%",

                            style:
                                TextStyle(

                              color:
                                  Colors.white70,

                              fontSize:
                                  18,

                            ),

                          ),



                        ],



                      ),


                    ),


                  ),








                  const SizedBox(
                    height:30,
                  ),





                  const Text(

                    "Produk Populer",

                    style:
                        TextStyle(

                      fontSize:
                          22,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),







                  const SizedBox(
                    height:20,
                  ),







                  filteredProducts.isEmpty



                  ?


                  const Center(

                    child:
                        Text(
                          "Produk tidak ditemukan",
                        ),

                  )



                  :



                  GridView.builder(



                    shrinkWrap:
                        true,



                    physics:
                        const NeverScrollableScrollPhysics(),




                    itemCount:
                        filteredProducts.length,




                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(



                      crossAxisCount:
                          2,



                      crossAxisSpacing:
                          15,



                      mainAxisSpacing:
                          15,



                      childAspectRatio:
                          .72,


                    ),






                    itemBuilder:(context,index){



                      final ProductModel product =
                          filteredProducts[index];






                      final favorite =
                          ref.watch(
                            wishlistProvider,
                          )
                          .any(
                            (item)=>
                                item.id ==
                                product.id,
                          );






                      return GestureDetector(



                        onTap:(){


                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder:(_)=>
                                  ProductDetailPage(

                                product:
                                    product,

                              ),

                            ),

                          );


                        },




                        child:
                            Container(



                          decoration:
                              BoxDecoration(

                            borderRadius:
                                BorderRadius.circular(
                                  20,
                                ),

                            color:
                                Theme.of(context)
                                    .cardColor,

                          ),





                          child:
                              Column(



                            crossAxisAlignment:
                                CrossAxisAlignment.start,



                            children: [





                              Expanded(



                                child:
                                    ClipRRect(



                                  borderRadius:
                                      const BorderRadius.vertical(

                                    top:
                                        Radius.circular(
                                          20,
                                        ),

                                  ),




                                  child:
                                      Image.network(

                                    product.imageUrl,


                                    width:
                                        double.infinity,


                                    fit:
                                        BoxFit.cover,



                                    errorBuilder:
                                        (_,__,___){


                                      return const Center(

                                        child:
                                            Icon(
                                              Icons.image,
                                            ),

                                      );


                                    },

                                  ),


                                ),


                              ),






                              Padding(


                                padding:
                                    const EdgeInsets.all(
                                      12,
                                    ),



                                child:
                                    Column(



                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,



                                  children: [



                                    Text(

                                      product.name,

                                      maxLines:
                                          1,

                                      overflow:
                                          TextOverflow.ellipsis,

                                    ),





                                    const SizedBox(
                                      height:8,
                                    ),






                                    Text(

                                      "Rp ${product.price.toInt()}",


                                      style:
                                          const TextStyle(

                                        color:
                                            Colors.green,

                                        fontWeight:
                                            FontWeight.bold,

                                      ),


                                    ),





                                    IconButton(

                                      icon:
                                          Icon(

                                        favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,

                                        color:
                                            Colors.red,

                                      ),



                                      onPressed:(){


                                        ref
                                            .read(
                                              wishlistProvider.notifier,
                                            )
                                            .toggle(

                                          WishlistItem(

                                            id:
                                                product.id,

                                            name:
                                                product.name,

                                            imageUrl:
                                                product.imageUrl,

                                            price:
                                                product.price,

                                          ),

                                        );


                                      },


                                    ),



                                  ],



                                ),


                              ),




                            ],



                          ),


                        ),



                      );


                    },

                  ),




                ],


              ),


            );


          },


        ),


      ),



    );

  }

}