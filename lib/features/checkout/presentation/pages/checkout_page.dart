import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../payment/data/payment_service.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

import '../../../order/domain/models/order_model.dart';
import '../../../order/presentation/providers/order_provider.dart';

import 'success_page.dart';



class CheckoutPage extends ConsumerStatefulWidget {

  final double total;

  const CheckoutPage({
    super.key,
    required this.total,
  });


  @override
  ConsumerState<CheckoutPage> createState() =>
      _CheckoutPageState();

}





class _CheckoutPageState
    extends ConsumerState<CheckoutPage> {


  final List<String> paymentMethods = [

    'Transfer Bank',
    'E-Wallet',
    'COD',

  ];


  final PaymentService paymentService =
      PaymentService();



  String selectedPayment =
      'Transfer Bank';



  bool isLoading = false;





  Future<void> createOrders() async {


    final user =
        ref.read(authProvider).user;


    if(user == null){

      throw Exception(
        "User belum login",
      );

    }



    final cartItems =
        ref.read(cartProvider);



    for(final item in cartItems){



      final order = OrderModel(

        id: "",


        buyerId:
            user.uid,


        sellerId:
            item.product.sellerId,


        productId:
            item.product.id,


        productName:
            item.product.name,


        imageUrl:
            item.product.imageUrl,


        price:
            item.product.price,


        quantity:
            item.quantity,


        status:
            "pending",


        paymentMethod:
            selectedPayment,


      );





      await ref
          .read(
            orderNotifierProvider.notifier,
          )
          .createOrder(order);



    }


  }








  @override
  Widget build(BuildContext context) {


    final cartItems =
        ref.watch(cartProvider);



    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
              "Checkout",
            ),
      ),



      body:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),


        child:
            Column(

          children: [



            Card(

              child:
                  const ListTile(

                leading:
                    Icon(
                      Icons.location_on,
                    ),


                title:
                    Text(
                      "Alamat Pengiriman",
                      style:
                          TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                    ),


                subtitle:
                    Text(
                      "Jl. Merdeka No.123, Jakarta",
                    ),

              ),

            ),





            const SizedBox(height:20),





            Card(

              child:
                  Padding(

                padding:
                    const EdgeInsets.all(16),


                child:
                    DropdownButtonFormField<String>(


                  value:
                      selectedPayment,


                  decoration:
                      const InputDecoration(

                    labelText:
                        "Metode Pembayaran",

                    border:
                        OutlineInputBorder(),

                  ),



                  items:
                      paymentMethods
                          .map(

                    (method)=>DropdownMenuItem(

                      value:
                          method,

                      child:
                          Text(method),

                    ),

                  )
                          .toList(),




                  onChanged:(value){


                    if(value == null){

                      return;

                    }



                    setState((){

                      selectedPayment =
                          value;

                    });


                  },


                ),

              ),

            ),





            const SizedBox(height:25),





            Align(

              alignment:
                  Alignment.centerLeft,


              child:
                  Text(

                "Ringkasan Pesanan",

                style:
                    Theme.of(context)
                        .textTheme
                        .titleLarge,

              ),

            ),





            const SizedBox(height:15),





            Card(

              child:
                  ListView.builder(

                shrinkWrap:
                    true,


                physics:
                    const NeverScrollableScrollPhysics(),


                itemCount:
                    cartItems.length,


                itemBuilder:(context,index){


                  final item =
                      cartItems[index];



                  return ListTile(


                    leading:
                        CircleAvatar(

                      backgroundImage:
                          NetworkImage(
                            item.product.imageUrl,
                          ),

                    ),



                    title:
                        Text(
                          item.product.name,
                        ),



                    subtitle:
                        Text(
                          "${item.quantity} x Rp ${item.product.price}",
                        ),



                    trailing:
                        Text(
                          "Rp ${item.totalPrice}",
                        ),


                  );


                },

              ),

            ),





            const SizedBox(height:30),





            Card(

              color:
                  Colors.green.shade50,


              child:
                  Padding(

                padding:
                    const EdgeInsets.all(18),


                child:
                    Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,


                  children: [


                    const Text(
                      "Total Pembayaran",
                    ),



                    Text(

                      "Rp ${widget.total.toInt()}",


                      style:
                          const TextStyle(

                        fontSize:
                            24,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Colors.green,

                      ),

                    ),


                  ],

                ),

              ),

            ),





            const SizedBox(height:30),





            SizedBox(

              width:
                  double.infinity,


              height:
                  55,


              child:
                  ElevatedButton.icon(

                icon:
                    const Icon(
                      Icons.payment,
                    ),



                label:
                    isLoading

                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )

                    : const Text(
                        "Bayar Sekarang",
                      ),




                onPressed:
                    isLoading
                    ? null
                    :
                    () async {


                  setState((){

                    isLoading = true;

                  });





                  final success =
                      await paymentService
                          .processPayment(

                    amount:
                        widget.total,


                    paymentMethod:
                        selectedPayment,

                  );





                  if(!mounted){
                    return;
                  }





                  if(success){


                    try{


                      await createOrders();



                      ref
                          .read(
                            cartProvider.notifier,
                          )
                          .clearCart();




                      Navigator.pushReplacement(

                        context,

                        MaterialPageRoute(

                          builder: (_)=>
                              const SuccessPage(),

                        ),

                      );



                    }catch(e){


                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        SnackBar(
                          content:
                              Text(
                                e.toString(),
                              ),
                        ),

                      );


                    }



                  }else{


                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(

                        content:
                            Text(
                              "Pembayaran gagal",
                            ),

                      ),

                    );


                  }





                  setState((){

                    isLoading = false;

                  });



                },


              ),

            ),



          ],

        ),

      ),

    );

  }

}