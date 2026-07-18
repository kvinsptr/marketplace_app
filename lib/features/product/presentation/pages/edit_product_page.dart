import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/product_model.dart';

import '../providers/product_provider.dart';



class EditProductPage extends ConsumerStatefulWidget {

  final ProductModel product;


  const EditProductPage({

    super.key,

    required this.product,

  });



  @override
  ConsumerState<EditProductPage> createState() =>
      _EditProductPageState();

}





class _EditProductPageState
    extends ConsumerState<EditProductPage> {



  late TextEditingController nameController;

  late TextEditingController priceController;

  late TextEditingController descController;



  bool isLoading = false;







  @override
  void initState() {

    super.initState();



    nameController =
        TextEditingController(
          text: widget.product.name,
        );



    priceController =
        TextEditingController(
          text: widget.product.price.toString(),
        );



    descController =
        TextEditingController(
          text: widget.product.description,
        );

  }







  @override
  void dispose() {


    nameController.dispose();

    priceController.dispose();

    descController.dispose();


    super.dispose();

  }








  Future<void> updateProduct() async {



    if(nameController.text.trim().isEmpty ||
       priceController.text.trim().isEmpty){



      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(
                "Nama dan harga wajib diisi",
              ),

        ),

      );


      return;

    }







    setState(() {

      isLoading = true;

    });







    final updatedProduct =
        ProductModel(


      id:
          widget.product.id,


      name:
          nameController.text.trim(),


      price:
          double.tryParse(
            priceController.text.trim(),
          ) ??
          0,


      description:
          descController.text.trim(),


      sellerId:
          widget.product.sellerId,


      imageUrl:
          widget.product.imageUrl,


    );







    await ref
        .read(
          productRepositoryProvider,
        )
        .updateProduct(
          updatedProduct,
        );







    if(!mounted) return;





    setState(() {

      isLoading = false;

    });







    Navigator.pop(context);



  }










  @override
  Widget build(BuildContext context) {


    return Scaffold(



      appBar: AppBar(


        title:
            const Text(
              "Edit Produk",
            ),



        backgroundColor:
            Colors.deepPurple,



        foregroundColor:
            Colors.white,


      ),






      body:
          SingleChildScrollView(



        padding:
            const EdgeInsets.all(16),



        child:
            Column(



          children: [






            TextField(


              controller:
                  nameController,


              decoration:
                  const InputDecoration(

                labelText:
                    "Nama Produk",

              ),


            ),






            const SizedBox(
              height:15,
            ),







            TextField(


              controller:
                  priceController,


              keyboardType:
                  TextInputType.number,


              decoration:
                  const InputDecoration(

                labelText:
                    "Harga",

              ),



            ),







            const SizedBox(
              height:15,
            ),







            TextField(


              controller:
                  descController,


              maxLines:
                  5,


              decoration:
                  const InputDecoration(

                labelText:
                    "Deskripsi Produk",

              ),



            ),







            const SizedBox(
              height:30,
            ),








            SizedBox(


              width:
                  double.infinity,


              height:
                  50,



              child:
                  ElevatedButton(



                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      Colors.deepPurple,

                ),





                onPressed:
                    isLoading
                    ? null
                    : updateProduct,







                child:


                    isLoading


                    ?


                    const CircularProgressIndicator(
                      color: Colors.white,
                    )


                    :


                    const Text(

                      "Update Produk",

                      style:
                          TextStyle(

                        color:
                            Colors.white,

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