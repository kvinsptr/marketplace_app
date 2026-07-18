import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../checkout/presentation/pages/checkout_page.dart';
import '../providers/cart_provider.dart';


class CartPage extends ConsumerWidget {
  const CartPage({super.key});


  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {

    final cartItems = ref.watch(cartProvider);


    final total = cartItems.fold<double>(
      0,
      (sum, item) => sum + item.total,
    );


    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),


      body: cartItems.isEmpty

          ? Center(
              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.shopping_cart_outlined,

                    size: 120,

                    color: Colors.grey.shade400,
                  ),


                  const SizedBox(
                    height: 20,
                  ),


                  const Text(
                    "Keranjang Masih Kosong",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                  const SizedBox(
                    height: 10,
                  ),


                  Text(
                    "Yuk mulai belanja sekarang",

                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                ],
              ),
            )


          : ListView.builder(

              padding: const EdgeInsets.all(16),

              itemCount: cartItems.length,


              itemBuilder: (
                context,
                index,
              ) {


                final item = cartItems[index];


                return Container(

                  margin: const EdgeInsets.only(
                    bottom: 16,
                  ),


                  decoration: BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(20),


                    color:
                        Theme.of(context).cardColor,


                    boxShadow: [

                      BoxShadow(

                        color:
                            Colors.black.withValues(
                          alpha: 0.05,
                        ),


                        blurRadius: 10,


                        offset:
                            const Offset(0, 4),
                      ),

                    ],

                  ),


                  child: Padding(

                    padding:
                        const EdgeInsets.all(12),


                    child: Row(

                      children: [


                        ClipRRect(

                          borderRadius:
                              BorderRadius.circular(15),


                          child: Image.network(

                            item.image,


                            width: 90,

                            height: 90,


                            fit: BoxFit.cover,


                            errorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {

                              return Container(

                                width: 90,

                                height: 90,


                                color:
                                    Colors.grey.shade300,


                                child: const Icon(
                                  Icons.image,
                                ),

                              );

                            },

                          ),

                        ),



                        const SizedBox(
                          width: 15,
                        ),



                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,


                            children: [


                              Text(

                                item.name,


                                maxLines: 2,


                                overflow:
                                    TextOverflow.ellipsis,


                                style:
                                    const TextStyle(

                                  fontSize: 16,

                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),



                              const SizedBox(
                                height: 8,
                              ),



                              Text(

                                "Rp ${item.price.toInt()}",


                                style:
                                    const TextStyle(

                                  fontSize: 16,

                                  color: Colors.green,


                                  fontWeight:
                                      FontWeight.bold,

                                ),

                              ),



                              const SizedBox(
                                height: 10,
                              ),



                              Container(

                                decoration:
                                    BoxDecoration(

                                  borderRadius:
                                      BorderRadius.circular(
                                    30,
                                  ),


                                  color:
                                      Colors.grey.shade200,

                                ),


                                child: Row(

                                  mainAxisSize:
                                      MainAxisSize.min,


                                  children: [


                                    IconButton(

                                      onPressed: () {

                                        ref
                                            .read(
                                              cartProvider
                                                  .notifier,
                                            )
                                            .decreaseQty(
                                              item.id,
                                            );

                                      },


                                      icon:
                                          const Icon(
                                        Icons.remove,
                                      ),

                                    ),



                                    Text(

                                      item.quantity
                                          .toString(),


                                      style:
                                          const TextStyle(

                                        fontWeight:
                                            FontWeight.bold,

                                      ),

                                    ),



                                    IconButton(

                                      onPressed: () {

                                        ref
                                            .read(
                                              cartProvider
                                                  .notifier,
                                            )
                                            .increaseQty(
                                              item.id,
                                            );

                                      },


                                      icon:
                                          const Icon(
                                        Icons.add,
                                      ),

                                    ),

                                  ],

                                ),

                              ),

                            ],

                          ),

                        ),



                        IconButton(

                          onPressed: () {

                            ref
                                .read(
                                  cartProvider
                                      .notifier,
                                )
                                .removeItem(
                                  item.id,
                                );

                          },


                          icon: const Icon(

                            Icons.delete_outline,

                            color: Colors.red,

                          ),

                        ),

                      ],

                    ),

                  ),

                );

              },

            ),



      bottomNavigationBar: cartItems.isEmpty

          ? null


          : Container(

              padding:
                  const EdgeInsets.all(20),


              decoration: BoxDecoration(

                color:
                    Theme.of(context)
                        .scaffoldBackgroundColor,


                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black.withValues(
                      alpha: 0.05,
                    ),


                    blurRadius: 10,

                  ),

                ],

              ),


              child: Column(

                mainAxisSize:
                    MainAxisSize.min,


                children: [


                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,


                    children: [


                      const Text(

                        "Total",

                        style:
                            TextStyle(

                          fontSize: 18,

                        ),

                      ),



                      Text(

                        "Rp ${total.toInt()}",


                        style:
                            const TextStyle(

                          fontSize: 24,


                          color: Colors.green,


                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ],

                  ),



                  const SizedBox(
                    height: 15,
                  ),



                  SizedBox(

                    width:
                        double.infinity,


                    height:
                        55,


                    child:
                        ElevatedButton(

                      onPressed: () {


                        Navigator.push(

                          context,


                          MaterialPageRoute(

                            builder: (context) =>
                                CheckoutPage(
                              total: total,
                            ),

                          ),

                        );


                      },


                      child:
                          const Text(

                        "Checkout",


                        style:
                            TextStyle(

                          fontSize: 18,

                        ),

                      ),

                    ),

                  ),

                ],

              ),

            ),

    );

  }

}