class OrderModel {
  final String id;

  final String buyerId;
  final String sellerId;

  final String productId;
  final String productName;
  final String imageUrl;

  final double price;
  final int quantity;

  final String status;
  final String paymentMethod;

  final DateTime? createdAt;


  const OrderModel({

    required this.id,

    required this.buyerId,

    required this.sellerId,

    required this.productId,

    required this.productName,

    required this.imageUrl,

    required this.price,

    required this.quantity,

    required this.status,

    required this.paymentMethod,

    this.createdAt,

  });



  double get totalPrice =>
      price * quantity;



  factory OrderModel.fromMap(
    Map<String,dynamic> map,
    String id,
  ){

    return OrderModel(

      id: id,


      buyerId:
          map['buyerId'] ?? '',


      sellerId:
          map['sellerId'] ?? '',


      productId:
          map['productId'] ?? '',


      productName:
          map['productName'] ?? '',


      imageUrl:
          map['imageUrl'] ?? '',


      price:
          (map['price'] ?? 0).toDouble(),


      quantity:
          map['quantity'] ?? 1,


      status:
          map['status'] ?? 'pending',


      paymentMethod:
          map['paymentMethod'] ?? '',


      createdAt:
          map['createdAt'] != null
          ? (map['createdAt']).toDate()
          : null,

    );

  }





  Map<String,dynamic> toMap(){

    return {

      'buyerId':
          buyerId,


      'sellerId':
          sellerId,


      'productId':
          productId,


      'productName':
          productName,


      'imageUrl':
          imageUrl,


      'price':
          price,


      'quantity':
          quantity,


      'status':
          status,


      'paymentMethod':
          paymentMethod,


      'createdAt':
          createdAt,

    };

  }


}