import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();

  static Future<void> initialize() async {
    await Hive.initFlutter();

    await Future.wait([
      Hive.openBox('settings'),
      Hive.openBox('cart'),
      Hive.openBox('cache'),
    ]);
  }
}