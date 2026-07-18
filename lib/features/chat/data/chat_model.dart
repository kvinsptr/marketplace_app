class ChatModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime createdAt;

  ChatModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "createdAt": createdAt,
    };
  }

  factory ChatModel.fromMap(
      Map<String, dynamic> map,
      String id) {
    return ChatModel(
      id: id,
      senderId: map["senderId"],
      receiverId: map["receiverId"],
      message: map["message"],
      createdAt: map["createdAt"].toDate(),
    );
  }
}