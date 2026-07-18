import 'package:dio/dio.dart';

class PaymentService {
  PaymentService._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://your-api.com/api',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  static Future<String> createTransaction({
    required double total,
    required String userId,
  }) async {
    try {
      final response = await _dio.post(
        '/payment/create',
        data: {
          "user_id": userId,
          "total": total,
        },
      );

      return response.data["payment_url"];
    } catch (e) {
      throw Exception("Gagal membuat transaksi");
    }
  }
}