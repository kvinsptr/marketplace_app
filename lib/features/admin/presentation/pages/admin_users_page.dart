import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../providers/admin_user_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';



class AdminUsersPage extends ConsumerWidget {


  const AdminUsersPage({
    super.key,
  });



  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final users =
        ref.watch(adminUsersProvider);



    return Scaffold(


      appBar:
          AppBar(

        title:
            const Text(
              "User Management",
            ),

        backgroundColor:
            Colors.deepPurple,

        foregroundColor:
            Colors.white,

      ),





      body:
          users.when(


        loading: () =>

            const Center(

              child:
                  CircularProgressIndicator(),

            ),




        error: (e, _) =>

            Center(

              child:
                  Text(
                    e.toString(),
                  ),

            ),






        data: (userList){



          if(userList.isEmpty){

            return const Center(

              child:
                  Text(
                    "Belum ada user",
                  ),

            );

          }




          return ListView.builder(


            padding:
                const EdgeInsets.all(16),



            itemCount:
                userList.length,



            itemBuilder:
                (context,index){



              final UserEntity user =
                  userList[index];




              return Card(


                margin:
                    const EdgeInsets.only(
                      bottom:12,
                    ),



                child:
                    ListTile(



                  leading:
                      CircleAvatar(

                    child:
                        Text(

                          user.role
                              .substring(0,1)
                              .toUpperCase(),

                        ),

                  ),





                  title:
                      Text(
                        user.email,
                      ),





                  subtitle:
                      Text(
                        "Role : ${user.role}",
                      ),





                  trailing:
                      PopupMenuButton<String>(


                    onSelected:
                        (value) async {



                      if(value == "delete"){



                        await ref
                            .read(
                              authProvider
                              .notifier,
                            )
                            .deleteUserData(
                              user.uid,
                            );



                      }else{



                        await ref
                            .read(
                              authProvider
                              .notifier,
                            )
                            .updateUserRole(

                              user.uid,

                              value,

                            );


                      }



                    },



                    itemBuilder:
                        (context){


                      return [


                        const PopupMenuItem(

                          value:
                              "buyer",

                          child:
                              Text(
                                "Jadikan Buyer",
                              ),

                        ),



                        const PopupMenuItem(

                          value:
                              "seller",

                          child:
                              Text(
                                "Jadikan Seller",
                              ),

                        ),




                        const PopupMenuItem(

                          value:
                              "admin",

                          child:
                              Text(
                                "Jadikan Admin",
                              ),

                        ),



                        const PopupMenuItem(

                          value:
                              "delete",

                          child:
                              Text(
                                "Hapus User",
                              ),

                        ),


                      ];


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