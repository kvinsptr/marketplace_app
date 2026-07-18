class ProductModel {


  final String id;

  final String name;

  final String price;

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





  factory ProductModel.fromMap(
      Map<String,dynamic> map,
      String id,
      ){

    return ProductModel(

      id: id,

      name: map["name"] ?? "",

      price: map["price"] ?? "",

      description: map["description"] ?? "",

      sellerId: map["sellerId"] ?? "",

      imageUrl: map["imageUrl"] ?? "",

    );

  }





  Map<String,dynamic> toMap(){

    return {


      "name": name,

      "price": price,

      "description": description,

      "sellerId": sellerId,

      "imageUrl": imageUrl,


    };


  }


}