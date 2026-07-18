import 'package:dio/dio.dart';

class PaymentService {
  final Dio dio = Dio();

  /// Simulasi pembayaran
  Future<bool> processPayment({
    required double amount,
    required String paymentMethod,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    return true;
  }

  /// Membuat transaksi (untuk Midtrans/Xendit nanti)
  Future<String> createTransaction({
    required String orderId,
    required double amount,
  }) async {
    // Contoh request ke backend nanti
    // final response = await dio.post('/payment/create');

    await Future.delayed(const Duration(seconds: 1));

    return "https://app.sandbox.midtrans.com";
  }
}