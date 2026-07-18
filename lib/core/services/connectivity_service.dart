import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StreamProvider<bool>((ref) {
  return ConnectivityService().connectionStream;
});

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<bool> get connectionStream async* {
    final initial = await _connectivity.checkConnectivity();
    yield !_isDisconnected(initial);

    yield* _connectivity.onConnectivityChanged.map(
      (result) => !_isDisconnected(result),
    );
  }

  bool _isDisconnected(List<ConnectivityResult> results) {
    return results.contains(ConnectivityResult.none);
  }

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return !_isDisconnected(result);
  }
}