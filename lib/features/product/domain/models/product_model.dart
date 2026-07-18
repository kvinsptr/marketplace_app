class ProductModel {


  final String id;
  final String name;
  final double price;
  final String description;
  final String sellerId;
  final String imageUrl;



  ProductModel({

    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.sellerId,
    required this.imageUrl,

  });





  Map<String, dynamic> toMap(){


    return {


      "name":
          name,


      "price":
          price,


      "description":
          description,


      "sellerId":
          sellerId,


      "imageUrl":
          imageUrl,


    };


  }







  factory ProductModel.fromMap(

      Map<String, dynamic> map,

      String id,

  ){


    return ProductModel(



      id:
          id,



      name:
          map['name'] ?? '',




      price:

          double.tryParse(

            map['price']
                .toString(),

          ) ?? 0,




      description:

          map['description'] ?? '',




      sellerId:

          map['sellerId'] ?? '',




      imageUrl:

          map['imageUrl'] ?? '',




    );


  }





}