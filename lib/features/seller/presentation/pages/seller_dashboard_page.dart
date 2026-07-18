import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../product/presentation/pages/add_product_page.dart';

import 'seller_products_page.dart';
import 'seller_orders_page.dart';
import 'seller_chat_page.dart';



class SellerDashboardPage extends ConsumerWidget {

  const SellerDashboardPage({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final authState = ref.watch(authProvider);

    final user = authState.user;



    return Scaffold(

      backgroundColor:
          const Color(0xffF5F6FA),



      appBar: AppBar(

        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,

        centerTitle:
            true,

        title:
            const Text(
              "Seller Dashboard",
            ),



        actions: [

          IconButton(

            onPressed: () async {

              await ref
                  .read(authProvider.notifier)
                  .logout();

            },


            icon:
                const Icon(
                  Icons.logout,
                ),

          ),

        ],

      ),



      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(16),



        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [



            Container(

              padding:
                  const EdgeInsets.all(20),


              width:
                  double.infinity,


              decoration:
                  BoxDecoration(

                gradient:
                    const LinearGradient(

                  colors: [

                    Colors.deepPurple,

                    Colors.purple,

                  ],

                ),


                borderRadius:
                    BorderRadius.circular(20),

              ),



              child: Row(

                children: [


                  const CircleAvatar(

                    radius:
                        32,


                    backgroundColor:
                        Colors.white,


                    child:
                        Icon(

                      Icons.store,

                      color:
                          Colors.deepPurple,

                      size:
                          35,

                    ),

                  ),



                  const SizedBox(
                    width:16,
                  ),



                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,


                      children: [


                        const Text(

                          "Halo Seller 👋",

                          style:
                              TextStyle(

                            color:
                                Colors.white70,

                          ),

                        ),



                        const SizedBox(
                          height:6,
                        ),



                        Text(

                          user?.email ?? "-",

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontSize:
                                18,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),


                      ],

                    ),

                  ),


                ],

              ),

            ),




            const SizedBox(
              height:25,
            ),



            const Text(

              "Menu",

              style:
                  TextStyle(

                fontSize:
                    20,

                fontWeight:
                    FontWeight.bold,

              ),

            ),




            const SizedBox(
              height:15,
            ),




            GridView.count(

              crossAxisCount:
                  2,


              shrinkWrap:
                  true,


              physics:
                  const NeverScrollableScrollPhysics(),



              children: [



                DashboardCard(

                  icon:
                      Icons.inventory_2_outlined,


                  title:
                      "Produk Saya",



                  onTap: () {


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            const SellerProductsPage(),

                      ),

                    );


                  },

                ),





                DashboardCard(

                  icon:
                      Icons.add_box_outlined,


                  title:
                      "Tambah Produk",



                  onTap: () {


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            const AddProductPage(),

                      ),

                    );


                  },

                ),





                DashboardCard(

                  icon:
                      Icons.shopping_bag_outlined,


                  title:
                      "Pesanan",



                  onTap: () {


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            const SellerOrdersPage(),

                      ),

                    );


                  },

                ),





                DashboardCard(

                  icon:
                      Icons.chat_bubble_outline,


                  title:
                      "Chat Buyer",



                  onTap: () {


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            const SellerChatPage(),

                      ),

                    );


                  },

                ),


              ],

            ),





            const SizedBox(
              height:25,
            ),




            const Text(

              "Statistik Penjualan",

              style:
                  TextStyle(

                fontSize:
                    20,

                fontWeight:
                    FontWeight.bold,

              ),

            ),




            const SizedBox(
              height:15,
            ),




            const _StatCard(),



          ],

        ),

      ),

    );

  }

}






class DashboardCard extends StatelessWidget {


  final IconData icon;

  final String title;

  final VoidCallback onTap;



  const DashboardCard({

    super.key,

    required this.icon,

    required this.title,

    required this.onTap,

  });



  @override
  Widget build(BuildContext context) {


    return InkWell(

      borderRadius:
          BorderRadius.circular(20),


      onTap:
          onTap,



      child: Container(

        margin:
            const EdgeInsets.all(8),


        decoration:
            BoxDecoration(

          color:
              Colors.white,


          borderRadius:
              BorderRadius.circular(20),

        ),



        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,


          children: [



            Icon(

              icon,

              size:
                  40,

              color:
                  Colors.deepPurple,

            ),



            const SizedBox(
              height:10,
            ),




            Text(

              title,

              textAlign:
                  TextAlign.center,


              style:
                  const TextStyle(

                fontWeight:
                    FontWeight.bold,

              ),

            ),



          ],

        ),

      ),

    );

  }

}






class _StatCard extends StatelessWidget {


  const _StatCard();



  @override
  Widget build(BuildContext context) {


    return Container(

      padding:
          const EdgeInsets.all(20),


      decoration:
          BoxDecoration(

        color:
            Colors.white,


        borderRadius:
            BorderRadius.circular(20),

      ),



      child:
          const Column(

        children: [



          _RowStat(

            title:
                "Total Produk",

            value:
                "0",

          ),



          Divider(),



          _RowStat(

            title:
                "Total Pesanan",

            value:
                "0",

          ),



          Divider(),



          _RowStat(

            title:
                "Pendapatan",

            value:
                "Rp0",

          ),



        ],

      ),

    );

  }

}






class _RowStat extends StatelessWidget {


  final String title;

  final String value;



  const _RowStat({

    required this.title,

    required this.value,

  });



  @override
  Widget build(BuildContext context) {


    return Row(

      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,


      children: [



        Text(title),



        Text(

          value,

          style:
              const TextStyle(

            fontWeight:
                FontWeight.bold,

          ),

        ),



      ],

    );

  }

}