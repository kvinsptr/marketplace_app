import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

import 'admin_users_page.dart';
import 'admin_products_page.dart';
import 'admin_orders_page.dart';



class AdminDashboardPage extends ConsumerWidget {


  const AdminDashboardPage({
    super.key,
  });




  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
  ) {


    return Scaffold(


      appBar: AppBar(


        title:
            const Text(
              "Admin Dashboard",
            ),



        backgroundColor:
            Colors.deepPurple,



        foregroundColor:
            Colors.white,



        actions: [


          IconButton(


            icon:
                const Icon(
                  Icons.logout,
                ),



            tooltip:
                "Logout",




            onPressed: () async {



              await ref
                  .read(authProvider.notifier)
                  .logout();




              if(context.mounted){


                Navigator.pushNamedAndRemoveUntil(

                  context,

                  '/login',

                  (route)=>false,

                );


              }



            },


          ),



        ],



      ),





      body:
          Padding(


        padding:
            const EdgeInsets.all(20),




        child:
            Column(


          children: [



            _menuCard(

              context,

              icon:
                  Icons.people,


              title:
                  "User Management",



              page:
                  const AdminUsersPage(),


            ),





            _menuCard(

              context,

              icon:
                  Icons.inventory,



              title:
                  "Product Management",



              page:
                  const AdminProductsPage(),


            ),






            _menuCard(

              context,

              icon:
                  Icons.shopping_cart,



              title:
                  "Order Management",



              page:
                  const AdminOrdersPage(),


            ),



          ],



        ),



      ),



    );


  }









Widget _menuCard(

    BuildContext context, {

    required IconData icon,

    required String title,

    required Widget page,

}) {


  return Card(


    margin:
        const EdgeInsets.only(
          bottom:15,
        ),




    child:
        ListTile(



      leading:
          CircleAvatar(


        child:
            Icon(icon),



      ),






      title:
          Text(


            title,


            style:
                const TextStyle(


              fontWeight:
                  FontWeight.bold,



            ),



          ),






      trailing:
          const Icon(

            Icons.arrow_forward_ios,

          ),






      onTap: (){


        Navigator.push(


          context,


          MaterialPageRoute(


            builder:(_)=>page,


          ),


        );


      },



    ),



  );


}



}